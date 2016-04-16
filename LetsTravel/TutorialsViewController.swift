//
//  TutorialsViewController.swift
//  LetsTravel
//
//  Created by TriNgo on 4/13/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit

class TutorialsViewController: UIViewController {

    @IBOutlet weak var btnLoginFacebook: FBSDKLoginButton!
    @IBOutlet weak var infosLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureFacebook() {
        btnLoginFacebook.readPermissions = ["public_profile", "email", "user_friends"]
        btnLoginFacebook.delegate = self
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

extension TutorialsViewController: FBSDKLoginButtonDelegate {
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        let params = ["fields":"first_name, last_name, picture.type(large)"]
        
        FBSDKGraphRequest.init(graphPath: "me", parameters: params).startWithCompletionHandler { (connection, result, error) -> Void in
            let strFirstName = (result.objectForKey("first_name") as? String)!
            let strLastName = (result.objectForKey("last_name") as? String)!
            let strPictureUrl = (result.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as? String)!
            
            self.infosLabel.text = "Hello \(strFirstName) \(strLastName) \(strPictureUrl)"

        }
        
    }
    
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
        
        print("Facebook did logout!!")
    }
}







