//
//  Notification.Name.swift
//  RefWatchWatch Extension
//
//  Created by Martin Croker on 17/01/2020.
//  Copyright © 2020 Martin Croker. All rights reserved.
//

import Foundation
#if os(iOS)
    import UIKit
    typealias Color = UIColor;
#elseif os(watchOS)
    import WatchKit
    typealias Color = UIColor;
#endif

extension UIColor {
    class var clockActive:UIColor {
        return UIColor.white;
    }
    class var clockPaused:UIColor {
        return UIColor.darkGray;
    }
    class var clockExpired:UIColor {
        return UIColor.red;
    }
    class var penCountOK:UIColor {
        return UIColor.white;
    }
    class var penCountWarn:UIColor {
        return UIColor.yellow;
    }
    class var penCountAlarm:UIColor {
        return UIColor.red;
    }
    class var sanctionRC:UIColor {
        return UIColor.red;
    }
    class var sanctionYC:UIColor {
        return UIColor.yellow;
    }
    class var sanctionCaution:UIColor {
        return UIColor.white;
    }
    class var sanctionOther:UIColor {
        return UIColor.white;
    }
    class var unspecifiedTeamEvent:UIColor {
        return UIColor.magenta;
    }
    class var score:UIColor {
        return UIColor.green;
    }
}
