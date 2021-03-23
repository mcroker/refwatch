//
//  RefWatchContextSettings.swift
//  RefWatch
//
//  Created by Martin Croker on 13/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import Foundation

enum DoSanction: Int16 {
    case unspecified = 0
    case timeOff = 2
    case periodStart = 3
    case periodEnd = 4
    case matchStart = 5
    case matchEnd = 6
}

// If not subclassed - this is a pen-only
extension DoSanctionEvent {
    
    convenience init(team: DoTeamCode, player: DoPlayer = 0, offence: DoSanction = .unspecified) {
        self.init();
        self.initTeam(team: team, player: player);
        self.offence = offence;
    }
    
    var offence:DoSanction {
        get { return DoSanction(rawValue: self.offenceCode)! }
        set { self.offenceCode = newValue.rawValue }
    }
    
    public var title : String {
        get {
            if (nil != self.offence) {
                return settings.sanctionList[self.offenceIndex!].title;
            } else {
                return "Penalty";
            }
        }
    }
    
    var caption : String {
        get {
            if (nil != self.offence) {
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
    
    var barColor : Color {
        get {
            return Color.sanctionOther
        }
    }
    
}
