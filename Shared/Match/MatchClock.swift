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

typealias GameTime = TimeInterval;
typealias RealTime = Date;
typealias PeriodTime = (period: Int, time: GameTime);
typealias ElapsedTime = TimeInterval;

class MatchClock {
    
    private var eventLog : MatchEventLog;
    private let settings : MatchSettings;
    private var priorPeriods : [MatchClockPeriod] = [];
    public private(set) var currentPeriod : MatchClockPeriod?;
    private var currentPeriodNo : Int = 0;
    private var lastElapsedEpoch : Date?;
    
    init(eventLog: MatchEventLog, settings: MatchSettings) {
        self.eventLog = eventLog;
        self.settings = settings;
    }
    
    private func startNewPeriod() {
        if nil != self.currentPeriod {
            self.endCurrentPeriod();
        }
        if self.currentPeriodNo != settings.periodsInMatch {
            self.currentPeriodNo += 1;
            self.currentPeriod = MatchClockPeriod(periodNo: self.currentPeriodNo, eventLog: eventLog, settings: settings);
            self.currentPeriod!.timeOn();
            self.lastElapsedEpoch = Date();
        }
        
    }
    
    func endCurrentPeriod() {
        if nil != self.currentPeriod {
            self.currentPeriod!.timeOff();
            let period = self.currentPeriod!
            self.currentPeriod = nil;
            self.priorPeriods.append(period);
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
            return self.priorPeriods.count > 0 || nil != self.currentPeriod
        }
    }
    
    var isMatchEnded : Bool {
        get {
            return nil == self.currentPeriod && self.currentPeriodNo == settings.periodsInMatch
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
        } else if priorPeriods.count > 0 {
            let lastPeriod = priorPeriods[priorPeriods.count - 1];
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
        for priorPeriod in self.priorPeriods {
            gameTime += priorPeriod.getGameTime(realTime);
        }
        if self.isPeriodActive {
            gameTime += self.currentPeriod!.getGameTime(realTime);
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
    
    var gameClockTextColor : UIColor {
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
    
    var elapsedClockTextColor : UIColor {
        get {
            return (self.isMatchActive) ? .clockActive : .clockPaused
        }
    }
    
}
