//
//  Tour.swift
//  LetsTravel
//
//  Created by TriNgo on 4/13/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit

class Tour: NSObject {
    var tourId: Int?
    var userId: Int?
    var startTime: Int?
    var desc: NSString?
    var minCost: Double?
    var maxCost: Double?
    var provinceId: Int?
    var totalDay: Int?
    var favouriteCount: Int?
    var tourEvents: [TourEvent]?
    
    override init() {
        
    }
    
    init(dictionary: NSDictionary) {
        tourId = dictionary["tour_id"] as? Int
        userId = dictionary["user_id"] as? Int
        startTime = dictionary["start_time"] as? Int
        desc = dictionary["description"] as? String
        minCost = dictionary["min_cost"] as? Double
        maxCost = dictionary["max_cost"] as? Double
        provinceId = dictionary["province_id"] as? Int
        totalDay = dictionary["total_date"] as? Int
        favouriteCount = dictionary["favourite_count"] as? Int
        tourEvents = dictionary["event_day"] as? [TourEvent]
    }
    
}
