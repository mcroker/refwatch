//
//  DoEvent+CoreDataProperties.swift
//  RefWatch
//
//  Created by Martin Croker on 17/02/2021.
//  Copyright © 2021 Martin Croker. All rights reserved.
//
//

import Foundation
import CoreData


extension DoEvent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DoEvent> {
        return NSFetchRequest<DoEvent>(entityName: "DoEvent")
    }

    @NSManaged public var gameTime: Double
    @NSManaged public var periodTimePeriod: Int32
    @NSManaged public var periodTimeTime: Double
    @NSManaged public var realTime: Date?
    @NSManaged public var type: String?
    @NSManaged public var player: Int32
    @NSManaged public var team: String?
    @NSManaged public var offence: String?
    @NSManaged public var match: DoMatch?

}
