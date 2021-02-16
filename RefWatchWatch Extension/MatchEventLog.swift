
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
