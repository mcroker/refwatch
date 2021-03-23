//
//  InterfaceController.swift
//  RefWatchWatch Extension
//
//  Created by Martin Croker on 12/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import WatchKit
import Foundation

struct ScorePageContext {
    var team: MatchTeam
}

class ScoreIC: RefWatchSuperIC {
    
    private var context : ScorePageContext?;
    private let match : Match = MatchFactory.getCurrentMatch();
    
    override func awake(withContext: Any?) {
        self.context = (withContext as! ScorePageContext);
        super.awake(withContext: withContext);
        self.setTitle("\(context!.team.title) Score");
    }
    
    @IBAction func tryButtonClicked() {
        match.addEvent(TryScoredEvent(team: context!.team.teamKey));
        goShotPage(team: context!.team, shotType: .conv);
    }
    
    @IBAction func penalityGoalButtonClicked() {
        match.addEvent(PenGoalScoredEvent(team: context!.team.teamKey));
        goHomePage();
    }
    
    @IBAction func dropGoalButtonClicked() {
        match.addEvent(DropKickScoredEvent(team: context!.team.teamKey));
        goHomePage();
    }
    
    @IBAction func penltyTryButtonClocked() {
        match.addEvent(PenTryScoredEvent(team: context!.team.teamKey));
        goSanctionPage(team: context!.team);
    }
    
}
