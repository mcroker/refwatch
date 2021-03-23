//
//  RefWatchContextSettings.swift
//  RefWatch
//
//  Created by Martin Croker on 13/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import Foundation

class TeamEvent : MatchEvent {

    public var player : Int?;
    public var team: Teams;
    
    #if os(iOS)
    override init(doEvent: DoEvent) {
        self.team = doEvent.teamEnum;
        self.player = Int(doEvent.player);
        super.init(doEvent: doEvent);
    }
    #endif
    
    init(team: Teams, player: Int? = nil) {
        self.team = team;
        self.player = player;
        super.init();
    }
    
    var playerLabel : String {
        get {
            return (nil != self.player) ? String(self.player!) : "#";
        }
    }
    
    var barColor : Color {
        get {
            return Color.unspecifiedTeamEvent
        }
    }
    
}
