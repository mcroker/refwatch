//
//  InterfaceController.swift
//  RefWatchWatch Extension
//
//  Created by Martin Croker on 12/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import WatchKit
import Foundation

struct TeamMenuPageContext {
    var team: MatchTeam
}

class TeamMenuIC: RefWatchSuperIC {
    
    @IBOutlet weak var sanctionButton: WKInterfaceButton!
    @IBOutlet weak var scoreButton: WKInterfaceButton!
    @IBOutlet weak var shotButton: WKInterfaceButton!
    @IBOutlet weak var replacementButton: WKInterfaceButton!
    @IBOutlet weak var summaryButton: WKInterfaceButton!
    @IBOutlet weak var cancelButton: WKInterfaceButton!
    
    
    var context : TeamMenuPageContext?
    var clock : MatchClock = Match.getCurrentMatch().clock;
    
    override func awake(withContext: Any?) {
        self.context = (withContext as! TeamMenuPageContext)
        self.setTitle("\(context!.team.title) Team Menu")
    }
    
    override func willActivate() {
        sanctionButton.setHidden(!clock.isMatchActive);
        scoreButton.setHidden(!clock.isMatchActive);
        shotButton.setHidden(!clock.isMatchActive);
        replacementButton.setHidden(!clock.isMatchActive);
    }
    
    @IBAction func sanctionButtonClick() {
        goSanctionPage(team: context!.team);
    }
    
   @IBAction func scoreButtonClick() {
        goScorePage(team: context!.team );
    }
    
    @IBAction func shotButtonClick() {
        goShotPage(team: context!.team, shotType: .pen );
    }
    
    @IBAction func replacementButtonClick() {
        goReplacePlayerPage(team: context!.team);
    }
    
    @IBAction func summaryButtonClick() {
        // context.state = .showSummary;
        presentController(withName: "TeamSummary", context: context);
    }
    
    @IBAction func cancelButtonClick() {
        // context.state = .showSummary;
        goHomePage()
    }
    
    @IBAction func colorButtonClick() {
        let contextObj : TeamOptionsPageContext = TeamOptionsPageContext( team: context!.team );
        presentController(withName: "TeamColor", context: contextObj);
    }
    
}
