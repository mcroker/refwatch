//
//  RefWatchContextSettings.swift
//  RefWatch
//
//  Created by Martin Croker on 13/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import Foundation

typealias DoPlayer = Int16;

enum DoTeamCode : Int16 {
    case home = 0
    case away = 1
}

extension DoTeamEvent {
    
    convenience init(team: DoTeamCode, player: DoPlayer? = 0) {
        self.init();
        self.initTeam(team: team, player: player);
    }
    
    func initTeam(team: DoTeamCode, player: DoPlayer? = 0) {
        self.team = team;
        self.player = player;
    }
    
    var team:DoTeamCode {
        get { return DoTeamCode(rawValue: self.teamCode)! }
        set { self.teamCode = newValue.rawValue }
    }
    
    var playerLabel : String {
        get {
            return (0 != self.player) ? String(self.player) : "#";
        }
    }
    
    var barColor : Color {
        get {
            return Color.unspecifiedTeamEvent
        }
    }
    
}
