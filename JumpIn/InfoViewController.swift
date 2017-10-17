//
//  InfoViewController.swift
//  JumpIn
//
//  Created by Margaux Dang on 17/10/2017.
//  Copyright © 2017 Margaux Dang. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit

class InfoViewController: UIViewController {

    var dict : [String : AnyObject]!

    override func viewDidLoad() {
        super.viewDidLoad()

        //Create a button
        let FBbutton = LoginButton(readPermissions: [ .publicProfile ])
        FBbutton.center = view.center
        //FBbutton.bounds = CGRect(x: -150, y: -150, width: 150, height:80)
        
        //Adding it to view
        view.addSubview(FBbutton)
        
        //if user is already log
        if let accessToken = FBSDKAccessToken.current(){
            getFBUserData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //when login button clicked
    /*@objc func loginButtonClicked() {
     let loginManager = LoginManager()
     loginManager.logIn([ReadPermission.PublicProfile], viewController : self) { loginResult in
     switch loginResult {
     case .Failed(let error):
     print(error)
     case .Cancelled:
     print("User cancelled login")
     case .Success(let grantedPermissions, let declinedPermissions, let accessToken):
     print("Logged in")
     }
     }
     }
 */

    
    //function is fetching the user data
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as! [String : AnyObject]
                    print(result!)
                    print(self.dict)
                }
            })
        }
    }

}
