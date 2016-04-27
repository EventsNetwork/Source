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
    var place:Place = Place()
    
    override init() {
        
    }
    
    init(dictionary: NSDictionary) {
        id = Int((dictionary["id"] as? String)!)
        tourId = Int((dictionary["tour_id"] as? String)!)
        dayOrder = Int((dictionary["day_order"] as? String)!)
        place = Place(dictionary: dictionary)
    }
    
    class func getTourEvents(dictionaries: [[NSDictionary]]) -> [TourEvent]{
        var tourEvents = [TourEvent]()
        
        for item in dictionaries {
            for value in item {
                let tourEvent = TourEvent(dictionary: value)
                tourEvents.append(tourEvent)
            }
        }
        return tourEvents
    }
    
}


