//
//  InterfaceController.swift
//  RefWatchWatch Extension
//
//  Created by Martin Croker on 12/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import WatchKit
import Foundation

enum ShotType {
    case conv
    case pen
}

struct ShotPageContext {
    var team: MatchTeam
    var shotType: ShotType
}

class ShotIC: RefWatchSuperIC {
    
    @IBOutlet weak var gameClockTimer: WKInterfaceTimer!
    @IBOutlet weak var kickClockTimer: WKInterfaceTimer!
    
    var context : ShotPageContext?
    let match : Match = MatchFactory.getCurrentMatch()
    let clock : MatchClock =  MatchFactory.getCurrentMatch().clock
    let settings : MatchSettings = MatchFactory.getCurrentMatch().settings
    var kickClockStart : GameTime?
    var kickAllowedTime : GameTime?
    var kickTimer : Timer?
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(timeEventHandler(notification:)), name: .timeOn, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(timeEventHandler(notification:)), name: .timeOff, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(timeEventHandler(notification:)), name: .timeIsUp, object: nil)
    }
    
    override func awake(withContext: Any?) {
        self.context = (withContext as! ShotPageContext)
        super.awake(withContext: context)
        self.kickClockStart = clock.gameTime
        var actionString: String = ""
        switch (self.context!.shotType) {
        case .pen:
            actionString = "Shot@Goal"
            self.kickAllowedTime = settings.penGoalDuration
        case .conv:
            actionString = "Conversion"
            self.kickAllowedTime = settings.convDuration
        }
        self.setTitle("\(self.context!.team.title) \(actionString)")
    }
    
    override func willActivate() {
        drawClock();
    }
    
    @objc public func timeEventHandler(notification: NSNotification) {
        debugPrint("Processing Time Notification - Shot", notification)
        drawClock()
    }
    
    @objc func kickTimeExpired() {
        kickClockTimer.setTextColor(.clockExpired)
    }
    
    func drawClock() {
        gameClockTimer.setDate(clock.gameWKTimerDate)
        gameClockTimer.setTextColor(clock.gameClockTextColor)
        if clock.isTimeOn {
            gameClockTimer.start()
        } else {
            gameClockTimer.stop()
        }
        
        let kickTimeRemaining: GameTime = self.kickAllowedTime! - (clock.gameTime - self.kickClockStart!)
        if kickTimeRemaining > 0 {
            kickClockTimer.setDate(Date(timeIntervalSinceNow: kickTimeRemaining))
            if clock.isTimeOn {
                kickClockTimer.setTextColor(.clockActive)
                kickClockTimer.start()
                self.kickTimer = Timer.scheduledTimer( timeInterval: kickTimeRemaining, target: self, selector: #selector(kickTimeExpired), userInfo: nil, repeats: false)
            } else {
                kickClockTimer.setTextColor(.clockPaused)
                kickClockTimer.stop()
                if nil != self.kickTimer {
                    self.kickTimer!.invalidate()
                }
                
            }
        }
        
    }

    @IBAction func noScoreButtonClick() {
        goHomePage()
    }
    
    @IBAction func scoreButtonClick() {
        switch (context!.shotType) {
        case .pen:
            match.addEvent(PenGoalScoredEvent(team: context!.team.teamKey))
        case .conv:
            match.addEvent(ConversionScoredEvent(team: context!.team.teamKey))
        }
        goHomePage()
    }
    
    @IBAction func clockButtonClick() {
        clock.isTimeOn = !clock.isTimeOn
    }
    
}
