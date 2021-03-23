//
//  DoMatchClock.swift
//  RefWatch
//
//  Created by Martin Croker on 16/02/2021.
//  Copyright © 2021 Martin Croker. All rights reserved.
//

import Foundation
/*
 We have:
 - realtime (as set by Greenwich)
 - gametime (00:00 at KO, stops when ball goes dead, each period starts where previous finished - eg. if 1st half overruns 2nd half might start at 41:12)
 - periodtime (resets to 00:00 at start of period, stops when ball goes deal)
 - elapsedtime (resets to 00:00 at start of period, does not stop)
 
 As rugby continues until the ball goes dead, it is perfectly normal for the first half to last 40:30
 When this happens the clock resets to 40:00 for the 2nd half - but the time played after 40:00 still counts as game-time (e.g. for sinbins)
 
 An offence conducted at 40:15, could either be at the end of half-1 or at the start of half-2 (i.e. 40:15 occurs twice in a game).
 
 This is represented as:
 
 40:15 (period1) --> RealTime=15:50:15   GameTime=40:15              PeriodTime=1,40:15
 40:15 (period2) --> RealTime=16:00:15   GameTime=40:45(40:30+00:15) PeriodTime=2,00:15
 
 Assuming
 period1 KO at 15:00 and last 50:30 (40:30 game time, plus 10min timeOff before the event)
 period2 KO at 16:00 with no stopages before the event.
 */

extension DoMatch {
    
    var currentPeriod: ActivePeriod? {
        get {
            if nil != self.currentPeriodNo {
                let period = self.periods!.first { $0.periodNo! == self.currentPeriodNo! };
                return DxPeriod(period);
            } else {
                return nil;
            }
        }
    }
    
    private func startNewPeriod() {
        if nil != self.currentPeriodNo {
            self.endCurrentPeriod();
        }
        if self.currentPeriodNo != self.periodsInMatch {
            self.currentPeriodNo += 1;
            let newPeriod = DxPeriod(periodNo: self.currentPeriodNo);
            newPeriod.timeOn();
            self.addToPeriods(newPeriod);
            self.lastElapsedEpoch = Date();
        }
        
    }
    
    func endCurrentPeriod() {
        if nil != self.currentPeriod {
            let period = self.currentPeriod!
            period.timeOff();
            period.endPeriod();
            self.lastElapsedEpoch = Date();
        }
    }
    
    var isPeriodActive : Bool {
        get {
            return (nil != self.currentPeriod) ? self.currentPeriod!.isPeriodActive : false;
        }
    }
    
    var isMatchActive : Bool {
        get {
            return self.isMatchStarted && !self.isMatchEnded
        }
    }
    
    var isMatchStarted : Bool {
        get {
            return self.periods!.count > 0
        }
    }
    
    var isMatchEnded : Bool {
        get {
            return nil == self.currentPeriod && self.currentPeriodNo == self.periodsInMatch
        }
    }
    
    func timeOn() {
        
        if self.isPeriodActive {
            self.currentPeriod!.timeOn();
        } else {
            self.startNewPeriod();
        }
    }
    
    func timeOff() {
        if self.isPeriodActive {
            self.currentPeriod!.timeOff();
        }
    }
    
    var isTimeOn : Bool {
        get {
            if self.isPeriodActive {
                return self.currentPeriod!.isTimeOn;
            } else {
                return false;
            }
        }
        set {
            if (self.isTimeOn != newValue) {
                if newValue {
                    self.timeOn();
                } else {
                    self.timeOff();
                }
            }
        }
    }
    
    var isTimeUp : Bool? {
        get {
            if nil != self.currentPeriod {
                return self.currentPeriod!.isTimeUp
            } else {
                return nil;
            }
        }
    }
    
    var gameTime: GameTime {
        get {
            return self.getGameTime();
        }
    }
    
    var periodTime: PeriodTime {
        if self.isPeriodActive {
            return (period: self.currentPeriodNo, time: self.currentPeriod!.gameTime);
        } else if self.periods!.count > 0 {
            let lastPeriod = self.periods!.count - 1;
            return (period: lastPeriod.periodNo, time: lastPeriod.gameTime);
        } else {
            return (period: 1, GameTime(0));
        }
    }
    
    var realTime: RealTime {
        return Date();
    }
    
    func getGameTime(_ realtime: RealTime = Date()) -> GameTime {
        var gameTime : GameTime = 0.0;
        for period in self.periods! {
            gameTime += period.getGameTime(realTime);
        }
        return gameTime;
    }
    
    func getGameWKTimerDate(gameTime : GameTime? = nil) -> Date {
        if self.isPeriodActive {
            return Date(timeIntervalSinceNow: 0 - self.currentPeriod!.gameTime)
        } else {
            return Date();
        }
    }
    
    var gameWKTimerDate: Date {
        get {
            return self.getGameWKTimerDate()
        }
    }
    
    var elapsedWKTimerDate: Date {
        get {
            if nil != self.lastElapsedEpoch {
                return self.lastElapsedEpoch!
            } else {
                return Date();
            }
        }
    }
    
    var gameClockTextColor : Color {
        get {
            if self.isTimeOn {
                if self.isTimeUp ?? false {
                    return .clockExpired
                }
                else {
                    return .clockActive
                }
            } else {
                return .clockPaused
            }
        }
    }
    
    var elapsedClockTextColor : Color {
        get {
            return (self.isMatchActive) ? .clockActive : .clockPaused
        }
    }
    
}

