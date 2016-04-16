//
//  User.swift
//  LetsTravel
//
//  Created by TriNgo on 4/13/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit

class User: NSObject {
    var userId: NSString?
    var fullName: NSString?
    var facebookId: NSString?
    var avatarUrl: NSString?
    var password: NSString?
    var token: NSString?
    
    override init() {
        
    }
    
    init(dictionary: NSDictionary) {
        userId = dictionary["user_id"] as? String
        fullName = dictionary["full_name"] as? String
        avatarUrl = dictionary["avatar_url"] as? String
        token = dictionary["token"] as? String
    }
}
