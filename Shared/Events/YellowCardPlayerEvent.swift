//
//  RefWatchContextSettings.swift
//  RefWatch
//
//  Created by Martin Croker on 13/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import Foundation
#if os(iOS)
    import UIKit
#elseif os(watchOS)
    import WatchKit
#endif

class YellowCardPlayerEvent : SanctionEvent {
    
    override var timeRemaining : GameTime {
        get {
            let tmpTime: TimeInterval = settings.sinBinDuration - self.gameTimeSince;
            if tmpTime > 0 {
                return tmpTime;
            } else {
                return 0;
            }
        }
    }
    
    var expiresAt : RealTime {
        return Date(timeIntervalSinceNow: self.timeRemaining);
    }
    
    override var isActive : Bool {
        get {
            return (timeRemaining > 0);
        }
    }
    
    override var isCurrent : Bool {
        get {
            return self.gameTimeSince <= settings.sinBinDuration + settings.displayGracePeriod;
        }
    }
    
    override var title : String {
        get {
            if (nil != self.offenceIndex) {
                return "YC \(super.title)";
            } else {
                return "Yellow Card";
            }
        }
    }
    
    override var barColor : UIColor {
        get {
            return UIColor.sanctionYC
        }
    }
        
}
