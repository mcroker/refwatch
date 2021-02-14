//
//  RefWatchContextSettings.swift
//  RefWatch
//
//  Created by Martin Croker on 13/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import Foundation

enum ClockEventType {
    case timeOn
    case timeOff
    case periodStart
    case periodEnd
    case matchStart
    case matchEnd
}

class ClockEvent : MatchEvent {
    
    public var eventType : ClockEventType;
    
    init(eventType: ClockEventType) {
        self.eventType = eventType;
        super.init();
    }
    
    public var stopsClock : Bool {
        get {
            return !self.startsClock;
        }
    }
    
    public var startsClock : Bool {
        get {
            return [ClockEventType.timeOn, ClockEventType.periodStart, ClockEventType.matchStart].contains(self.eventType);
        }
    }
    
    override public var title : String {
        switch self.eventType {
        case .timeOn:
            return "Time On"
        case .timeOff:
            return "Time Off"
        case .periodStart:
            return "Kick-Off (2nd-Half)"
        case .periodEnd:
            return "End Half"
        case .matchStart:
            return "Kick-Off"
        case .matchEnd:
            return "End Match"
        }
    }
    
}
