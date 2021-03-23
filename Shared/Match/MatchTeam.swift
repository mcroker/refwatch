//
//  RefWatchContext.swift
//  RefWatch
//
//  Created by Martin Croker on 12/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import Foundation

typealias PenStats = (
    count1: Int,
    inWarn1: Bool,
    inAlarm1: Bool,
    count2: Int,
    inWarn2: Bool,
    inAlarm2: Bool,
    countPeriod: Int,
    inWarnPeriod: Bool,
    inAlarmPeriod: Bool,
    countTotal: Int
);

class MatchTeam {
    
    private var eventLog : MatchEventLog;
    public private(set) var teamKey : Teams;
    private var clock : MatchClock;
    private let settings : MatchSettings;
    
    public var title : String {
        get {
            switch self.teamKey {
            case .home:
                return "Home"
            case .away:
                return "Away"
            }
        }
    }
    
    init(eventLog: MatchEventLog, team: Teams, clock: MatchClock, settings: MatchSettings) {
        self.eventLog = eventLog;
        self.teamKey = team;
        self.clock = clock;
        self.settings = settings;
    }
    
    func getScoreEvents() -> [ScoreEvent] {
        return self.eventLog.getEvents(ScoreEvent.self, team: self.teamKey);
    }
    
    func reset() {
        
    }
    
    var score : Int {
        get {
            return self.getScoreEvents().reduce(0) { $0 + $1.points };
        }
    };
    
    func scoreAt(gameTime: GameTime) -> Int {
        // TODO return self.getScoreEvents.filter
        return self.getScoreEvents().reduce(0) { $0 + $1.points };
    };
    
    func currentSanctions<T: SanctionEvent>(type:T.Type, max: Int? = nil) -> [T] {
        let sanctions: [T] = self.eventLog.getEvents(type, team: self.teamKey).filter { $0.isCurrent };
        let sortedSanctions: [T] = sanctions.sorted { $0.realTime < $1.realTime };
        if ( nil == max ) {
            return sortedSanctions;
        } else {
            return Array(sortedSanctions.prefix(max!));
        }
    }
    
    private func currentSanctionedPlayers<T: SanctionEvent>(type:T.Type, max: Int?) -> [String] {
        return currentSanctions(type: type, max: max).map { $0.playerLabel };
    }
    
    func redCardedPlayers(max: Int? = nil) -> [String] {
        return (currentSanctionedPlayers(type: RedCardPlayerEvent.self, max: max));
    }
    
    func yellowCardedPlayers(max: Int? = nil) -> [String] {
        return (currentSanctionedPlayers(type: YellowCardPlayerEvent.self, max: max));
    }
    
    func cautionedPlayers(max: Int? = nil) -> [String] {
        return (currentSanctionedPlayers(type: CautionPlayerEvent.self, max: max));
    }
    
    func getSanctions(since: GameTime? = nil, period: PeriodNum? = nil) -> [SanctionEvent] {
        return self.eventLog.getEvents(SanctionEvent.self, period: period, team: self.teamKey, since: since);
    }
    
    func getPenStats() -> PenStats {
        let sanctions = self.getSanctions();
        let count1 : Int = sanctions.filter { $0.gameTime >= clock.gameTime - settings.pkRecent1Mins }.count;
        let count2 : Int = sanctions.filter { $0.gameTime >= clock.gameTime - settings.pkRecent2Mins }.count;
        let countPeriod : Int = sanctions.filter { $0.periodTime.period == clock.periodTime.period }.count;
        let countTotal : Int = sanctions.count;
        let inWarn1 : Bool = (count1 >= settings.pkRecent1AmberThreshold && settings.pkRecent1AmberThreshold != 0 );
        let inAlarm1  : Bool = false;
        let inWarn2  : Bool = (count1 >= settings.pkRecent2AmberThreshold && settings.pkRecent2AmberThreshold != 0 );
        let inAlarm2  : Bool = false;
        let inWarnPeriod  : Bool = (count1 >= settings.pkRecent2AmberThreshold && settings.pkRecent2AmberThreshold != 0 );
        let inAlarmPeriod  : Bool = false;
        return (count1 : count1, inWarn1 : inWarn1, inAlarm1 : inAlarm1, count2 : count2, inWarn2 : inWarn2, inAlarm2 : inAlarm2, countPeriod : countPeriod, inWarnPeriod : inWarnPeriod, inAlarmPeriod : inAlarmPeriod, countTotal : countTotal);
    }
    
}
