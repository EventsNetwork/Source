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
    var placeName: String?
    var startTime: Int?
    var endTime: Int?
    
    override init() {
        
    }
    
    init(dictionary: NSDictionary) {
        id = Int((dictionary["id"] as? String)!)
        tourId = Int((dictionary["tour_id"] as? String)!)
        dayOrder = Int((dictionary["day_order"] as? String)!)
        placeId = Int((dictionary["place_id"] as? String)!)
        placeName = dictionary["place_name"] as? String
        startTime = Int((dictionary["start_time"] as? String)!)
        endTime = Int((dictionary["end_time"] as? String)!)
    }
    
    class func getTourEvents(dictionaries: [NSDictionary]) -> [TourEvent]{
        var tourEvents = [TourEvent]()
        for dictionary in dictionaries {
            let tourEvent = TourEvent(dictionary: dictionary)
            tourEvents.append(tourEvent)
        }
        return tourEvents
    }
    
}


