//
//  RefWatchContextSettings.swift
//  RefWatch
//
//  Created by Martin Croker on 13/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import Foundation

class ScoreEvent : TeamEvent {
    
    #if os(iOS)
    override init(doEvent: DoEvent) {
        super.init(doEvent: doEvent);
    }
    #endif
    
    var points: Int {
        get {
            return 0;
        }
    }
    
    override public var title : String {
        return "Score"
    }
    
    override var barColor : Color {
        get {
            return Color.score
        }
    }
    
}
