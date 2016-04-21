//
//  Place.swift
//  LetsTravel
//
//  Created by TriNgo on 4/13/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit

class Place: NSObject {
    var placeId: Int?
    var name: String?
    var categoryId: Int?
    var minPrice: Double?
    var maxPrice: Double?
    var address: String?
    var desc: String?
    var longitude: Double?
    var latitude: Double?
    var provinceId: Int?
    var imageUrls: [String]?
    var rating: Float?
    
    override init() {
        
    }
    
    init(name: String?, categoryId: Int?, minPrice: Double?, maxPrice: Double?, address: String?, desc: String?, latitude: Double?, longitude: Double, provinceId: Int?) {
        self.name = name
        self.categoryId = categoryId
        self.minPrice = minPrice
        self.maxPrice = maxPrice
        self.address = address
        self.desc = desc
        self.latitude = latitude
        self.longitude = longitude
        self.provinceId = provinceId
    }
    
    init(dictionary: NSDictionary) {
        placeId = Int((dictionary["place_id"] as? String)!)
        name = dictionary["name"] as? String
        categoryId = Int((dictionary["category_id"] as? String)!)
        minPrice = Double((dictionary["min_price"] as? String)!)
        maxPrice = Double((dictionary["max_price"] as? String)!)
        address = dictionary["address"] as? String
        desc = dictionary["description"] as? String
        latitude = Double((dictionary["latitude"] as? String)!)
        longitude = Double((dictionary["longitude"] as? String)!)
        provinceId = Int((dictionary["province_id"] as? String)!)
        
        let imageUrlString = dictionary["image_urls"] as? String
        imageUrls = imageUrlString?.characters.split(",").map(String.init)
        
        rating = Float((dictionary["rating"] as? String)!)
    }
    
    class func getPlaces(dictionaries: [NSDictionary]) -> [Place]{
        var places = [Place]()
        for dictionary in dictionaries {
            let place = Place(dictionary: dictionary)
            places.append(place)
        }
        return places
    }
}














