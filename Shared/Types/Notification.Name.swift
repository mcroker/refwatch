//
//  Notification.Name.swift
//  RefWatchWatch Extension
//
//  Created by Martin Croker on 17/01/2020.
//  Copyright © 2020 Martin Croker. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let timeOn = Notification.Name("timeOn")
    static let timeOff = Notification.Name("timeOff")
    static let timeIsUp = Notification.Name("timeIsUp")
    static let periodStart = Notification.Name("periodStart")
    static let periodEnd = Notification.Name("periodEnd")
    static let matchStart = Notification.Name("matchStart")
    static let matchEnd = Notification.Name("matchEnd")

    static let activatePlayerPage = Notification.Name("activatePlayerPage")
}
