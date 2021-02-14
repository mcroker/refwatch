//
//  RefWatchContextSettings.swift
//  RefWatch
//
//  Created by Martin Croker on 13/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import Foundation
import WatchKit

// If not subclassed - this is a pen-only
class SanctionEvent : TeamEvent {
    
    var offenceIndex : Int?;
    
    init(team: MatchTeam, player: Int? = nil, offenceIndex: Int? = nil) {
        self.offenceIndex = offenceIndex;
        super.init(team: team, player: player);
    }
    
    override var title : String {
        get {
            if (nil != self.offenceIndex) {
                return settings.sanctionList[self.offenceIndex!].title;
            } else {
                return "Penalty";
            }
        }
    }
    
    override var barColor : UIColor {
        get {
            return UIColor.sanctionOther
        }
    }
    
    var caption : String {
        get {
            if (nil != self.offenceIndex) {
                return settings.sanctionList[self.offenceIndex!].caption;
            } else {
                return "Penalty";
            }
        }
    }
    
    var timeRemaining : TimeInterval? {
        get {
            return nil;
        }
    }
    
    var isActive : Bool {
        get {
            return true;
        }
    }
    
    var isCurrent : Bool {  // Active or in grace-period
        get {
            return true;
        }
    }
    
}
