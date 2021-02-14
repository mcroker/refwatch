//
//  InterfaceController.swift
//  RefWatchWatch Extension
//
//  Created by Martin Croker on 12/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import WatchKit
import Foundation
import UIKit
import UserNotifications

class MainIC: RefWatchSuperIC {
    
    @IBOutlet var WKGameTimer: WKInterfaceTimer!
    @IBOutlet var WKElapsedTimer: WKInterfaceTimer!
    @IBOutlet var WKTimeButton: WKInterfaceButton!
    @IBOutlet var WKHomeScore: WKInterfaceLabel!
    @IBOutlet var WKAwayScore: WKInterfaceLabel!
    @IBOutlet var WKGrpHomeOff: WKInterfaceGroup!
    @IBOutlet var WKHomeOffP: WKInterfaceLabel!
    @IBOutlet var WKHomeCautionP: WKInterfaceLabel!
    
    @IBOutlet weak var homeOuterGroup: WKInterfaceGroup!
    @IBOutlet weak var awayOuterGroup: WKInterfaceGroup!
    
    @IBOutlet var WKAwayOffP: WKInterfaceLabel!
    @IBOutlet var WKAwayCautionP: WKInterfaceLabel!
    
    @IBOutlet var homePKRecent1: WKInterfaceLabel!
    @IBOutlet var homePKRecent2: WKInterfaceLabel!
    @IBOutlet var homePKTotal: WKInterfaceLabel!
    @IBOutlet var awayPKRecent1: WKInterfaceLabel!
    @IBOutlet var awayPKRecent2: WKInterfaceLabel!
    @IBOutlet var awayPKTotal: WKInterfaceLabel!
    
    @IBOutlet weak var homeCurrentSanctions: WKInterfaceTable!
    @IBOutlet weak var awayCurrentSanctions: WKInterfaceTable!
    
    
    var myTimer : Timer?  //internal timer to keep track
    var TimerInterval : TimeInterval = 1
    
    var _oldIsTimeUp : Bool = false;
    
    private let match : Match = Match.getCurrentMatch();
    private let settings : MatchSettings = Match.getCurrentMatch().settings;
    private let clock : MatchClock = Match.getCurrentMatch().clock;
    
    override init() {
        super.init();
        NotificationCenter.default.addObserver(self, selector: #selector(timeEventHandler(notification:)), name: .timeOn, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(timeEventHandler(notification:)), name: .timeOff, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(timeEventHandler(notification:)), name: .timeIsUp, object: nil);
        // NotificationCenter.default.addObserver(self, selector: #selector(periodStartEventHandler(notification:)), name: .periodStart, object: nil);
        // NotificationCenter.default.addObserver(self, selector: #selector(periodEndEventHandler(notification:)), name: .periodEnd, object: nil);
        // NotificationCenter.default.addObserver(self, selector: #selector(matchEndEventHandler(notification:)), name: .matchStart, object: nil);
        // NotificationCenter.default.addObserver(self, selector: #selector(matchEndEventHandler(notification:)), name: .matchEnd, object: nil);
    }
        
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        self.draw()
    }
    
    @objc public func timeEventHandler(notification: NSNotification) {
        debugPrint("Processing Time Notification", notification)
        self.drawClock()
        self.drawContextMenu()
    }
    
    @objc public func periodStartEventHandler(notification: NSNotification) {
        debugPrint("Processing Period Start Notification", notification)
    }
    
    @objc public func periodEndEventHandler(notification: NSNotification) {
        debugPrint("Processing Period End Notification", notification)
    }
    
    @objc public func matchEndEventHandler(notification: NSNotification) {
        debugPrint("Processing Match End Notification", notification)
    }
    
    @objc public func matchStartEventHandler(notification: NSNotification) {
        debugPrint("Processing Match Start Notification", notification)
    }
    
    func draw() {
        homeOuterGroup.setBackgroundColor(settings.homeColor)
        awayOuterGroup.setBackgroundColor(settings.awayColor)
        drawSanctions()
        drawPKTracking()
        drawScores()
        drawClock()
        drawContextMenu()
    }
    
    func drawScores() {
        WKAwayScore.setText(String(match.awayTeam.score))
        WKHomeScore.setText(String(match.homeTeam.score))
    }
    
