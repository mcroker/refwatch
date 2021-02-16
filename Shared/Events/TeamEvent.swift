//
//  RefWatchContextSettings.swift
//  RefWatch
//
//  Created by Martin Croker on 13/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import Foundation
#if os(iOS)
    import UIKit
#elseif os(watchOS)
    import WatchKit
#endif

class TeamEvent : MatchEvent {

    public var player : Int?;
    public var team: MatchTeam;
    
    init(team: MatchTeam, player: Int? = nil) {
        self.team = team;
        self.player = player;
        super.init();
    }
    
    var playerLabel : String {
        get {
            return (nil != self.player) ? String(self.player!) : "#";
        }
    }
    
    var barColor : UIColor {
        get {
            return UIColor.unspecifiedTeamEvent
        }
    }
    
}
