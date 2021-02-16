//
//  YellowCardRowCtl.swift
//  RefWatchWatch Extension
//
//  Created by Martin Croker on 15/01/2020.
//  Copyright © 2020 Martin Croker. All rights reserved.
//

import Foundation
import UIKit

class EventRowCtl : NSObject {

    @IBOutlet weak var eventTimeLabel: UILabel!
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var eventTitleLabel: UILabel!
    // @IBOutlet weak var sideBarSeperator: UISeparator!
    @IBOutlet weak var scoreLabel: UILabel!
    
    let match : Match = Match.getCurrentMatch();
    
    var event: MatchEvent? {
        didSet {
            
            let dateFormatter : DateComponentsFormatter = DateComponentsFormatter();
            dateFormatter.allowedUnits = [.minute, .second];
            dateFormatter.zeroFormattingBehavior = .pad;
            self.eventTimeLabel.text = dateFormatter.string(from: event!.periodTime.time);
            self.eventTitleLabel.text = event!.title;
            
            
            if let sanctionEvent = event! as? SanctionEvent {
                self.scoreLabel.isHidden = true;
                self.playerLabel.isHidden = false;
                self.playerLabel.text = sanctionEvent.playerLabel;
                
                
            } else if let scoreEvent = event! as? ScoreEvent {
                self.scoreLabel.text = "\(match.homeTeam.scoreAt(gameTime: scoreEvent.gameTime)) - \(match.awayTeam.scoreAt(gameTime: scoreEvent.gameTime))";
                self.scoreLabel.isHidden = false;
                self.playerLabel.isHidden = true;
                
         
            } else if let clockEvent = event! as? ClockEvent {
                self.scoreLabel.isHidden = true;
                self.playerLabel.isHidden = true;
                
                
            } else {
                self.scoreLabel.isHidden = true;
                self.playerLabel.isHidden = true;
                
            }
                
            if let teamEvent = event! as? TeamEvent {
                // self.sideBarSeperator.isHidden =
                // self.sideBarSeperator.setColor(teamEvent.barColor);
                // self.teamLabel.isHidden = false;
                // self.sideBarSeperator.setHorizontalAlignment(teamEvent.team.barAlignment);
                self.teamLabel.text = teamEvent.team.shortTitle;
                
                
            } else {
                // self.sideBarSeperator.setHidden(true);
                self.teamLabel.isHidden = true;
                
            }
            
        }
        
    }
    
}
