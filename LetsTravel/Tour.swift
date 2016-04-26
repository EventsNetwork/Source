//
//  Tour.swift
//  LetsTravel
//
//  Created by TriNgo on 4/13/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit
import SwiftyJSON

class Tour: NSObject {
    var tourId: Int?
    var userId: Int?
    var startTime: Int?
    var desc: String?
    var minCost: Double?
    var maxCost: Double?
    var provinceId: Int?
    var totalDay: Int?
    var favouriteCount: Int?
    var tourEvents: [TourEvent]?
    
    override init() {
        
    }
    
    init(dictionary: NSDictionary) {
        
        let json = JSON(dictionary)
        
        
        tourId = Int(json["tour_id"].string!)
        userId = Int(json["user_id"].string!)
        startTime = Int(json["start_time"].string!)
        desc = json["description"].string
        minCost = Double(json["min_cost"].string!)
        maxCost = Double(json["max_cost"].string!)
        provinceId = Int(json["province_id"].string!)
        totalDay = Int(json["total_date"].string!)
        favouriteCount = Int(json["favourite_count"].string!)
        
        print(json["event_day"][0])
        
        if dictionary["event_day"] != nil {
            let eventDayDictionary = dictionary["event_day"] as! [[NSDictionary]]
            tourEvents = TourEvent.getTourEvents(eventDayDictionary)
        }
        
    }
    
    class func getTours(dictionaries: [NSDictionary]) -> [Tour]{
        var tours = [Tour]()
        for dictionary in dictionaries {
            let tour = Tour(dictionary: dictionary)
            tours.append(tour)
        }
        return tours
    }
}
