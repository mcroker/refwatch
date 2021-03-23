//
//  RefWatchContextSettings.swift
//  RefWatch
//
//  Created by Martin Croker on 13/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import Foundation

enum DoClockEventType: Int16 {
    case timeOn = 1
    case timeOff = 2
    case periodStart = 3
    case periodEnd = 4
    case matchStart = 5
    case matchEnd = 6
}

extension DoClockEvent {
    
    var eventType:DoClockEventType {
        get { return DoClockEventType(rawValue: self.eventTypeCode)! }
        set { self.eventTypeCode = newValue.rawValue }
    }
    
    convenience init(eventType: DoClockEventType) {
        self.init();
        self.eventType = eventType;
    }
    
    /*
     * Indicates if the event should be considered a stopClock event for time calc purposes.
     */
    public var stopsClock : Bool {
        get {
            return !self.startsClock;
        }
    }
    
    /*
     * Indicates if the event should be considered a startClock event for time calc purposes.
     */
    public var startsClock : Bool {
        get {
            return [DoClockEventType.timeOn, DoClockEventType.periodStart, DoClockEventType.matchStart].contains(self.eventType);
        }
    }
    
    public var title : String {
        get {
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
    
}
