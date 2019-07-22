//
//  RefWatchContext.swift
//  RefWatch
//
//  Created by Martin Croker on 12/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import Foundation

class RefWatchContext {
    
    static let sharedInstance = RefWatchContext()
    
    fileprivate var _homescore : RefWatchContextScore = RefWatchContextScore()
    fileprivate var _awayscore : RefWatchContextScore = RefWatchContextScore()
    fileprivate  var _settings  : RefWatchContextSettings = RefWatchContextSettings.sharedInstance
    
    fileprivate var _istimeon  : Bool = false
    fileprivate var _ishometeam : Bool = true
    
    fileprivate var _isperiodrunning : Bool = false

    fileprivate var _priorperiodtime : TimeInterval = 0.0                 // The amount of run time in prior periods (i.e. half1)
    fileprivate var _periodstart : Date = Date(timeIntervalSinceNow: 0) // When this period (half) of play started
    fileprivate var _currentPeriod : Int = 0
    
    fileprivate var _clockstart : Date = Date(timeIntervalSinceNow: 0)  // The time when the clock started last (ie when the ref last resumed play)
    fileprivate var _priorclocktime : TimeInterval = 0.0                  // The amount of game time in this period/half prior up to when the clock last stopped
    
    fileprivate var _sanctions : [RefWatchContextSanction] = []
    
    fileprivate var _tmpsanction : RefWatchContextSanction = RefWatchContextSanction()
    
    fileprivate init() {}
    
    var tmpsanction : RefWatchContextSanction {
        get {
            return _tmpsanction
        }
        set {
            _tmpsanction = newValue
        }
    }
    
    var ishometeam : Bool {
        get {
            return _ishometeam
        }
        set {
            _ishometeam = newValue
        }
    }
    
    var homescore : RefWatchContextScore {
        get {
            return _homescore
        }
    }
    
    var awayscore : RefWatchContextScore {
        get {
            return _awayscore
        }
    }
    
    var settings : RefWatchContextSettings {
        get {
            return _settings
        }
    }
    
    var istimeon : Bool {
        get {
            return _istimeon
        }
        set {
            _istimeon = newValue
            
            if _istimeon {
                if !_isperiodrunning {
                    _isperiodrunning = true
                    _periodstart = Date(timeIntervalSinceNow: 0)
                }
                _clockstart = Date(timeIntervalSinceNow: 0)
            }
            else {
                _priorclocktime += Date(timeIntervalSinceNow: 0).timeIntervalSince(_clockstart)
            }
            
            for sanction : RefWatchContextSanction in _sanctions {
                sanction.istimeon = _istimeon
            }
            
        }
    }
    
    var istimeup : Bool {
        get {
            return periodplayedtime >= settings.periodduration
        }
    }
    
    var periodplayedtime : TimeInterval  {
        get {
            if _istimeon {
                return _priorclocktime + Date().timeIntervalSince(_clockstart)
            }
            else{
                return _priorclocktime
            }
        }
    }
    
    var logicalperiodend: Date {
        get {
            return _periodstart.addingTimeInterval(self.settings.periodduration).addingTimeInterval(periodelapsedtime).addingTimeInterval(-periodplayedtime)
        }
    }
    
    var logicalperiodstart: Date {
        get {		
            return _clockstart.addingTimeInterval(-_priorclocktime)
        }
    }
    
    var periodstart: Date {
        get {
            return _periodstart
        }
    }
    
    var isperiodrunning: Bool {
        get {
            return _isperiodrunning
        }
    }
    
    var gameplayedtime : TimeInterval  {
        get {
            return periodplayedtime + _priorperiodtime
        }
    }
    
    var periodelapsedtime : TimeInterval {
        get {
            if _isperiodrunning {
                return Date(timeIntervalSinceNow: 0).timeIntervalSince(_periodstart)
            }
            else {
                return TimeInterval(0)
            }
        }
    }
    
    var periodremainingtime: TimeInterval {
        get {
            return settings.periodduration - periodplayedtime
        }
 
    }
    
    var sanctions : [RefWatchContextSanction] {
        get {
            return _sanctions
        }
    }
    
    func countTotalSanctions(_ ishometeam: Bool) -> Int {
        var count = 0
        for _sanctionitem : RefWatchContextSanction in _sanctions {
            if (_sanctionitem.ishometeam == ishometeam) {
                count += 1
            }
        }
        return count
    }
    
    func countRecentSanctions(_ ishometeam: Bool) -> Int {
        var count = 0
        for _sanctionitem : RefWatchContextSanction in _sanctions {
            if (_sanctionitem.sanctionGameTimeAwarded > (gameplayedtime - settings.pkrecentmins)
                && _sanctionitem.ishometeam == ishometeam) {
                count += 1
            }
        }
        return count
    }
    
    func countPeriodSanctions(_ ishometeam: Bool) -> Int {
        var count = 0
        for _sanctionitem : RefWatchContextSanction in _sanctions {
            if (_sanctionitem.sanctionPeriodAwarded == _currentPeriod
                && _sanctionitem.ishometeam == ishometeam) {
                count += 1
            }
        }
        return count
    }
    
    func resetTime() {
        _priorperiodtime += periodplayedtime
        _priorclocktime=0.0
        _istimeon=false
        _currentPeriod += 1
        _isperiodrunning=false
    }
    
    func resetAll() {
        resetTime()
        _priorperiodtime = 0
        _homescore.reset()
        _awayscore.reset()
        
        _sanctions.removeAll()
        _settings.reset()
    }
    
    func addsanction(_ ishometeam : Bool, player : Int, sanctiontype: RefWatchContextSanction.SanctionEnum ) {
        
        let newsanction : RefWatchContextSanction = RefWatchContextSanction()
        newsanction.ishometeam = ishometeam
        newsanction.player = player
        newsanction.sanctiontype = sanctiontype
        newsanction.sanctionPeriodAwarded = _currentPeriod
        newsanction.sanctionGameTimeAwarded = gameplayedtime
        newsanction.istimeon = _istimeon
        
        _sanctions.append(newsanction)
        
    }
    
}
