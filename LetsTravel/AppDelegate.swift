//
//  AppDelegate.swift
//  LetsTravel
//
//  Created by TriNgo on 4/11/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if User.currentUser != nil {
            let vc = storyboard.instantiateViewControllerWithIdentifier("TravelNavigationController")
            window?.rootViewController = vc
            navigationController = vc as? UINavigationController
        } else {
            let vc = storyboard.instantiateViewControllerWithIdentifier("TutorialsViewController")
            window?.rootViewController = vc
        }
        
        
        
       // navigationController = window?.rootViewController?.navigationController
        
        NSNotificationCenter.defaultCenter().addObserverForName(User.userDidLogoutNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (NSNotification) -> Void in
            let vc = storyboard.instantiateInitialViewController()
            self.window?.rootViewController = vc
        }
        
        setupNavigationBar()
        setupTabBar()
        
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: .Alert, categories: nil))
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
        let parsedUrl = BFURL.init(inboundURL: url, sourceApplication: sourceApplication)
        if parsedUrl.appLinkData != nil {
            if let targetUrl = parsedUrl.targetURL where User.currentUser != nil {
                if (FBSDKAccessToken.currentAccessToken() != nil) {
                    FBSDKGraphRequest.init(graphPath: "", parameters: ["ids" : targetUrl.absoluteString, "fields": "app_links"], HTTPMethod: "GET").startWithCompletionHandler({ (connection: FBSDKGraphRequestConnection!, result: AnyObject!, error: NSError!) in
                        guard error == nil else {
                            return
                        }
                        let scheme = result[targetUrl.absoluteString]!!["app_links"]!!["iphone"]!![0]["url"] as! String
                        let schemeUrl = NSURL(string: scheme)
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        
                        let vc = storyboard.instantiateViewControllerWithIdentifier("TimelineViewController") as! TimelineViewController
                        vc.tourId = Int(schemeUrl?.lastPathComponent ?? "0")
                        self.navigationController?.pushViewController(vc, animated: true)
                    
                    })
                }

            }
        }
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        
        let tourId = notification.userInfo!["tourId"] as? String
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewControllerWithIdentifier("TimelineViewController") as! TimelineViewController
        vc.tourId = Int(tourId ?? "0")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupNavigationBar() {
        UINavigationBar.appearance().barTintColor = UIColor(red: 82.0/255.0, green: 191.0/255.0, blue: 144.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
    }
    
    func setupTabBar() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // 1st tab
        let hotNavigationController = storyboard.instantiateViewControllerWithIdentifier("HotNavigationController")
            as! UINavigationController
        hotNavigationController.tabBarItem.image = UIImage(named: "hottour")
        
        // 2nd tab
        let createNavigationController = storyboard.instantiateViewControllerWithIdentifier("CreateNavigationController")
            as! UINavigationController
        createNavigationController.tabBarItem.image = UIImage(named: "create")
        
        // 3rd tab
        let mineNavigationController = storyboard.instantiateViewControllerWithIdentifier("MineNavigationController")
            as! UINavigationController
        mineNavigationController.tabBarItem.image = UIImage(named: "minetour")
        
        // Add tab into tab bar controller
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = UIColor(red: 82.0/255.0, green: 191.0/255.0, blue: 144.0/255.0, alpha: 1.0)
        tabBarController.viewControllers = [hotNavigationController, createNavigationController, mineNavigationController]
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

}

