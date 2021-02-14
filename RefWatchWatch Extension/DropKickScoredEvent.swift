//
//  RefWatchContextSettings.swift
//  RefWatch
//
//  Created by Martin Croker on 13/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import Foundation

// If not subclassed - this is a pen-only
class DropKickScoredEvent : ScoreEvent {
    
    override var points: Int {
        get {
            return settings.dropKickPoints;
        }
    }
    
    override public var title : String {
        return "Drop-Kick"
    }
    
}
