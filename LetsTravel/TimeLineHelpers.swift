//
//  TimeLineHelpers.swift
//  LetsTravel
//
//  Created by HoangNguyen on 4/27/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import Foundation

class TimeLineHelpers: NSObject {
    func getPlacesFromTour(tour: Tour) -> [[Place]] {
        var placesToGo = [[Place]]()
        for tourEvent in tour.tourEvents! {
            let place = Place(name: tourEvent.placeName, placeId: tourEvent.placeId)
            if tourEvent.dayOrder! > placesToGo.count {
                placesToGo.append([place])
            } else {
                placesToGo[tourEvent.dayOrder! - 1].append(place)
            }
        }
        return placesToGo
    }
    
    func fromPlacesToTour(placesToGo: [[Place]], startTime: Int, province: Province?) -> Tour {
        let tour = Tour()
        tour.startTime = startTime
        tour.provinceId = province?.provinceId
        var events = [TourEvent]()
        for (index, places) in placesToGo.enumerate() {
            for place in places {
                let event = TourEvent()
                event.dayOrder = index + 1
                event.placeId = place.placeId
                events.append(event)
            }
        }
        tour.tourEvents = events
        return tour
    }
}
