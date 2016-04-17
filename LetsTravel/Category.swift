//
//  Category.swift
//  LetsTravel
//
//  Created by TriNgo on 4/13/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit

class Category: NSObject {
    var categoryId: Int?
    var categoryName: NSString?
    var imageUrl: NSString?
    
    override init() {
        
    }
    
    init(dictionary: NSDictionary) {
        categoryId = dictionary["category_id"] as? Int
        categoryName = dictionary["category_name"] as? String
        imageUrl = dictionary["image_url"] as? String
    }
    
    class func getCategories(dictionaries: [NSDictionary]) -> [Category]{
        var categories = [Category]()
        for dictionary in dictionaries {
            let category = Category(dictionary: dictionary)
            categories.append(category)
        }
        return categories
    }
}
