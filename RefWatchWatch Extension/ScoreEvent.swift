//
//  RefWatchContextSettings.swift
//  RefWatch
//
//  Created by Martin Croker on 13/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import Foundation
import WatchKit

class ScoreEvent : TeamEvent {
    
    var points: Int {
        get {
            return 0;
        }
    }
    
    override public var title : String {
        return "Score"
    }
    
    override var barColor : UIColor {
        get {
            return UIColor.score
        }
    }
    
}
