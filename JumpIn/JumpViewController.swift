//
//  JumpViewController.swift
//  JumpIn
//
//  Created by Margaux Dang on 17/10/2017.
//  Copyright © 2017 Margaux Dang. All rights reserved.
//

import UIKit

class JumpViewController: UIViewController {
    
    var pause = true
    @IBOutlet var pausestart: UIButton!
    @IBOutlet var stop: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pausestart.layer.cornerRadius = 10.0
        stop.layer.cornerRadius = 10.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func pause(_ sender: Any) {
        if pause == true {
            pausestart.setTitle(">",for: .normal)
            pause = false
        } else if pause == false {
            pausestart.setTitle("| |", for: .normal)
            pause = true
        }
        
    }
    
}
