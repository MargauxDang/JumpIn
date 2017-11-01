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
import FirebaseAuth

class InfoViewController: UIViewController {
    
    @IBOutlet var confirm: UIButton!
    @IBOutlet var logOut: UIButton!
    var dict : [String : AnyObject]!
    
    override func viewDidLoad() {
        confirm.layer.cornerRadius = 5.0
        logOut.layer.cornerRadius = 5.0
        super.viewDidLoad()
        
        //Create a button
        let FBbutton = LoginButton(readPermissions: [ .publicProfile ])
        let newCenter = CGPoint(x: UIScreen.main.bounds.size.width*0.5, y: 500)
        FBbutton.center = newCenter
        
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
    
    @IBAction func logOutTouch(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            redirectionScreen()
        } catch {
            print("Problem log")
        }
    }
    
    func redirectionScreen() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let redirect:ViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(redirect, animated: true, completion: nil)
    }
    
}


