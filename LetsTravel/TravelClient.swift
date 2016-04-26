//
//  TravelClient.swift
//  LetsTravel
//
//  Created by TriNgo on 4/13/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit
import AFNetworking

let TravelClientSharedInstance = TravelClient()

class TravelClient: NSObject {
    
    let BASE_URL = "http://school.naptiengame.net/user"
    let functionSessionManager: AFHTTPSessionManager

    class var sharedInstance: TravelClient {
        get {
            return TravelClientSharedInstance;
        }
    }

    override init() {
        self.functionSessionManager = AFHTTPSessionManager(baseURL: NSURL(string: BASE_URL))
        self.functionSessionManager.requestSerializer = AFJSONRequestSerializer()
        self.functionSessionManager.responseSerializer = AFJSONResponseSerializer()
    }
    
    private func fetchData(dictionary: NSDictionary) -> NSDictionary?
    {
        let statusCode = dictionary["code"] as! Int
        if (statusCode != -1) {
            return dictionary["data"] as? NSDictionary
        }else {
            return nil
        }
    }
    
    private func fetchDataWithArray(dictionary: NSDictionary) -> [NSDictionary]?
    {
        let statusCode = dictionary["code"] as! Int
        if (statusCode != -1) {
            return dictionary["data"] as? [NSDictionary]
        }else {
            return nil
        }
    }
    
    private func generateError(response: AnyObject) -> NSError {
        let errorCode = (response as! NSDictionary)["code"] as! Int
        let errorMessage = (response as! NSDictionary)["msg"] as! String
        let error = NSError(domain: self.BASE_URL, code: errorCode, userInfo: ["error": errorMessage])
        
        return error
    }
    
