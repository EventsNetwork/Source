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
        provinceId = Int((dictionary["province_id"] as? String)!)
        provinceName = dictionary["province_name"] as? String

        let imageUrlString = dictionary["image_urls"] as? String
        imageUrls = imageUrlString != nil ? imageUrlString!.characters.split(",").map(String.init) : [""]
        
        longitude = Double((dictionary["longitude"] as? String) != nil ? (dictionary["longitude"] as? String)! : "0")
        latitude = Double((dictionary["latitude"] as? String) != nil ? (dictionary["latitude"] as? String)! : "0")
    }
    
    class func getProvinces(dictionaries: [NSDictionary]) -> [Province]{
        var provinces = [Province]()
        for dictionary in dictionaries {
            let province = Province(dictionary: dictionary)
            provinces.append(province)
        }
        return provinces
    }
    
}

