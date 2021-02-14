//
//  RefWatchContextSettings.swift
//  RefWatch
//
//  Created by Martin Croker on 13/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import Foundation
import WatchKit

enum RefWatchStates {
    case main;
}

class RefWatchState {

    fileprivate static var _currentState: RefWatchStates = .main;
    static var currentState: RefWatchStates {
        get {
            return self._currentState;
        }
    }
    
    static func goController(name: String, targetState: RefWatchStates, context: RefWatchContext) {
        context.clear();
        self._currentState = .main;
        presentController(withName: "Main" , context: context);
    }
    
    static func go(targetState: RefWatchStates, context: RefWatchContext) {
        switch RefWatchState.currentState {
        case .main:
            switch targetState {
            default:Ï
                goController("Main", targetState, context);
            }
    
        default:
            goController("Main", context, context);
    }

}
