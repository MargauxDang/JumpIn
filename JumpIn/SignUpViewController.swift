//
//  SignUpViewController.swift
//  JumpIn
//
//  Created by Margaux Dang on 01/11/2017.
//  Copyright © 2017 Margaux Dang. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet var signUp: UIButton!
    @IBOutlet var usernameInput: UITextField!
    @IBOutlet var passwordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUp.layer.cornerRadius = 5.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func createAccount(_ sender: Any) {
        //If username and password are filled
        if let username = usernameInput.text, let password = passwordInput.text {
            
            //Create user
            Auth.auth().createUser(withEmail: username, password: password, completion: { user, error in
                
                //If there are some errors connection to Firebase
                if let firebaseError = error {
                    print (firebaseError.localizedDescription)
                    return
                }
                else {
                    print ("sucess")
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
    

}
