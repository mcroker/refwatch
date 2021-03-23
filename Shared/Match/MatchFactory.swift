
//
//  RefWatchContext.swift
//  RefWatch
//
//  Created by Martin Croker on 12/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import Foundation;

class MatchFactory {
    
    static fileprivate var _instance = Match();
    
    static func getCurrentMatch() -> Match {
        return _instance;
    }
    
    @discardableResult
    static func startNewMatch()  -> Match {
        self._instance.endMatch();
        self._instance = Match();
        return MatchFactory.getCurrentMatch();
    }
    
    init() {
    }

    func endMatch() {
        // TODo
    }
    
}
