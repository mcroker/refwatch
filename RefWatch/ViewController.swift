//
//  ViewController.swift
//  RefWatch
//
//  Created by Martin Croker on 12/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {

    @IBOutlet weak var IPLbMins: UILabel!
    
    @IBOutlet weak var IPLbHours: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: WCSession Methods
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
        // Code
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
        // Code
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
        // Code
        
    }

}

