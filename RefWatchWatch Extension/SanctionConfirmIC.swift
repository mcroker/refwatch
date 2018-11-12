//
//  InterfaceController.swift
//  RefWatchWatch Extension
//
//  Created by Martin Croker on 12/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import WatchKit
import Foundation


class SanctionConfirmIC: WKInterfaceController {
    
    var _context : RefWatchContext?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        _context = context as! RefWatchContext
          }
    
    override func willActivate() {
        super.willActivate()
        // This method is called when watch view controller is about to be visible to user
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}
