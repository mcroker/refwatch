//
//  RefWatchContextSettings.swift
//  RefWatch
//
//  Created by Martin Croker on 13/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import Foundation

class RedCardPlayerEvent : SanctionEvent {
    
    override var title : String {
        get {
            if (nil != self.offenceIndex) {
                return "RC! \(super.title)";
            } else {
                return "Red Card";
            }
        }
    }
    
    override var barColor : Color {
        get {
            return Color.sanctionRC
        }
    }
        
}
