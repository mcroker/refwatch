//
//  InterfaceController.swift
//  RefWatchWatch Extension
//
//  Created by Martin Croker on 12/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import WatchKit
import Foundation

class PenCountIC: WKInterfaceController {
    
    var _context : RefWatchContext = RefWatchContext.getInstance();

    override init() {
        super.init();
    }
    
    override func willActivate() {
        super.willActivate()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(10), execute: {
            self.okButtonClick();
        })
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    @IBAction func okButtonClick() {
        presentController(withName: "Main", context: _context);
    }
    
    @IBAction func shotAtGoalButtonClick() {
        _context.state = .shotAtGoalAttemptInProgress;
        presentController(withName: "Shot", context: _context);
    }
}