    func drawPKTracking() {
        let homePen = match.homeTeam.getPenStats()
        let awayPen = match.awayTeam.getPenStats()
        
        homePKRecent1.setText(String(homePen.count1));
        awayPKRecent1.setText(String(awayPen.count1));
        homePKRecent1.setTextColor((homePen.inWarn1) ? .penCountWarn : .penCountOK )
        awayPKRecent1.setTextColor((awayPen.inWarn1) ? .penCountWarn : .penCountOK )
        
        // If PKDuration2 = periodduration, show based on period rather than gametime
        if (settings.pkRecent2Mins != settings.periodDuration) {
            homePKRecent2.setText(String(homePen.count2))
            awayPKRecent2.setText(String(awayPen.count2))
            homePKRecent1.setTextColor((homePen.inWarn2) ? .penCountWarn : .penCountOK )
            awayPKRecent1.setTextColor((awayPen.inWarn2) ? .penCountWarn : .penCountOK )
        } else {
            homePKRecent2.setText(String(homePen.countPeriod))
            awayPKRecent2.setText(String(awayPen.countPeriod))
            homePKRecent1.setTextColor((homePen.inWarnPeriod) ? .penCountWarn : .penCountOK )
            awayPKRecent1.setTextColor((awayPen.inWarnPeriod) ? .penCountWarn : .penCountOK )
        }

        homePKTotal.setText(String(homePen.countTotal))
        awayPKTotal.setText(String(awayPen.countTotal))
    }
    
    func drawSanctions() {
        WKHomeOffP.setText(match.homeTeam.redCardedPlayers().joined(separator: ","))
        WKAwayOffP.setText(match.awayTeam.redCardedPlayers().joined(separator: ","))
        WKHomeCautionP.setText(match.homeTeam.cautionedPlayers().joined(separator: ","))
        WKAwayCautionP.setText(match.awayTeam.cautionedPlayers().joined(separator: ","))
        
        let homeYCs = match.homeTeam.currentSanctions(type: YellowCardPlayerEvent.self, max: 2)
        homeCurrentSanctions.setNumberOfRows(homeYCs.count, withRowType: "YC")
        for (index, event) in homeYCs.enumerated() {
            let row = homeCurrentSanctions.rowController(at: index) as! YCRowCtl
            row.event = event
        }
        
        let awayYCs = match.awayTeam.currentSanctions(type: YellowCardPlayerEvent.self, max: 2)
        awayCurrentSanctions.setNumberOfRows(awayYCs.count, withRowType: "YC")
        for (index, event) in awayYCs.enumerated() {
            let row = awayCurrentSanctions.rowController(at: index) as! YCRowCtl
            row.event = event
        }
    }
    
    private func drawClock() {
        WKElapsedTimer.setTextColor(clock.elapsedClockTextColor)
        WKElapsedTimer.setDate(clock.elapsedWKTimerDate)
        if clock.isMatchActive {
            WKElapsedTimer.start()
        } else {
            WKElapsedTimer.stop()
        }
        WKTimeButton.setEnabled(clock.isPeriodActive)
        WKGameTimer.setTextColor(clock.gameClockTextColor)
        WKGameTimer.setDate(clock.gameWKTimerDate)
        if clock.isTimeOn {
            WKGameTimer.start()
        } else {
            WKGameTimer.stop()
        }
    }
    
    func drawContextMenu() {
        self.clearAllMenuItems();
        if clock.isMatchActive {
            if clock.isPeriodActive {
                if ((2 * clock.currentPeriod!.periodNo) == settings.periodsInMatch) {
                    self.addMenuItem(with: WKMenuItemIcon.shuffle, title: "Half-Time", action: #selector(endPeriod))
                } else if (clock.currentPeriod!.periodNo == settings.periodsInMatch) {
                    self.addMenuItem( with: WKMenuItemIcon.decline, title: "Full-Time", action: #selector(endPeriod))
                } else {
                    self.addMenuItem(with: WKMenuItemIcon.shuffle, title: "End Period", action:  #selector(endPeriod))
                }
            } else {
               self.addMenuItem(with: WKMenuItemIcon.play, title: "Restart",action: #selector(startClock))
            }
        } else if !clock.isMatchEnded {
            self.addMenuItem(with: WKMenuItemIcon.play, title: "Kick-Off",action: #selector(startClock))
        }
    }
    
    @IBAction func eventsMenuClick() {
        goEventList()
    }
    
    @objc func endPeriod() {
        clock.endCurrentPeriod()
        draw()
    }
    
    @objc func startClock() {
        clock.timeOn()
        draw()
    }

    @IBAction func settingsMenuClick() {
        presentController(withName: "SettingsCtl" , context: nil)
    }
    
    @IBAction func startNewMatch() {
        Match.startNewMatch();
    }

    @IBAction func timeButtonClick() {
        clock.isTimeOn = !clock.isTimeOn;
    }

    @IBAction func homeScoreButtonClick() {
        goTeamMenuPage(team: match.homeTeam);
    }

    @IBAction func awayScoreButtonClick() {
        goTeamMenuPage(team: match.awayTeam);
    }

}
