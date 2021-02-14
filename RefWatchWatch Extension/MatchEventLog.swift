
//
//  RefWatchContext.swift
//  RefWatch
//
//  Created by Martin Croker on 12/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import Foundation;

class MatchEventLog {
    
    public private(set) var matchID: Int;
    private var _events : [AnyObject] = [AnyObject]();
    
    init(matchID: Int) {
        self.matchID = matchID;
        self._events = [];
    }
    
    func append(_ newEvent: MatchEvent) {
        self._events.append(newEvent);
    }
    
    /*
    func getEvents() -> [MatchEvent] {
        return self._events.map { $0 as! MatchEvent }.sorted { $0.realTime < $1.realTime };
    }
    
    func getEventsByType<T: MatchEvent>(_ type : T.Type, max: Int? = nil) -> [T] {
        let matchingEvents = self.getEvents().filter { $0 is T }.map { $0 as! T };
        if (nil == max) {
            return matchingEvents;
        } else {
            return Array(matchingEvents.prefix(max!));
        }
    }

    func getPeriodStartEvent(_ periodNo: Int) -> ClockPeriodEvent? {
        let startEvents = self.getEvents(type: ClockPeriodEvent.self)
            .filter { $0.periodNo == periodNo && $0.startsClock };
        if startEvents.count > 0 {
            return startEvents[0];
        } else {
            return nil;
        }
    }
    
    func getPeriodEndEvent(_ periodNo: Int) -> ClockPeriodEvent? {
        let stopEvents = self.getEvents(type: ClockPeriodEvent.self)
            .filter { $0.periodNo == periodNo && $0.stopsClock };
        if stopEvents.count > 0 {
            return stopEvents[stopEvents.count - 1];
        } else {
            return nil;
        }
    }
     */
    
    func getEvents<T : MatchEvent>(_ type: T.Type,
                                   period: Int? = nil,
                                   team: MatchTeam? = nil,
                                   max: Int? = nil,
                                   latest: GameTime? = nil,
                                   since: GameTime? = nil
    ) -> [T] {
        
        var matchingEvents : [T] = self._events
            .filter { $0 is T }
            .map { $0 as! T }
            .sorted { $0.realTime < $1.realTime };
        
        if nil != period {
            matchingEvents = matchingEvents.filter { $0.periodTime.period == period };
        }
        
        if nil != latest {
            matchingEvents = matchingEvents.filter { $0.gameTime <= latest! };
        }
        
        if nil != since {
            matchingEvents = matchingEvents.filter { $0.gameTime >= since! };
        }
        
        if nil != team {
            matchingEvents = matchingEvents.filter { ($0 is TeamEvent) && (($0 as! TeamEvent).team.teamKey == team!.teamKey) };
        }
        
        if nil == max {
            return matchingEvents
        } else {
            return Array(matchingEvents.prefix(max!));
        }
    }
    
}
