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
        placeId = dictionary["place_id"] as? Int
        name = dictionary["name"] as? String
        categoryId = dictionary["category_id"] as? Int
        minPrice = dictionary["min_price"] as? Double
        maxPrice = dictionary["max_price"] as? Double
        address = dictionary["address"] as? String
        desc = dictionary["description"] as? String
        latitude = dictionary["latitude"] as? Double
        longitude = dictionary["longitude"] as? Double
        provinceId = dictionary["province_id"] as? Int
        imageUrls = dictionary["image_urls"] as? [String]
        rating = dictionary["rating"] as? Float
    }
}














