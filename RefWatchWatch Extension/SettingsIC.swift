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
    
    var _context : RefWatchContext?
    var dateFormatter : DateComponentsFormatter = DateComponentsFormatter()

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
        if (_context!.settings.periodduration >= 900) {
          _context!.settings.periodduration+=300
        } else {
          _context!.settings.periodduration+=60
        }
        draw()
    }

    @IBAction func PeriodDown() {
        if (_context!.settings.periodduration >= 1200) {
            _context!.settings.periodduration-=300
        } else {
            _context!.settings.periodduration-=60
        }
        if _context!.settings.pkrecentmins1 > _context!.settings.periodduration {
            _context!.settings.pkrecentmins1 = _context!.settings.periodduration
        }
        if _context!.settings.pkrecentmins2 > _context!.settings.periodduration {
            _context!.settings.pkrecentmins2 = _context!.settings.periodduration
        }
        draw()
    }
    
    @IBAction func TryDown() {
        _context!.settings.trypoints-=1
        draw()
    }
    
    @IBAction func TryUp() {
        _context!.settings.trypoints+=1
        draw()
    }

    @IBAction func ConvDown() {
        _context!.settings.convpoints-=1
        draw()
    }

    @IBAction func ConvUp() {
        _context!.settings.convpoints+=1
        draw()
    }
    
    @IBAction func PenDown() {
        _context!.settings.penpoints-=1
        draw()
    }

    @IBAction func PenUp() {
        _context!.settings.penpoints+=1
        draw()
    }
    
    @IBAction func SinBinDown() {
        _context!.settings.sinbinduration-=60
        draw()
    }
    
    @IBAction func SinBinUp() {
        _context?.settings.sinbinduration+=60
        draw()
    }
    
    
    @IBAction func PKMins1Down() {
        if (_context!.settings.pkrecentmins1 >= 1200) {
            _context!.settings.pkrecentmins1-=300
        } else {
            _context!.settings.pkrecentmins1-=60
        }
        draw()
    }
    
    @IBAction func PKMins1Up() {
        if (_context!.settings.pkrecentmins1 >= 900) {
            _context!.settings.pkrecentmins1+=300
        } else {
            _context!.settings.pkrecentmins1+=60
        }
        if _context!.settings.pkrecentmins1 > _context!.settings.periodduration {
             _context!.settings.pkrecentmins1 = _context!.settings.periodduration
        }
        draw()
    }
    
    @IBAction func PKMins2Down() {
        if (_context!.settings.pkrecentmins2 >= 1200) {
            _context!.settings.pkrecentmins2-=300
        } else {
            _context!.settings.pkrecentmins2-=60
        }
        draw()
    }
    
    @IBAction func PKMins2Up() {
        if (_context!.settings.pkrecentmins2 >= 900) {
            _context!.settings.pkrecentmins2+=300
        } else {
            _context!.settings.pkrecentmins2+=60
        }
        if _context!.settings.pkrecentmins2 > _context!.settings.periodduration {
            _context!.settings.pkrecentmins2 = _context!.settings.periodduration
        }
        draw()
    }
    
    @IBAction func PKLimitDown() {
        _context!.settings.pklimit-=1
        draw()
    }
    
    @IBAction func PKLimitUp() {
        _context?.settings.pklimit+=1
        draw()
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        _context = context as? RefWatchContext
        dateFormatter.allowedUnits = .minute
    }
    
    func draw() {
        PeriodDuration.setText(dateFormatter.string(from: _context!.settings.periodduration))
        PeriodDownButton.setEnabled(_context!.settings.periodduration > 60)
        
        TryPoints.setText(String(_context!.settings.trypoints))
        TryDownButton.setEnabled(_context!.settings.trypoints > 1)
        
        if _context!.settings.convpoints > 0 {
            ConvPoints.setText(String(_context!.settings.convpoints))
        } else {
            ConvPoints.setText("Off")
        }
        ConvDownButton.setEnabled(_context!.settings.convpoints > 0)
        
        if _context!.settings.penpoints > 0 {
            PenPoints.setText(String(_context!.settings.penpoints))
        } else {
            PenPoints.setText("Off")
        }
        PenDownButton.setEnabled(_context!.settings.penpoints > 0)
        
        if _context!.settings.sinbinduration > 0 {
            SinBinDuration.setText(dateFormatter.string(from: _context!.settings.sinbinduration))
        } else {
            SinBinDuration.setText("Off")
        }
        SinBinDownButton.setEnabled(_context!.settings.sinbinduration > 0)
        
        if _context!.settings.pklimit > 0 {
            PKLimit.setText(String(_context!.settings.pklimit))
        } else {
            PKLimit.setText("Off")
        }
        PKLimitDownButton.setEnabled(_context!.settings.pklimit > 0)
        
        PKRecentMins1.setText(dateFormatter.string(from: _context!.settings.pkrecentmins1))
        PKRecentMins1DownButton.setEnabled(_context!.settings.pkrecentmins1 > 60)
        PKRecentMins1UpButton.setEnabled(_context!.settings.pkrecentmins1 < _context!.settings.periodduration)
        
        if (_context!.settings.pkrecentmins2 == _context!.settings.periodduration) {
            PKRecentMins2.setText("Period")
        } else {
            PKRecentMins2.setText(dateFormatter.string(from: _context!.settings.pkrecentmins2))
        }
        PKRecentMins2DownButton.setEnabled(_context!.settings.pkrecentmins1 > 60)
        PKRecentMins2UpButton.setEnabled(_context!.settings.pkrecentmins1 < _context!.settings.periodduration)
    }
    
    override func willActivate() {
        super.willActivate()
        draw()
    }
    
    @IBAction func ClkOK() {
        dismiss()
    }
}
