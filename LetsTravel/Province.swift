//
//  Province.swift
//  LetsTravel
//
//  Created by TriNgo on 4/13/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit

class Province: NSObject {
    var provinceId: Int?
    var provinceName: NSString?
    var imageUrls: [NSString]?
    var longitude: Double?
    var latitude: Double?
    
    override init() {
        
    }
    
    init(dictionary: NSDictionary) {
        provinceId = dictionary["province_id"] as? Int
        provinceName = dictionary["province_name"] as? String
        imageUrls = dictionary["image_urls"] as? [String]
        longitude = dictionary["longitude"] as? Double
        latitude = dictionary["latitude"] as? Double
    }
    
    
}

