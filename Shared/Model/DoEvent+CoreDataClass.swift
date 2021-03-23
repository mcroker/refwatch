//
//  DoEvent+CoreDataClass.swift
//  RefWatch
//
//  Created by Martin Croker on 17/02/2021.
//  Copyright © 2021 Martin Croker. All rights reserved.
//
//

import Foundation
import CoreData


@objc(DoEvent)
public class DoEvent: NSManagedObject {
    
    var typeEnum:EventTypes {
        get { return EventTypes(rawValue: self.type!)! }
        set { self.type = newValue.rawValue }
    }
    
    var offenceEnum:OffenceTypes {
        get { return OffenceTypes(rawValue: self.offence!)! }
        set { self.offence = newValue.rawValue }
    }
    
    var teamEnum: Teams {
        get { return Teams(rawValue: self.team!)! }
        set { self.team = newValue.rawValue }
    }
    
}
