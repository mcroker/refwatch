//
//  InterfaceController.swift
//  RefWatchWatch Extension
//
//  Created by Martin Croker on 12/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import WatchKit
import Foundation

struct PenCountICContext {
    var team: MatchTeam;
}

class PenCountIC: WKInterfaceController {
    
    var context : PenCountICContext?;

    override init() {
        super.init();
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context);
        self.context = context as? PenCountICContext;
    }
    
    override func willActivate() {
        super.willActivate();
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(10), execute: {
            self.okButtonClick();
        })
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    @IBAction func okButtonClick() {
        presentController(withName: "Main", context: context);
    }
    
    @IBAction func shotAtGoalButtonClick() {
        let context = ShotPageContext(
            team: self.context!.team,
            shotType: .pen
        );
        presentController(withName: "Shot", context: context);
    }
}
