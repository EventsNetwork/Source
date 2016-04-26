//
//  Utils.swift
//  LetsTravel
//
//  Created by phuong le on 4/26/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit

class Utils: NSObject {
    
    static func fromPriceToString(price: Double) -> String {
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .DecimalStyle
        numberFormatter.maximumFractionDigits  = 0
        return numberFormatter.stringFromNumber(price) ?? "0"
    }

}
