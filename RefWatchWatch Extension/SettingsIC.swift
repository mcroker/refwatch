//
//  InterfaceController.swift
//  RefWatchWatch Extension
//
//  Created by Martin Croker on 12/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import WatchKit
import Foundation

class SettingsIC: WKInterfaceController {
    
    let settings : MatchSettings = Match.getCurrentMatch().settings;
    
    var dateFormatter : DateComponentsFormatter = DateComponentsFormatter();

    @IBOutlet var PeriodDuration: WKInterfaceLabel!
    @IBOutlet var TryPoints: WKInterfaceLabel!
    @IBOutlet var ConvPoints: WKInterfaceLabel!
    @IBOutlet var PenPoints: WKInterfaceLabel!
    @IBOutlet var SinBinDuration: WKInterfaceLabel!
    @IBOutlet var PeriodDownButton: WKInterfaceButton!
    @IBOutlet var TryDownButton: WKInterfaceButton!
    @IBOutlet var SinBinDownButton: WKInterfaceButton!
    @IBOutlet var ConvDownButton: WKInterfaceButton!
    @IBOutlet var PenDownButton: WKInterfaceButton!
    @IBOutlet var PKRecentMins1: WKInterfaceLabel!
    @IBOutlet var PKLimit: WKInterfaceLabel!
    @IBOutlet var PKRecentMins1DownButton: WKInterfaceButton!
    @IBOutlet var PKLimitDownButton: WKInterfaceButton!
    @IBOutlet var PKRecentMins1UpButton: WKInterfaceButton!
    @IBOutlet var PKRecentMins2: WKInterfaceLabel!
    @IBOutlet var PKRecentMins2DownButton: WKInterfaceButton!
    @IBOutlet var PKRecentMins2UpButton: WKInterfaceButton!
    
    @IBAction func PeriodUp() {
        if (settings.periodDuration >= 900) {
            settings.periodDuration+=300;
        } else {
            settings.periodDuration+=60;
        }
        draw();
    }

    @IBAction func PeriodDown() {
        if (settings.periodDuration >= 1200) {
            settings.periodDuration-=300;
        } else {
            settings.periodDuration-=60;
        }
        if settings.pkRecent1Mins > settings.periodDuration {
            settings.pkRecent1Mins = settings.pkRecent1Mins;
        }
        if settings.pkRecent2Mins > settings.periodDuration {
            settings.pkRecent2Mins = settings.periodDuration;
        }
        draw();
    }
    
    @IBAction func TryDown() {
        settings.tryPoints-=1
        draw();
    }
    
    @IBAction func TryUp() {
        settings.tryPoints+=1
        draw();
    }

    @IBAction func ConvDown() {
        settings.convPoints-=1;
        draw();
    }

    @IBAction func ConvUp() {
        settings.convPoints+=1;
        draw();
    }
    
    @IBAction func PenDown() {
        settings.penGoalPoints-=1;
        draw();
    }

    @IBAction func PenUp() {
        settings.penGoalPoints+=1;
        draw();
    }
    
    @IBAction func SinBinDown() {
        settings.sinBinDuration-=60;
        draw();
    }
    
    @IBAction func SinBinUp() {
        settings.sinBinDuration+=60;
        draw();
    }
    
    @IBAction func PKMins1Down() {
        if (settings.pkRecent1Mins >= 1200) {
            settings.pkRecent1Mins-=300;
        } else {
            settings.pkRecent1Mins-=60;
        }
        draw();
    }
    
    @IBAction func PKMins1Up() {
        if (settings.pkRecent1Mins >= 900) {
            settings.pkRecent1Mins+=300;
        } else {
            settings.pkRecent1Mins+=60;
        }
        if settings.pkRecent1Mins > settings.periodDuration {
            settings.pkRecent1Mins = settings.periodDuration;
        }
        draw();
    }
    
    @IBAction func PKMins2Down() {
        if (settings.pkRecent2Mins >= 1200) {
            settings.pkRecent2Mins-=300;
        } else {
            settings.pkRecent2Mins-=60;
        }
        draw();
    }
    
    @IBAction func PKMins2Up() {
        if (settings.pkRecent2Mins >= 900) {
            settings.pkRecent2Mins+=300
        } else {
            settings.pkRecent2Mins+=60
        }
        if settings.pkRecent2Mins > settings.periodDuration {
            settings.pkRecent2Mins = settings.periodDuration
        }
        draw()
    }
    
    @IBAction func PKLimitDown() {
        settings.pkRecent1AmberThreshold-=1;
        settings.pkRecent2AmberThreshold-=1;
        draw();
    }
    
    @IBAction func PKLimitUp() {
        settings.pkRecent1AmberThreshold+=1;
        settings.pkRecent2AmberThreshold+=1;
        draw();
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        dateFormatter.allowedUnits = .minute
    }
    
    func draw() {
        PeriodDuration.setText(dateFormatter.string(from: settings.periodDuration))
        PeriodDownButton.setEnabled(settings.periodDuration > 60)
        
        TryPoints.setText(String(settings.tryPoints))
        TryDownButton.setEnabled(settings.tryPoints > 1)
        
        if settings.convPoints > 0 {
            ConvPoints.setText(String(settings.convPoints))
        } else {
            ConvPoints.setText("Off")
        }
        ConvDownButton.setEnabled(settings.convPoints > 0)
        
        if settings.penGoalPoints > 0 {
            PenPoints.setText(String(settings.penGoalPoints))
        } else {
            PenPoints.setText("Off")
        }
        PenDownButton.setEnabled(settings.penGoalPoints > 0)
        
        if settings.sinBinDuration > 0 {
            SinBinDuration.setText(dateFormatter.string(from: settings.sinBinDuration))
        } else {
            SinBinDuration.setText("Off")
        }
        SinBinDownButton.setEnabled(settings.sinBinDuration > 0)
        
        if settings.pkRecent1AmberThreshold > 0 {
            PKLimit.setText(String(settings.pkRecent1AmberThreshold))
        } else {
            PKLimit.setText("Off")
        }
        PKLimitDownButton.setEnabled(settings.pkRecent1AmberThreshold > 0)
        
        PKRecentMins1.setText(dateFormatter.string(from: settings.pkRecent1Mins))
        PKRecentMins1DownButton.setEnabled(settings.pkRecent1Mins > 60)
        PKRecentMins1UpButton.setEnabled(settings.pkRecent1Mins < settings.periodDuration)
        
        if (settings.pkRecent2Mins == settings.periodDuration) {
            PKRecentMins2.setText("Period")
        } else {
            PKRecentMins2.setText(dateFormatter.string(from: settings.pkRecent2Mins))
        }
        PKRecentMins2DownButton.setEnabled(settings.pkRecent2Mins > 60)
        PKRecentMins2UpButton.setEnabled(settings.pkRecent2Mins < settings.periodDuration)
    }
    
    override func willActivate() {
        super.willActivate()
        draw()
    }
    
    @IBAction func ClkOK() {
        dismiss()
    }
}
