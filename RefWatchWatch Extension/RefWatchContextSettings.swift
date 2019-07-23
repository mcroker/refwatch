//
//  RefWatchContextSettings.swift
//  RefWatch
//
//  Created by Martin Croker on 13/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import Foundation

class RefWatchContextSettings {
    
    static let sharedInstance = RefWatchContextSettings()
    
    fileprivate var _periodduration : TimeInterval = 40 * 60
    // private var _periodduration : NSTimeInterval = 10
    
    fileprivate var _trypoints : Int = 5
    fileprivate var _convpoints : Int = 2
    fileprivate var _penpoints : Int = 3
    
    fileprivate var _sinbinduration : TimeInterval = 600
    fileprivate var _displaygraceperiod : TimeInterval = 120
    
    fileprivate var _pkrecentmins1: TimeInterval = 600
    fileprivate var _pkrecentmins2: TimeInterval = 40 * 60
    fileprivate var _pklimit: Int = 3
    
    fileprivate init() {}
    
    func reset() {
        _trypoints = 5
        _convpoints = 2
        _penpoints = 3
        _periodduration = 40 * 60
        _sinbinduration = 600
    }
    
    var periodduration : TimeInterval {
        get {
            return _periodduration
        }
        set {
            _periodduration = newValue
        }
    }
    
    var pkrecentmins1 : TimeInterval {
        get {
            return _pkrecentmins1
        }
        set {
            _pkrecentmins1 = newValue
        }
    }
    
    var pkrecentmins2 : TimeInterval {
        get {
            return _pkrecentmins2
        }
        set {
            _pkrecentmins2 = newValue
        }
    }
    
    var pklimit : Int {
        get {
            return _pklimit
        }
        set {
            _pklimit = newValue
        }
    }
    
    var trypoints : Int {
        get {
            return _trypoints
        }
        set {
            _trypoints = newValue
        }
    }
    
    var convpoints : Int {
        get {
            return _convpoints
        }
        set {
            _convpoints = newValue
        }
    }
    
    var penpoints : Int {
        get {
            return _penpoints
        }
        set {
            _penpoints = newValue
        }
    }
    
    var sinbinduration : TimeInterval {
        get {
            return _sinbinduration
        }        set {
            _sinbinduration = newValue
        }
    }
    
    var displaygraceperiod : TimeInterval {
        get {
            return _displaygraceperiod
        }
    }
}
