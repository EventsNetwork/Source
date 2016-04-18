//
//  TutorialsViewController.swift
//  LetsTravel
//
//  Created by TriNgo on 4/13/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit

class TutorialsViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet weak var btnLoginFacebook: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureFacebook()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureFacebook() {
        btnLoginFacebook.readPermissions = ["public_profile", "email", "user_friends"]
        btnLoginFacebook.delegate = self
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        let params = ["fields":"first_name, last_name, picture.type(large)"]
        
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: params)
        graphRequest.startWithCompletionHandler { (connection, result, error) -> Void in
            let firstName = (result.objectForKey("first_name") as? String)!
            let lastName = (result.objectForKey("last_name") as? String)!
            let fullName = firstName + " " + lastName
            let pictureUrl = (result.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as? String)!
            let fbId = (result.objectForKey("id") as? String)!
            
            print("\(fbId)")
            
            TravelClient.sharedInstance.login(fbId, fullName: fullName, avatarUrl: pictureUrl, success: { (user: User) -> () in
                print("\(user)")
                print("\(user.userId) \(user.fullName) \(user.facebookId) \(user.token)")
            }, failure: { (error:NSError) -> () in
                print(error)
            })
        }
        
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
        
        print("Facebook did logout!!")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}







