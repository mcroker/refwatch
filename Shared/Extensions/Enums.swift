//
//  Enums.swift
//  RefWatch
//
//  Created by Martin Croker on 17/02/2021.
//  Copyright © 2021 Martin Croker. All rights reserved.
//

import Foundation

enum EventTypes: String, Decodable {
    case sanction = "penalty";
    case yellowCard = "yellow_card";
    case redCard = "red_card";
    case caution = "penalty_caution";
    case scoreTry = "score_try";
    case scoreConv = "score_conv";
    case scoreDropGoal = "score_dropgoal";
    case scorePenTry = "score_penalty";
    case scorePen = "score_pen";
    case timeOn = "time_on";
    case timeOff =  "time_off";
    case periodStart =  "period_start";
    case periodEnd =  "period_end";
    case matchStart =  "match_start";
    case matchEnd =  "match_end";
}

enum OffenceTypes: String, Decodable {
    case unspecified = "";
}

enum Teams : String, Decodable {
    case home = "home";
    case away = "away";
}
