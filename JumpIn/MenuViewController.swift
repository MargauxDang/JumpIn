//
//  MenuViewController.swift
//  JumpIn
//
//  Created by Margaux Dang on 17/10/2017.
//  Copyright © 2017 Margaux Dang. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit

class MenuViewController: UIViewController {

    @IBOutlet var jump: UIButton!
    @IBOutlet var train: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jump.layer.cornerRadius = 5.0
        train.layer.cornerRadius = 5.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addFriends(_ sender: Any) {
        
    }
}
