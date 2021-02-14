//
//  YellowCardRowCtl.swift
//  RefWatchWatch Extension
//
//  Created by Martin Croker on 15/01/2020.
//  Copyright © 2020 Martin Croker. All rights reserved.
//

import Foundation
import WatchKit

class EventRowCtl : NSObject {

    @IBOutlet weak var eventTimeLabel: WKInterfaceLabel!
    @IBOutlet weak var teamLabel: WKInterfaceLabel!
    @IBOutlet weak var playerLabel: WKInterfaceLabel!
    @IBOutlet weak var eventTitleLabel: WKInterfaceLabel!
    @IBOutlet weak var sideBarSeperator: WKInterfaceSeparator!
    @IBOutlet weak var scoreLabel: WKInterfaceLabel!
    
    let match : Match = Match.getCurrentMatch();
    
    var event: MatchEvent? {
        didSet {
            
            let dateFormatter : DateComponentsFormatter = DateComponentsFormatter();
            dateFormatter.allowedUnits = [.minute, .second];
            dateFormatter.zeroFormattingBehavior = .pad;
            self.eventTimeLabel.setText(dateFormatter.string(from: event!.periodTime.time));
            self.eventTitleLabel.setText(event!.title);
            
            
            if let sanctionEvent = event! as? SanctionEvent {
                self.scoreLabel.setHidden(true);
                self.playerLabel.setHidden(false);
                self.playerLabel.setText(sanctionEvent.playerLabel);
                
                
            } else if let scoreEvent = event! as? ScoreEvent {
                self.scoreLabel.setText("\(match.homeTeam.scoreAt(gameTime: scoreEvent.gameTime)) - \(match.awayTeam.scoreAt(gameTime: scoreEvent.gameTime))");
                self.scoreLabel.setHidden(false);
                self.playerLabel.setHidden(true);
                
         
            } else if let clockEvent = event! as? ClockEvent {
                self.scoreLabel.setHidden(true);
                self.playerLabel.setHidden(true);
                
                
            } else {
                self.scoreLabel.setHidden(true);
                self.playerLabel.setHidden(true);
                
            }
                
            if let teamEvent = event! as? TeamEvent {
                self.sideBarSeperator.setHidden(false);
                self.sideBarSeperator.setColor(teamEvent.barColor);
                self.teamLabel.setHidden(false);
                self.sideBarSeperator.setHorizontalAlignment(teamEvent.team.barAlignment);
                self.teamLabel.setText(teamEvent.team.shortTitle);
                
                
            } else {
                self.sideBarSeperator.setHidden(true);
                self.teamLabel.setHidden(true);
                
            }
            
        }
        
    }
    
}
