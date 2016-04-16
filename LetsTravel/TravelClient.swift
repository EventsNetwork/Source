//
//  TravelClient.swift
//  LetsTravel
//
//  Created by TriNgo on 4/13/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

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
    
    private func generateError(response: AnyObject) -> NSError {
        let errorCode = (response as! NSDictionary)["code"] as! Int
        let errorMessage = (response as! NSDictionary)["msg"] as! String
        let error = NSError(domain: self.BASE_URL, code: errorCode, userInfo: ["error": errorMessage])
        
        return error
    }
    
    func login(facebookId: String, fullName: String, avatarUrl: String, success: (User) -> (), failure: (NSError) -> ()) {
        let postData = ["facebook_id":facebookId, "full_name":fullName, "avatar_url":avatarUrl]
        let params = ["command": "U_LOGIN", "data" : postData]
        
        self.functionSessionManager.POST(BASE_URL, parameters: params, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let userDictionary = self.fetchData(response as! NSDictionary)
            if (userDictionary != nil) {
                let user = User(dictionary: userDictionary!)
                success(user)
            }else{
                failure(self.generateError(response!))
            }
        }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
            failure(error)
        })
    }
    
    func searchPlaceViaCategoryAndProvince(provinceId: String, categoryId: String, placeName: String, success: () -> (), failure: (NSError) -> ()) {
        
        let postData = ["province_id":provinceId, "category_id":categoryId, "place_name":placeName]
        let params = ["command": "U_PLACE_SEARCH_CATEGORY", "data" : postData]
        
        self.functionSessionManager.POST(BASE_URL, parameters: params, progress: nil, success: { (task:NSURLSessionDataTask, response:AnyObject?) -> Void in

        }, failure: { (task:NSURLSessionDataTask?, error:NSError) -> Void in
            failure(error)
        })
    }
    
    func retrieveTours(success: ([Tour]) -> (), failure: (NSError) -> ()) {
        
    }
    
    func retrieveTourEvents(success: ([TourEvent]) -> (), failure: (NSError) -> ()) {
        
    }
    
    
}
