
//
//  RefWatchContext.swift
//  RefWatch
//
//  Created by Martin Croker on 12/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import Foundation;

class Match {
    
    static fileprivate var _instance = Match();
    
    static func getCurrentMatch() -> Match {
        return _instance;
    }
    
    @discardableResult
    static func startNewMatch()  -> Match {
        self._instance.endMatch();
        self._instance = Match();
        return Match.getCurrentMatch();
    }
    
    public private(set) var matchID : Int;
    public private(set) var homeTeam : MatchTeam;
    public private(set) var awayTeam : MatchTeam;
    public private(set) var clock: MatchClock;
    private var eventLog: MatchEventLog;
    public private(set) var settings: MatchSettings;
    
    init() {
        self.matchID = Int(NSDate().timeIntervalSince1970);
        self.settings = MatchSettings();
        self.eventLog = MatchEventLog(matchID: self.matchID);
        self.clock = MatchClock(eventLog: self.eventLog, settings: self.settings);
        self.homeTeam = MatchTeam(eventLog: self.eventLog, team: .home, clock: self.clock, settings: self.settings);
        self.awayTeam = MatchTeam(eventLog: self.eventLog, team: .away, clock: self.clock, settings: self.settings);
    }
    
    func addEvent(_ event: MatchEvent) {
        self.eventLog.append(event);
    }
    
    func getSanctionEvents() -> [SanctionEvent] {
        return self.eventLog.getEvents(SanctionEvent.self);
    }
    
    func getEvents() -> [MatchEvent] {
        return self.eventLog.getEvents(MatchEvent.self);
    }
    
    func endMatch() {
        // TODo
    }
    
}
