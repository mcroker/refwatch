//
//  RefWatchNav.swift
//  RefWatchWatch Extension
//
//  Created by Martin Croker on 17/01/2020.
//  Copyright © 2020 Martin Croker. All rights reserved.
//

import Foundation
import WatchKit

class RefWatchSuperIC : WKInterfaceController {
    
    func goHomePage() {
        WKInterfaceController.reloadRootPageControllers(withNames: ["Main"], contexts: nil, orientation: .horizontal, pageIndex: 0);
    }
    
    func goSanctionPage(team: MatchTeam) {
        SharedTeamState.getInstance().reset(team: team, action: .sanctionPlayer);
        WKInterfaceController.reloadRootPageControllers(withNames: ["Sanction", "Player"], contexts: nil, orientation: .horizontal, pageIndex:0);
    }
    
    func goScorePage(team: MatchTeam) {
        let contextObj : ScorePageContext = ScorePageContext( team: team );
        presentController(withName: "Score", context: contextObj);
        // WKInterfaceController.reloadRootPageControllers(withNames: ["Score"], contexts: [ contextObj ], orientation: .horizontal, pageIndex: 0);
    }
    
    func goTeamMenuPage(team: MatchTeam) {
        let contextObj : TeamMenuPageContext = TeamMenuPageContext( team: team );
        presentController(withName: "TeamMenu", context: contextObj);
        // WKInterfaceController.presentController(withName: "TeamMenu", context: contextObj);
    }
    
    func goReplacePlayerPage(team: MatchTeam) {
        // SharedTeamState.getInstance().reset(team: team, action: .replacePlayer);
        WKInterfaceController.reloadRootPageControllers(withNames: ["Player"], contexts: nil, orientation: .horizontal, pageIndex: 0);
    }
    
    func activatePlayerPage() {
        NotificationCenter.default.post(name: .activatePlayerPage, object: nil);
    }
    
    func goShotPage(team: MatchTeam, shotType: ShotType) {
        let contextObj : ShotPageContext = ShotPageContext( team: team, shotType: shotType);
        WKInterfaceController.reloadRootPageControllers(withNames: ["Shot"], contexts: [ contextObj ], orientation: .horizontal, pageIndex: 0);
    }
    
    func goEventList() {
        presentController(withName: "EventList" , context: nil);
    }
    
}
