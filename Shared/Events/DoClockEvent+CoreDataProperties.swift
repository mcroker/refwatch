//
//  DoClockEvent+CoreDataProperties.swift
//  RefWatch
//
//  Created by Martin Croker on 17/02/2021.
//  Copyright © 2021 Martin Croker. All rights reserved.
//
//

import Foundation
import CoreData


extension DoClockEvent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DoClockEvent> {
        return NSFetchRequest<DoClockEvent>(entityName: "DoClockEvent")
    }

    @NSManaged public var eventTypeCode: Int16

}
