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
import FirebaseDatabase

class InfoViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var confirm: UIButton!
    @IBOutlet var logOut: UIButton!
    @IBOutlet var weightInput: UITextField!
    @IBOutlet var highInput: UITextField!
    var dict : [String : AnyObject]!
    var user = Auth.auth().currentUser
    var currentUser = ""
    var postData = [String]()
    var ref:DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
    override func viewDidLoad() {
        confirm.layer.cornerRadius = 5.0
        logOut.layer.cornerRadius = 5.0
        super.viewDidLoad()
        
        //Hide keyboard
        self.weightInput.delegate = self
        self.highInput.delegate = self
        
        //Create a button
        let FBbutton = LoginButton(readPermissions: [ .publicProfile ])
        let newCenter = CGPoint(x: UIScreen.main.bounds.size.width*0.5, y: 500)
        FBbutton.center = newCenter
        
        //Adding it to view
        view.addSubview(FBbutton)
        
        //if user is already log
        if (FBSDKAccessToken.current()) != nil{
            getFBUserData()
        }
        
        //Print the weight and the high
        if (user != nil) {
            currentUser = (user?.email)!
            print(currentUser)
        
        
        //Access to firebase data
        
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func confirmTouched(_ sender: Any) {
        //Update data
        currentUser = (user?.email)!
        let weight = weightInput.text
        let high = highInput.text
        
        /*if (user != nil) {
            ref = Database.database().reference()
            let key = ref?.child("Posts").childByAutoId().key
            let post = ["username": currentUser,
                        "weight": weight,
                        "high": high]
            let childUpdates = ["/Posts/\(key)": post,
                                "\(currentUser)/\(key)/": post]
            ref?.updateChildValues(childUpdates)
        }*/
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
    
    //Hide keyboard when user touches outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Hide keyboard when user touches return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        weightInput.resignFirstResponder()
        highInput.resignFirstResponder()
        return true
    }
}


