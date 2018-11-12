//
//  RefWatchContext.swift
//  RefWatch
//
//  Created by Martin Croker on 12/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import Foundation

class RefWatchContextScore {
    
    fileprivate var _trys : Int = 0
    fileprivate var _conv : Int = 0
    fileprivate var _pen : Int = 0
    
    fileprivate var _settings : RefWatchContextSettings = RefWatchContextSettings.sharedInstance
    
    var score : Int {
        get {
            return ( trys * _settings.trypoints ) + (pen * _settings.penpoints ) + ( conv * _settings.convpoints)
        }
    }
    
    var  trys : Int {
        get {
            return _trys
        }
        set {
            _trys=newValue
        }
    }
    
    var  conv : Int {
        get {
            return _conv
        }
        set {
            _conv=newValue
        }
    }
    
    var  pen : Int {
        get {
            return _pen
        }
        set {
            _pen=newValue
        }
    }
    
    func addPen() {
        _pen+=1
    }
    
    func removePen() {
        _pen-=1
    }
 
    func reset() {
        _trys = 0
        _pen = 0
        _conv = 0
    }
}
