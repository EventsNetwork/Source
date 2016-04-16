//
//  TourEvent.swift
//  LetsTravel
//
//  Created by TriNgo on 4/13/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit

class TourEvent: NSObject {
    var id: Int?
    var tourId: Int?
    var dayOrder: Int?
    var placeId: Int?
    var placeName: NSString?
    var startTime: Int?
    var endTime: Int?
    
    override init() {
        
    }
    
    init(dictionary: NSDictionary) {
        id = dictionary["id"] as? Int
        tourId = dictionary["tour_id"] as? Int
        dayOrder = dictionary["day_order"] as? Int
        placeId = dictionary["place_id"] as? Int
        placeName = dictionary["place_name"] as? String
        startTime = dictionary["start_time"] as? Int
        endTime = dictionary["end_time"] as? Int
    }
    
}


