//
//  RefWatchContextSettings.swift
//  RefWatch
//
//  Created by Martin Croker on 13/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import Foundation

enum TeamAction {
    case replacePlayer;
    case sanctionPlayer;
}

class SharedTeamState {

    fileprivate static var _instance: SharedTeamState = SharedTeamState();
    
    static func getInstance() -> SharedTeamState {
        return SharedTeamState._instance;
    }
    
    var escalation : EscalationState = .none;
    var offenceIndex : Int?;
    var player: Int?;
    var team: MatchTeam?;
    var action: TeamAction?;
    
    fileprivate init() {
    }
    
    func reset(team: MatchTeam, action: TeamAction) {
        self.team = team;
        self.action = action;
        self.escalation = EscalationState.none;
        self.player = nil;
        self.offenceIndex = nil;
    }
    
    func toEvent() -> TeamEvent {
        switch self.action! {
        case .sanctionPlayer:
            switch self.escalation {
            case .redCard:
                return RedCardPlayerEvent(team: self.team!.teamKey, player: self.player, offenceIndex : offenceIndex);
            case .yellowCard:
                return YellowCardPlayerEvent(team: self.team!.teamKey, player: self.player, offenceIndex : offenceIndex);
            case .caution:
                return CautionPlayerEvent(team: self.team!.teamKey, player: self.player, offenceIndex : offenceIndex);
            default:
                return SanctionEvent(team: self.team!.teamKey, player: self.player, offenceIndex : offenceIndex);
            }
        case .replacePlayer:
            return ReplacePlayerEvent(team: self.team!.teamKey, player: self.player);
        }
    }
    
    func toPlayerTitle() -> String {
        switch self.action! {
        case .sanctionPlayer:
            switch self.escalation {
            case .redCard:
                return "RC \(self.team!.title) Player";
            case .yellowCard:
                return "YC \(self.team!.title) Player";
            case .caution:
                return "Caution \(self.team!.title) Player";
            default:
                return "\(self.team!.title) Player";
            }
        case .replacePlayer:
            return "Replace \(self.team!.title) Player";
        }
    }

}
