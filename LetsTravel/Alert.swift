//
//  Alert.swift
//  LetsTravel
//
//  Created by HoangNguyen on 4/25/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import Foundation
import UIKit


class Alert {
    
    class func alert(title: String, message: String, controller: UIViewController, done: (() -> ())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let doneAlertAction = UIAlertAction(title: "OK", style: .Default) { (action: UIAlertAction) in
            done?()
        }
        alertController.addAction(doneAlertAction)
        controller.presentViewController(alertController, animated: true, completion: nil)
    }
    
    class func confirm(title: String, message: String, controller: UIViewController, done: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let doneAction = UIAlertAction(title: "OK", style: .Default) { (action: UIAlertAction) in
            done?()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
        alertController.addAction(doneAction)
        alertController.addAction(cancelAction)
        controller.presentViewController(alertController, animated: true, completion: nil)
    }
    
    class func confirmWithTextField(title: String, message: String, controller: UIViewController, done: ((String) -> Void)?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alertController.addTextFieldWithConfigurationHandler(nil)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
        let doneAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
            if let textField = alertController.textFields, textValue = textField[0].text {
                done?(textValue)
            } else {
                done?("")
            }
        }
        alertController.addAction(doneAction)
        alertController.addAction(cancelAction)
        controller.presentViewController(alertController, animated: true, completion: nil)
    }
    
}
