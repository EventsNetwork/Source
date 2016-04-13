//
//  TravelClient.swift
//  LetsTravel
//
//  Created by TriNgo on 4/13/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TravelClient: BDBOAuth1SessionManager {
    
    static let shareInstance = TravelClient()
    
    func login(success: (User) -> (), failure: (NSError) -> ()) {
        
    }
    
    func retrieveTours(success: ([Tour]) -> (), failure: (NSError) -> ()) {
        
    }
    
    func retrieveTourEvents(success: ([TourEvent]) -> (), failure: (NSError) -> ()) {
        
    }
}
