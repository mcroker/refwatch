//
//  MatchEventFactory.swift
//  RefWatch
//
//  Created by Martin Croker on 16/02/2021.
//  Copyright © 2021 Martin Croker. All rights reserved.
//

import Foundation

class MatchEventFactory  {
    
    static func createEvent(doEvent: DoEvent) -> MatchEvent {
        
        switch (doEvent.typeEnum) {
        case .scoreTry:
            return TryScoredEvent(doEvent: doEvent);
            
        case .caution, .redCard, .sanction, .yellowCard:
            return SanctionEvent(doEvent: doEvent);
            
        default:
            return MatchEvent(doEvent: doEvent);
        }
    }
        
    init() {
    }
        
}
