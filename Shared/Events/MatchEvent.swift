//
//  RefWatchContextSettings.swift
//  RefWatch
//
//  Created by Martin Croker on 13/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import Foundation

class MatchEvent {
    
    public private(set) var realTime: RealTime;
    public private(set) var gameTime: GameTime;
    public private(set) var periodTime: PeriodTime;
    
    public let match : Match = MatchFactory.getCurrentMatch();
    public let settings : MatchSettings = MatchFactory.getCurrentMatch().settings;
    public let clock : MatchClock = MatchFactory.getCurrentMatch().clock;
    
    #if os(iOS)
    init(doEvent: DoEvent) {
        self.realTime = doEvent.realTime!;
        self.gameTime = doEvent.gameTime;
        self.periodTime = ( period: Int(doEvent.periodTimePeriod), time: doEvent.periodTimeTime);
    }
    #endif
    
    init() {
        self.realTime = clock.realTime;
        self.gameTime = clock.gameTime;
        self.periodTime = clock.periodTime;
    }
    
    var title : String {
        get {
            return "Match Event";
        }
    }
    
    var gameTimeSince : GameTime {
        return clock.gameTime - self.gameTime;
    }
    
}
