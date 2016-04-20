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
    
    var dictionary: NSDictionary?
    
    override init() {
        
    }
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        userId = dictionary["user_id"] as? String
        fullName = dictionary["full_name"] as? String
        avatarUrl = dictionary["avatar_url"] as? String
        token = dictionary["token"] as? String
    }
    
    static let userDidLogoutNotification = "UserDidLogout"
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = NSUserDefaults.standardUserDefaults()
                let userData = defaults.objectForKey("currentUserData") as? NSData
        
                if let userData = userData {
                    let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        set (user) {
            let defaults = NSUserDefaults.standardUserDefaults()
            
            if let user = user {
                let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
                defaults.setObject(data, forKey: "currentUserData")
            } else {
                defaults.setObject(nil, forKey: "currentUserData")
            }
            
            defaults.synchronize()
        }
    }
    
    
}








