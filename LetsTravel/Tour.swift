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
        tourId = Int((dictionary["tour_id"] as? String)!)
        userId = Int((dictionary["user_id"] as? String)!)
        startTime = Int((dictionary["start_time"] as? String)!)
        desc = dictionary["description"] as? String
        minCost = Double((dictionary["min_cost"] as? String)!)
        maxCost = Double((dictionary["max_cost"] as? String)!)
        provinceId = Int((dictionary["province_id"] as? String)!)
        totalDay = Int((dictionary["total_date"] as? String)!)
        favouriteCount = Int((dictionary["favourite_count"] as? String)!)
        
        if dictionary["event_day"] != nil {
            let eventDayDictionary = dictionary["event_day"] as! [NSDictionary]
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
