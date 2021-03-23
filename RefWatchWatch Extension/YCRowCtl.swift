//
//  YellowCardRowCtl.swift
//  RefWatchWatch Extension
//
//  Created by Martin Croker on 15/01/2020.
//  Copyright © 2020 Martin Croker. All rights reserved.
//

import Foundation
import WatchKit

class YCRowCtl : NSObject {
    
    @IBOutlet weak var playerLabel: WKInterfaceLabel!
    @IBOutlet weak var binTimer: WKInterfaceTimer!
    
    private let clock : MatchClock = MatchFactory.getCurrentMatch().clock;
    
    override init() {
        self.isTimeOn = clock.isTimeOn;
        super.init();
        NotificationCenter.default.addObserver(self, selector: #selector(timeEventHandler(notification:)), name: .timeOn, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(timeEventHandler(notification:)), name: .timeOff, object: nil);
    };
    
    @objc public func timeEventHandler(notification: NSNotification) {
        debugPrint("Processing Time Notification - YC", notification)
        self.isTimeOn = clock.isTimeOn;
    }
    
    var isTimeOn : Bool  {
        didSet {
            if (nil != event) {
                binTimer.setDate(event!.expiresAt);
                if clock.isTimeOn {
                    binTimer.start();
                } else {
                    binTimer.stop();
                }
            }
        }
    }
    
    var event: YellowCardPlayerEvent? {
        didSet {
            if (nil != event) {
                self.playerLabel.setText(event!.playerLabel);
                binTimer.setDate(event!.expiresAt);
                if (clock.isTimeOn) {
                    binTimer.start();
                } else {
                    binTimer.stop();
                }
                
                if event!.isActive {
                    playerLabel.setTextColor(UIColor.yellow);
                    binTimer.setTextColor(UIColor.yellow);
                } else {
                    playerLabel.setTextColor(UIColor.green);
                    binTimer.setTextColor(UIColor.green);
                }
            }
        }
    }
    
}
