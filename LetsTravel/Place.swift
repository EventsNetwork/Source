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
    var name: NSString?
    var categoryId: Int?
    var minPrice: Double?
    var maxPrice: Double?
    var address: NSString?
    var desc: NSString?
    var longitude: Double?
    var latitude: Double?
    var provinceId: Int?
    var imageUrls: [NSString]?
    var rating: Float?
    
    override init() {
        
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














