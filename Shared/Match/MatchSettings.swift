//
//  RefWatchContextSettings.swift
//  RefWatch
//
//  Created by Martin Croker on 13/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import Foundation

class MatchSettings {
    
    fileprivate var _defaults: UserDefaults = UserDefaults.standard;
    
    public var tryPoints : Int = 5;
    public var convPoints : Int = 2;
    public var penGoalPoints : Int = 3;
    public var penTryPoints : Int = 7;
    public var dropKickPoints : Int = 3;
    
    public var periodsInMatch : Int = 2;
    public var periodDuration : GameTime =  40 * 60;
    
    public var penGoalDuration : GameTime = 60;
    public var convDuration : GameTime = 90;
    
    public var sinBinDuration : GameTime = 600;
    public var cautionDuration : GameTime = 600;
    public var displayGracePeriod : ElapsedTime = 120;
    
    public var pkRecent1Mins: GameTime = 600;
    public var pkRecent1AmberThreshold: Int = 3;
    public var pkRecent1RedThreshold: Int = 5;
    
    public var pkRecent2Mins: GameTime = 40 * 60;
    public var pkRecent2AmberThreshold: Int = 7;
    public var pkRecent2RedThreshold: Int = 10;
    
    public var homeColor: Color = .gray;
    public var awayColor: Color = .gray;
    
    init() {}
    
    func reset() {
        tryPoints = 5;
        convPoints = 2;
        penGoalPoints = 3;
        penTryPoints = 7;
        dropKickPoints = 3;
        periodDuration = 40 * 60;
        sinBinDuration = 600;
    }
    
}
