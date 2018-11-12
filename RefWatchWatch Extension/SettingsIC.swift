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
    
       @IBAction func PeriodUp() {
        if (_context!.settings.periodduration >= 900) {
          _context!.settings.periodduration+=300
        } else {
          _context!.settings.periodduration+=60
        }
        PeriodDownButton.setEnabled(true)
        PeriodDuration.setText(dateFormatter.string(from: _context!.settings.periodduration))
    }

    @IBAction func PeriodDown() {
        if (_context!.settings.periodduration >= 1200) {
            _context!.settings.periodduration-=300
        } else {
            _context!.settings.periodduration-=60
        }
        if (_context!.settings.periodduration <= 60) {
            PeriodDownButton.setEnabled(false)
        }
        PeriodDuration.setText(dateFormatter.string(from: _context!.settings.periodduration))
    }
    
    @IBAction func TryDown() {
        _context!.settings.trypoints-=1
        TryPoints.setText(String(_context!.settings.trypoints))
        if (_context!.settings.trypoints <= 1) {
            TryDownButton.setEnabled(false)
        }
    }
    
    @IBAction func TryUp() {
        _context!.settings.trypoints+=1
        TryPoints.setText(String(_context!.settings.trypoints))
        TryDownButton.setEnabled(true)
    }

    @IBAction func ConvDown() {
        _context!.settings.convpoints-=1
        ConvPoints.setText(String((_context?.settings.convpoints)!))
        if ((_context?.settings.convpoints)! <= 0) {
            ConvDownButton.setEnabled(false)
        }
    }

    @IBAction func ConvUp() {
        _context!.settings.convpoints+=1
        ConvPoints.setText(String(_context!.settings.convpoints))
        ConvDownButton.setEnabled(true)
    }
    
    @IBAction func PenDown() {
        _context!.settings.penpoints-=1
        PenPoints.setText(String(_context!.settings.penpoints))
        if (_context!.settings.penpoints <= 0) {
            PenDownButton.setEnabled(false)
        }
    }

    @IBAction func PenUp() {
        _context!.settings.penpoints+=1
        PenPoints.setText(String(_context!.settings.penpoints))
        PenDownButton.setEnabled(true)
    }
    
    @IBAction func SinBinDown() {
        _context!.settings.sinbinduration-=60
        if (_context!.settings.sinbinduration <= 0) {
            SinBinDownButton.setEnabled(false)
        }
        SinBinDuration.setText(dateFormatter.string(from: _context!.settings.sinbinduration))
    }
    
    @IBAction func SinBinUp() {
        _context?.settings.sinbinduration+=60
        SinBinDownButton.setEnabled(true)
        SinBinDuration.setText(dateFormatter.string(from: _context!.settings.sinbinduration))
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        _context = context as? RefWatchContext
        dateFormatter.allowedUnits = .minute
    }
    
    override func willActivate() {
        super.willActivate()
        // This method is called when watch view controller is about to be visible to user
        
        
        PeriodDuration.setText(dateFormatter.string(from: _context!.settings.periodduration))
        PeriodDownButton.setEnabled(_context!.settings.periodduration > 60)
        
        TryPoints.setText(String(_context!.settings.trypoints))
        TryDownButton.setEnabled(_context!.settings.trypoints > 1)
     
        
        ConvPoints.setText(String(_context!.settings.convpoints))
        ConvDownButton.setEnabled(_context!.settings.convpoints > 1)
        
        
        PenPoints.setText(String(_context!.settings.penpoints))
        PenDownButton.setEnabled(_context!.settings.penpoints > 1)
        
        
        SinBinDuration.setText(dateFormatter.string(from: _context!.settings.sinbinduration))
        SinBinDownButton.setEnabled(_context!.settings.sinbinduration > 0)
        
    }
    
    @IBAction func ClkOK() {
        dismiss()
    }
}
