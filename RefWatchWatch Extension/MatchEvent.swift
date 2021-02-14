//
//  RefWatchContextSettings.swift
//  RefWatch
//
//  Created by Martin Croker on 13/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import Foundation

//class MatchEvent : Hashable {
class MatchEvent {

    /*
    static func == (lhs: MatchEvent, rhs: MatchEvent) -> Bool {
        return (lhs.realTime == rhs.realTime);
    } */

    public private(set) var realTime: RealTime;
    public private(set) var gameTime: GameTime;
    public private(set) var periodTime: PeriodTime;
    
    public let match : Match = Match.getCurrentMatch();
    public let settings : MatchSettings = Match.getCurrentMatch().settings;
    public let clock : MatchClock = Match.getCurrentMatch().clock;
    
    /* func hash(into hasher: inout Hasher) {
        hasher.combine(self.timeAwarded)
    } */
    
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
