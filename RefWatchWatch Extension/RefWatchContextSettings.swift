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
    
    // private var _sinbinduration : NSTimeInterval = 3
    // private var _displaygraceperiod : NSTimeInterval = 2
    
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
