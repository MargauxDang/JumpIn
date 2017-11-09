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

    @IBOutlet var train: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        train.layer.cornerRadius = 5.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
