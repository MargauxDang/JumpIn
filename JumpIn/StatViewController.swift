//
//  StatViewController.swift
//  JumpIn
//
//  Created by Margaux Dang on 17/10/2017.
//  Copyright © 2017 Margaux Dang. All rights reserved.
//

import UIKit
import Social
import Firebase
import FirebaseDatabase

class StatViewController: UIViewController {

    
    @IBOutlet var jumpNb: UIButton!
    @IBOutlet var calories: UIButton!
    @IBOutlet var duration: UIButton!
    @IBOutlet var altitude: UIButton!
    var newJump: String!
    var newCalories: String!
    var newDuration: String!
    var newAltitude: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Print the data of the last session
        let userID = (Auth.auth().currentUser?.uid)!
        Database.database().reference().child("sessions").child(userID).child("session1").observeSingleEvent(of: .value) { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                self.newJump = dictionary["jumps"] as? String
                self.newCalories = dictionary["calories"] as? String
                self.newDuration = dictionary["duration"] as? String
                self.newAltitude = dictionary["altitude"] as? String
                
                self.jumpNb.setTitle(self.newJump, for: .normal)
                self.calories.setTitle(self.newCalories, for: .normal)
                self.duration.setTitle(self.newDuration, for: .normal)
                self.altitude.setTitle(self.newAltitude, for: .normal)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Share the result on social media
    @IBAction func shareResult(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "Share my result", preferredStyle: .actionSheet)
        
        //Facebook
        let facebook = UIAlertAction(title: "Share on Facebook", style: .default) { (action) in
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
                let post = SLComposeViewController(forServiceType: SLServiceTypeFacebook)!
                post.setInitialText("Hi! I just finished my session on JumpIn app. I did \(self.jumpNb) jumps, I burnt \(self.newCalories) calories and my average altitude is \(self.newAltitude) during \(self.newDuration)")
                //post.add(<#T##image: UIImage!##UIImage!#>)
                //post.add(<#T##url: URL!##URL!#>)
                self.present(post, animated:true, completion: nil)
            } else {
                self.showAlertFacebook()
            }
        }
        alert.addAction(facebook)
        
        //Twitter
        let twitter = UIAlertAction(title: "Share on Twitter", style: .default) { (action) in
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
                let post = SLComposeViewController(forServiceType: SLServiceTypeTwitter)!
                post.setInitialText("Hi! I just finished my session on JumpIn app. I did \(self.jumpNb) jumps, I burnt \(self.newCalories) calories and my average altitude is \(self.newAltitude) during \(self.newDuration)")
                //post.add(<#T##image: UIImage!##UIImage!#>)
                //post.add(<#T##url: URL!##URL!#>)
                self.present(post, animated:true, completion: nil)
            } else {
                self.showAlertTwitter()
            }
        }
        alert.addAction(twitter)
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //Alert messages if the user is not connected to the social media
    func showAlertFacebook() {
        let alert = UIAlertController(title: "Error", message: "Please connect yourself to Facebook", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func showAlertTwitter() {
        let alert = UIAlertController(title: "Error", message: "Please connect yourself to Twitter", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
