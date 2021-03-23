//
//  DoClockEvent+CoreDataClass.swift
//  RefWatch
//
//  Created by Martin Croker on 17/02/2021.
//  Copyright © 2021 Martin Croker. All rights reserved.
//
//

import Foundation
import CoreData



@objc(DoClockEvent)
public class DoClockEvent: DoEvent {
    
    static func create(eventType: DoClockEventType) -> DoClockEvent {
        let newEvent = DoClockEvent();
        newEvent.initEvent();
        newEvent.eventType = eventType;
        return newEvent;
    }
    
    var typeEnum:EventTypes {
        get { return EventTypes(rawValue: self.type)! }
        set { self.type = newValue.rawValue }
    }
    

    
}
