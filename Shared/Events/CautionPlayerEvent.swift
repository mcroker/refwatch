//
//  RefWatchContextSettings.swift
//  RefWatch
//
//  Created by Martin Croker on 13/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import Foundation

class CautionPlayerEvent : SanctionEvent {
    
    override var timeRemaining : TimeInterval {
        get {
            let tmpTime: TimeInterval = settings.cautionDuration - self.gameTimeSince;
            if tmpTime > 0 {
                return tmpTime
            } else {
                return 0;
            }
        }
    }
    
    override var isActive : Bool {
        get {
            return (timeRemaining > 0);
        }
    }
    
    override var isCurrent : Bool {
        get {
            return isActive;
        }
    }
    
    override var title : String {
        get {
            if (nil != self.offenceIndex) {
                return "P! \(super.title)";
            } else {
                return "P! Caution Player";
            }
        }
    }
    
    override var barColor : Color {
        get {
            return Color.sanctionCaution
        }
    }
        
}
