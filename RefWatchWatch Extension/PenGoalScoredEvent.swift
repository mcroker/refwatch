//
//  RefWatchContextSettings.swift
//  RefWatch
//
//  Created by Martin Croker on 13/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import Foundation

class PenGoalScoredEvent : ScoreEvent {
    
    override var points: Int {
        get {
            return settings.penGoalPoints;
        }
    }
    
    override public var title : String {
        return "Penality Goal"
    }
    
}
