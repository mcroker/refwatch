//
//  InterfaceController.swift
//  RefWatchWatch Extension
//
//  Created by Martin Croker on 12/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import WatchKit
import Foundation

class MatchListIC: WKInterfaceController {
    
    private let context : RefWatchContext = RefWatchContext.getInstance();

    override init() {
        super.init();
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context);
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
}
