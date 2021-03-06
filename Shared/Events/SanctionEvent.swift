//
//  RefWatchContextSettings.swift
//  RefWatch
//
//  Created by Martin Croker on 13/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import Foundation

// If not subclassed - this is a pen-only
class SanctionEvent : TeamEvent {
    
    var offenceIndex : Int?;
    
    #if os(iOS)
    override init(doEvent: DoEvent) {
        self.offenceIndex = 0; // TODO
        super.init(doEvent: doEvent);
    }
    #endif
    
    init(team: Teams, player: Int? = nil, offenceIndex: Int? = nil) {
        self.offenceIndex = offenceIndex;
        super.init(team: team, player: player);
    }
    
    override var title : String {
        get {
            if (nil != self.offenceIndex) {
                return AppSettings.sanctionList[Int(self.offenceIndex!)].title;
            } else {
                return "Penalty";
            }
        }
    }
    
    var caption : String {
        get {
            if (nil != self.offenceIndex) {
                return AppSettings.sanctionList[Int(self.offenceIndex!)].caption;
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
    
    override var barColor : Color {
        get {
            return Color.sanctionOther
        }
    }
    
}
