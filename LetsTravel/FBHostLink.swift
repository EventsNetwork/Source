//
//  FBHostLink.swift
//  LetsTravel
//
//  Created by HoangNguyen on 4/26/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import Foundation

struct FBHostLink {
    var canonical_url: String?
    var id: String?
    
    init(url: String, id: String) {
        self.canonical_url = url
        self.id = id
    }
    
    init(dictionary: NSDictionary) {
        canonical_url = dictionary["canonical_url"] as? String
        id = dictionary["id"] as? String
    }
}