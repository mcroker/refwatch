//
//  RefWatchContextSettings.swift
//  RefWatch
//
//  Created by Martin Croker on 13/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import Foundation

class RefWatchContextSanction {
    
    enum SanctionEnum {
        case caution
        case sinBin
        case sendOff
    }
    
    fileprivate var _settings : RefWatchContextSettings = RefWatchContextSettings.sharedInstance
    
    fileprivate var _ishometeam : Bool = false
    fileprivate var _player : Int = 0
    fileprivate var _sanctiontype : SanctionEnum = SanctionEnum.caution
    fileprivate var _sanctiontime : Date = Date(timeIntervalSinceNow: 0)
    
    fileprivate var _istimeon  : Bool = false
    fileprivate var _clockstart : Date = Date(timeIntervalSinceNow: 0)  // The time when the clock started last (ie when the ref last resumed play)
    fileprivate var _priorclocktime : TimeInterval = 0.0                  // The amount of game time in this period/half prior up to when the clock last stopped
    
    var istimeon : Bool {
        get {
            return _istimeon
        }
        set {
            _istimeon = newValue
            if _istimeon {
                _clockstart = Date(timeIntervalSinceNow: 0)
            }
            else {
                _priorclocktime += Date(timeIntervalSinceNow: 0).timeIntervalSince(_clockstart)
            }
        }
    }
    
    var timesinceaward : TimeInterval {
        get {
            if _istimeon {
                return _priorclocktime + Date(timeIntervalSinceNow: 0).timeIntervalSince(_clockstart)
            }
            else{
                return _priorclocktime
            }
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
    
    var player : Int {
        get {
            return _player
        }
        set {
            _player = newValue
        }
    }
    
    var sanctiontype : SanctionEnum {
        get {
            return _sanctiontype
        }
        set {
            _sanctiontype = newValue
        }
    }
    
    var sanctiontime : Date {
        get {
            return _sanctiontime
        }
        set {
            _sanctiontime = newValue
        }
    }
    
    var timeremaining : TimeInterval {
        get {
            if _sanctiontype == SanctionEnum.sinBin {
                var tmptime : TimeInterval = _settings.sinbinduration - timesinceaward
                if tmptime < 0 {
                    tmptime = 0
                }
                return tmptime
            }
            else {
                return TimeInterval(0)
            }
        }
    }
    
    var isactive : Bool {
        get {
            if _sanctiontype == SanctionEnum.sinBin {
                return timesinceaward <= _settings.sinbinduration
            } else {
                return true
            }
        }
    }
    
    var isingraceperiod : Bool {
        get {
            if _sanctiontype == SanctionEnum.sinBin {
                return timesinceaward <= _settings.sinbinduration + _settings.displaygraceperiod
            } else {
                return true
            }
        }
    }

}
