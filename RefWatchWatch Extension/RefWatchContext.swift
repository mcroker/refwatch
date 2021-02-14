//
//  RefWatchContextSettings.swift
//  RefWatch
//
//  Created by Martin Croker on 13/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import Foundation

enum RefWatchStates {
    case main;
    case homeTeamMenu;
    case awayTeamMenu;
    case replacePlayer;
    case shotAtGoalAttemptInProgress;
    case conversionAttemptInProgress;
    case sendOffPlayer;
    case cautionPlayer;
    case sinBinPlayer;
    case penaltyTryAwarded;
    case showSummary;
}

class RefWatchContext {

    fileprivate static var _instance: RefWatchContext = RefWatchContext();
    
    static func getInstance() -> RefWatchContext {
        return RefWatchContext._instance;
    }
    
    var team : MatchTeam?;
    var state: RefWatchStates = .main;
    var event: TeamEvent?;
    
    fileprivate init() {
    }
    
    func reset() {
        self.team = nil;
        self.event = nil;
        self.state = .main;
    }

}
