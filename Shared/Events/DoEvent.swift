//
//  DOMatchEvent.swift
//  RefWatch
//
//  Created by Martin Croker on 16/02/2021.
//  Copyright © 2021 Martin Croker. All rights reserved.
//

import Foundation

extension DoEvent {
    
    convenience init(realTime: RealTime, gameTime: GameTime, periodTime: PeriodTime) {
        self.init();
        self.realTime = realTime;
        self.gameTime = gameTime;
        self.periodTimePeriod = periodTime.period;
        self.periodTimeTime = periodTime.time;
    }
    
    var periodTime : PeriodTime {
        get {
            return (period: self.periodTimePeriod, time:self.periodTimeTime);
        }
    }
    
    @objc class dynamic var title : String {
        get {
            return "Match Event";
        }
    }
    
}
