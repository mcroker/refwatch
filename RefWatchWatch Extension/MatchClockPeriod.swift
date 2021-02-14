//
//  RefWatchContextSettings.swift
//  RefWatch
//
//  Created by Martin Croker on 13/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//
import Foundation
import WatchKit

class MatchClockPeriod {
    
    private let eventLog : MatchEventLog
    private let settings: MatchSettings
    public private(set) var periodNo: Int
    public private(set) var periodStartTime: RealTime?
    public private(set) var periodEndTime: RealTime?
    private var tickTimer : Timer?
    private var alreadySentTimeUpEvent : Bool = false;
    
    init(periodNo: Int, eventLog: MatchEventLog, settings: MatchSettings) {
        self.periodNo = periodNo
        self.eventLog = eventLog
        self.settings = settings
    }
    
    @objc func tickTimerEvent() {
        if self.isTimeUp && !self.alreadySentTimeUpEvent {
            NotificationCenter.default.post(name: .timeIsUp, object: nil)
            self.alreadySentTimeUpEvent = true
        }
    }
    
    var isPeriodActive : Bool {
        get {
            return nil != self.periodStartTime && nil == self.periodEndTime
        }
    }
    
    private func startPeriod() {
        self.periodStartTime = Date()
        self.alreadySentTimeUpEvent = false;
        if self.periodNo == 1 {
            NotificationCenter.default.post(name: .matchStart, object: nil)
            self.eventLog.append(ClockMatchEvent(eventType: ClockEventType.matchStart))
        } else {
            self.eventLog.append(ClockPeriodEvent(eventType: ClockEventType.periodStart))
        }
        NotificationCenter.default.post(name: .periodStart, object: nil)
    }
    
    func endPeriod() {
        self.timeOff()
        self.periodEndTime = Date()
        NotificationCenter.default.post(name: .periodEnd, object: nil)
        if settings.periodsInMatch == self.periodNo {
            NotificationCenter.default.post(name: .matchEnd, object: nil)
            self.eventLog.append(ClockMatchEvent(eventType: ClockEventType.matchEnd))
        } else {
            self.eventLog.append(ClockPeriodEvent(eventType: ClockEventType.periodEnd))
        }
    }
    
    func timeOn() {
        if !self._isTimeOn {
            self._isTimeOn = true
            if self.isPeriodActive {
                self.eventLog.append(ClockEvent(eventType: ClockEventType.timeOn));
            } else {
                self.startPeriod();
            }
            NotificationCenter.default.post(name: .timeOn, object: nil)
            self.tickTimer = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(tickTimerEvent), userInfo: nil, repeats: true)
        }
    }
    
    func timeOff() {
        if self._isTimeOn {
            self._isTimeOn = false
            self.eventLog.append(ClockEvent(eventType: ClockEventType.timeOff))
            NotificationCenter.default.post(name: .timeOff, object: nil)
            self.tickTimer?.invalidate()
        }
    }
    
    private var _isTimeOn : Bool = false;
    var isTimeOn : Bool {
        get {
            return _isTimeOn;
        }
        set {
            if newValue {
                self.timeOn();
            } else {
                self.timeOff();
            }
        }
    }
    
    private func getClockEvents() -> [ClockEvent] {
        return self.eventLog.getEvents(ClockEvent.self, period: self.periodNo);
    }
    
    /*
    private func reloadEventLog() {
        let periodStartEvent = self.eventLog.getPeriodStartEvent(self.periodNo);
        if nil != periodStartEvent {
            self.periodStartTime = periodStartEvent!.realTime;
            let periodEndEvent = self.eventLog.getPeriodEndEvent(self.periodNo);
            self.periodEndTime = (nil != periodEndEvent) ? periodEndEvent!.realTime : nil;
            let clockEvents = self.getClockEvents();
            self._isTimeOn = (0 > clockEvents.count) ? clockEvents[clockEvents.count - 1].startsClock : false;
        } else {
            self.periodStartTime = nil;
            self.periodEndTime = nil;
            self._isTimeOn = false;
        }
    } */
    
    var periodTime: PeriodTime {
        return (period: self.periodNo, time: self.gameTime);
    }
    
    var gameTime: GameTime {
        get {
            return self.getGameTime();
        }
    }
    
    var elapsedTime : ElapsedTime {
        get {
            return self.getElapsedTime() ?? ElapsedTime(0);
        }
    }
    
    var remainingGameTime: GameTime {
        get {
            let remainingTime = settings.periodDuration - self.gameTime;
            return (remainingTime >= 0) ? remainingTime : 0;
        }
    }
    
    // When would the period end if there were no more stoppages;
    var earliestPossibleEndTime : RealTime? {
        if self.isPeriodActive {
            return Date(timeIntervalSinceNow: settings.periodDuration - self.getGameTime());
            /*
 if self.getGameTime() > settings.periodDuration {
                return Date();
            } else {
                return Date(timeIntervalSinceNow: settings.periodDuration - self.getGameTime());
            }
 */
        } else {
            return nil
        }
    }
    
    var isTimeUp : Bool {
        get {
            return self.gameTime >= settings.periodDuration;
        }
    }
    
    func getGameTime(_ realTime: RealTime = Date()) -> GameTime {
        var gameTime : GameTime = GameTime(0.0);
        if nil != self.periodStartTime {
            var lastStartTime : RealTime = self.periodStartTime!;
            var lastEventIsTimeOn : Bool = false;
            // debugPrint("-----------")
            for clockEvent in self.getClockEvents().filter({ $0.realTime <= realTime }) {
                if clockEvent.startsClock {
                    // debugPrint("start", clockEvent.realTime)
                    lastEventIsTimeOn = true;
                    lastStartTime = clockEvent.realTime;
                } else {
                    lastEventIsTimeOn = false;
                    gameTime -= lastStartTime.timeIntervalSince(clockEvent.realTime);
                    // debugPrint("stop", clockEvent.realTime, -lastStartTime.timeIntervalSince(clockEvent.realTime), gameTime)
                }
            }
            // This will be false if the time interval is after the period has ended
            if lastEventIsTimeOn {
                gameTime += realTime.timeIntervalSince(lastStartTime);
            }
        }
        return gameTime;
    }
    
    func getElapsedTime(_ realTime: RealTime = Date()) -> ElapsedTime? {
        if nil != self.periodStartTime {
            if (self.periodEndTime ?? realTime) < realTime {
                return nil;
            } else {
                return realTime.timeIntervalSince(self.periodStartTime!);
            }
        } else {
            return nil;
        }
    }
    
}
