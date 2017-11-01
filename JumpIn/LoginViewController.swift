//
//  LoginViewController.swift
//  JumpIn
//
//  Created by Margaux Dang on 01/11/2017.
//  Copyright © 2017 Margaux Dang. All rights reserved.
//

import UIKit
import FirebaseAuth
import FacebookLogin
import FBSDKLoginKit

class LoginViewController: UIViewController {

    @IBOutlet var logIn: UIButton!
    @IBOutlet var usernameInput: UITextField!
    @IBOutlet var passwordInput: UITextField!
    var dict : [String : AnyObject]!

    override func viewDidLoad() {
        super.viewDidLoad()
        logIn.layer.cornerRadius = 5.0
        
        //Facebook connexion
        let FBbutton = LoginButton(readPermissions: [ .publicProfile ])
        let newCenter = CGPoint(x: UIScreen.main.bounds.size.width*0.5, y:  150)
        FBbutton.center = newCenter
        view.addSubview(FBbutton)
        
        //if user is already log
        if (FBSDKAccessToken.current()) != nil{
            getFBUserData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //if user is already log
        if (FBSDKAccessToken.current()) != nil{
            getFBUserData()
            self.redirectionScreen()
        }
    }
    
    @IBAction func login(_ sender: Any) {
        //If username and password are filled
        if let username = usernameInput.text, let password = passwordInput.text {
            Auth.auth().signIn(withEmail: username, password: password, completion: { user, error in
                //If there are some errors connection to Firebase
                if let firebaseError = error {
                    self.createAlert(title: "Error", message: firebaseError.localizedDescription)
                    return
                }
                else {
                    self.redirectionScreen()
                }
            })
        }
    }
    
    func redirectionScreen() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let redirect:MenuViewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        self.present(redirect, animated: true, completion: nil)
    }
    
    func createAlert(title: String, message:String) {
        let alert = UIAlertController (title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //Connexion with Facebook//
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