    // Login
    func login(facebookId: String, fullName: String, avatarUrl: String, success: (User) -> (), failure: (NSError) -> ()) {
        let postData = ["facebook_id":facebookId, "full_name":fullName, "avatar_url":avatarUrl]
        let params = ["command": "U_LOGIN", "data" : postData]
        
        self.functionSessionManager.POST(BASE_URL, parameters: params, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let userDictionary = self.fetchData(response as! NSDictionary)
            if (userDictionary != nil) {
                let user = User(dictionary: userDictionary!)
                User.currentUser = user
                success(user)
            }else{
                failure(self.generateError(response!))
            }
        }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
            failure(error)
        })
    }
    
    // Logout
    func logout() {
        User.currentUser = nil
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }
    
    // Search places with category and province
    func searchPlaceViaCategoryAndProvince(provinceId: Int, categoryId: String, placeName: String, success: ([Place]) -> (), failure: (NSError) -> ()) {
        
        let postData = ["province_id":provinceId, "category_id":categoryId, "place_name":placeName]
        let params = ["command": "U_PLACE_SEARCH_CATEGORY", "data" : postData]
        
        self.functionSessionManager.POST(BASE_URL, parameters: params, progress: nil, success: { (task:NSURLSessionDataTask, response:AnyObject?) -> Void in
            let placesDictionary = self.fetchDataWithArray(response as! NSDictionary)
            if (placesDictionary != nil) {
                let places = Place.getPlaces(placesDictionary!)
                success(places)
            } else {
                failure(self.generateError(response!))
            }
        }, failure: { (task:NSURLSessionDataTask?, error:NSError) -> Void in
            failure(error)
        })
    }
    
    // Get province list
    func getProvinces(success: ([Province]) -> (), failure: (NSError) -> ()) {
        let params = ["command": "U_PROVINCE_LIST", "data" : ""]
        
        self.functionSessionManager.POST(BASE_URL, parameters: params, progress: nil, success: { (task:NSURLSessionDataTask, response:AnyObject?) -> Void in
            let provinceDictionaries = self.fetchDataWithArray(response as! NSDictionary)
            if (provinceDictionaries != nil) {
                let provinces = Province.getProvinces(provinceDictionaries!)
                success(provinces)
            } else {
                failure(self.generateError(response!))
            }
        }, failure: { (task:NSURLSessionDataTask?, error:NSError) -> Void in
            failure(error)
        })
    }
    
    // Get categories list
    func getCategories(success: ([Category]) -> (), failure: (NSError) -> ()) {
        let params = ["command": "U_CATEGORY_LIST", "data" : ""]
        
        self.functionSessionManager.POST(BASE_URL, parameters: params, progress: nil, success: { (task:NSURLSessionDataTask, response:AnyObject?) -> Void in
            let categoryDictionaries = self.fetchDataWithArray(response as! NSDictionary)
            if (categoryDictionaries != nil) {
                let categories = Category.getCategories(categoryDictionaries!)
                success(categories)
            } else {
                failure(self.generateError(response!))
            }
        }, failure: { (task:NSURLSessionDataTask?, error:NSError) -> Void in
            failure(error)
        })
    }
    
    // Get hot tours
    func getHotTours(success: ([Tour]) -> (), failure: (NSError) -> ()) {
        let params = ["command": "U_TOUR_HOT_LIST", "data" : ""]
        
        self.functionSessionManager.POST(BASE_URL, parameters: params, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let tourDictionaries = self.fetchDataWithArray(response as! NSDictionary)
            if (tourDictionaries != nil) {
                let tours = Tour.getTours(tourDictionaries!)
                success(tours)
            } else {
                failure(self.generateError(response!))
            }
        }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
            failure(error)
        })
    }
    
    // Get tour detail
    func getTourDetail(tourId: Int, success: (Tour) -> (), failure: (NSError) -> ()) {
        
        let postData = ["tour_id": tourId]
        let params = ["command": "U_TOUR_DETAIL", "data" : postData]
        
        self.functionSessionManager.POST(BASE_URL, parameters: params, progress: nil, success: { (task:NSURLSessionDataTask, response:AnyObject?) -> Void in
            let tourDictionary = self.fetchData(response as! NSDictionary)
            if (tourDictionary != nil) {
                let tour = Tour(dictionary: tourDictionary!)
                success(tour)
            } else {
                failure(self.generateError(response!))
            }
        }, failure: { (task:NSURLSessionDataTask?, error:NSError) -> Void in
            failure(error)
        })
    }
    
    func createTour(tour: Tour, success: (Tour) -> (), failure: (NSError) -> ()) {
        var postData = [String: AnyObject]()
        postData["tour"] = ["start_time": tour.startTime ?? 0, "description": tour.desc ?? "", "province_id": tour.provinceId ?? 0]
        var events = [[String: AnyObject]]()
        for event in tour.tourEvents! {
            events.append(["day" : event.dayOrder ?? 1, "place_id": event.placeId ?? 0])
        }
        postData["tour_events"] = events
        
        let params = ["command": "U_TOUR_ADD", "data" : postData, "token": User.currentUser?.token ?? ""]
        
        self.functionSessionManager.POST(BASE_URL, parameters: params, progress: nil, success: { (task:NSURLSessionDataTask, response:AnyObject?) -> Void in
            let responseDictionary = self.fetchData(response as! NSDictionary)
            if let responseDictionary = responseDictionary {
                if let tourId = responseDictionary["tour_id"] as? String {
                    tour.tourId = Int(tourId)
                }
                success(tour)
            } else {
                failure(self.generateError(response!))
            }
        }, failure: { (task:NSURLSessionDataTask?, error:NSError) -> Void in
                failure(error)
        })
    }
    
    func generateShareUrl(tour: Tour, success: (FBHostLink) -> (), failure: (NSError) -> ()) {
        let postData = ["tour_id": tour.tourId ?? 0]
        
        let params = ["command": "U_TOUR_GET_HOST_LINK", "data" : postData]
        
        self.functionSessionManager.POST(BASE_URL, parameters: params, progress: nil, success: { (task:NSURLSessionDataTask, response:AnyObject?) -> Void in
            let responseDictionary = self.fetchData(response as! NSDictionary)
            if let responseDictionary = responseDictionary {
                let hostLink = FBHostLink(dictionary: responseDictionary)
                success(hostLink)
            } else {
                failure(self.generateError(response!))
            }
            }, failure: { (task:NSURLSessionDataTask?, error:NSError) -> Void in
                failure(error)
        })
    }
    
}

























