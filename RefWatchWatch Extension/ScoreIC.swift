//
//  InterfaceController.swift
//  RefWatchWatch Extension
//
//  Created by Martin Croker on 12/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import WatchKit
import Foundation


class ScoreIC: WKInterfaceController {
    
    
    @IBOutlet var WKConvGrp: WKInterfaceGroup!
    @IBOutlet var WKPenGrp: WKInterfaceGroup!
    
    @IBOutlet var WKTry: WKInterfaceLabel!
    @IBOutlet var WKConv: WKInterfaceLabel!
    @IBOutlet var WKPen: WKInterfaceLabel!
    
    @IBOutlet var WKTryDownButton: WKInterfaceButton!
    @IBOutlet var WKConvDownButton: WKInterfaceButton!
    @IBOutlet var WKPenDownButton: WKInterfaceButton!
    @IBOutlet var WKConvUpButton: WKInterfaceButton!
    
    var _context : RefWatchContext?
    
    override func awake(withContext context: Any?) {
       
        super.awake(withContext: context)
        
        _context = context as? RefWatchContext

        if _context!.ishometeam {
            WKTry.setText(String(_context!.homescore.trys))
            WKPen.setText(String(_context!.homescore.pen))
            WKConv.setText(String(_context!.homescore.conv))
            self.setTitle("Home Score")
        }
        else {
            WKTry.setText(String(_context!.awayscore.trys))
            WKPen.setText(String(_context!.awayscore.pen))
            WKConv.setText(String(_context!.awayscore.conv))
            self.setTitle("Away Score")
        }
        
         // Configure interface objects here.
    }
    
    override func willActivate() {
        super.willActivate()
        // This method is called when watch view controller is about to be visible to user
        setEnabled()
    }
    
    func setEnabled() {
        if _context!.settings.convpoints == 0 {
            WKConvGrp.setHidden(true)
        } else {
            WKConvGrp.setHidden(false)
        }
        if _context!.settings.penpoints == 0 {
            WKPenGrp.setHidden(true)
        } else {
            WKPenGrp.setHidden(false)
        }
        if _context!.ishometeam {
            if _context!.homescore.trys > 0 { // Trys recorded
                if _context!.homescore.conv < _context!.homescore.trys {
                    WKTryDownButton.setEnabled(true)
                    WKConvUpButton.setEnabled(true)
                }
                else if _context!.homescore.conv == _context!.homescore.trys {
                    WKTryDownButton.setEnabled(true)
                    WKConvUpButton.setEnabled(false)
                }
            }
            else { // No trys recorded
                WKTryDownButton.setEnabled(false)
                WKConvUpButton.setEnabled(false)
            }
            
            if _context!.homescore.conv > 0 {
                WKConvDownButton.setEnabled(true)
            }
            else {
                WKConvDownButton.setEnabled(false)
            }
            
            if _context!.homescore.pen > 0 {
                WKPenDownButton.setEnabled(true)
            }
            else {
                WKPenDownButton.setEnabled(false)
            }
        }
        else {
            if _context!.awayscore.trys > 0 { // Trys recorded
                if _context!.awayscore.conv < _context!.awayscore.trys {
                    WKTryDownButton.setEnabled(true)
                    WKConvUpButton.setEnabled(true)
                }
                else if _context!.awayscore.conv >= _context!.awayscore.trys {
                    WKTryDownButton.setEnabled(true)
                    WKConvUpButton.setEnabled(false)
                }
            }
            else { // No trys recorded
                WKTryDownButton.setEnabled(false)
                WKConvUpButton.setEnabled(false)
            }
            
            if _context!.awayscore.conv > 0 {
                WKConvDownButton.setEnabled(true)
            }
            else {
                WKConvDownButton.setEnabled(false)
            }
            
            if _context!.awayscore.pen > 0 {
                WKPenDownButton.setEnabled(true)
            }
            else {
                WKPenDownButton.setEnabled(false)
            }
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func WKTryAdd() {
        if _context!.ishometeam {
            _context!.homescore.trys+=1
            WKTry.setText(String(_context!.homescore.trys))
        }
        else {
            _context!.awayscore.trys+=1
            WKTry.setText(String(_context!.awayscore.trys))
        }
        setEnabled()
    }
    
    @IBAction func WKTryDown() {
        if _context!.ishometeam {
            _context?.homescore.trys-=1
            WKTry.setText(String(_context!.homescore.trys))
            // Check if we now have more conversions than tries, if so decrease conv by 1
            if (_context!.homescore.conv > _context!.homescore.trys) {
                _context?.homescore.conv-=1
                WKConv.setText(String(_context!.homescore.conv))
            }
        }
        else {
            _context?.awayscore.trys-=1
            WKTry.setText(String(_context!.awayscore.trys))
            // Check if we now have more conversions than tries, if so decrease conv by 1
            if (_context!.awayscore.conv > _context!.awayscore.trys) {
                _context?.awayscore.conv-=1
                WKConv.setText(String(_context!.awayscore.conv))
            }
        }
        setEnabled()
    }
    
    @IBAction func WKConvUp() {
        if _context!.ishometeam {
            _context!.homescore.conv+=1
            WKConv.setText(String(_context!.homescore.conv))
        }
        else {
            _context!.awayscore.conv+=1
            WKConv.setText(String(_context!.awayscore.conv))
        }
        setEnabled()
    }
    
    @IBAction func WKConvDown() {
        if _context!.ishometeam {
            _context!.homescore.conv-=1
            WKConv.setText(String(_context!.homescore.conv))
        }
        else {
            _context!.awayscore.conv-=1
            WKConv.setText(String(_context!.awayscore.conv))

        }
        setEnabled()
    }
    
    @IBAction func WKPenUp() {
        if _context!.ishometeam {
            _context!.homescore.pen+=1
            WKPen.setText(String(_context!.homescore.pen))
        }
        else {
            _context!.awayscore.pen+=1
            WKPen.setText(String(_context!.awayscore.pen))
        }
        setEnabled()
    }
    
    @IBAction func WKPenDown() {
        if _context!.ishometeam {
            _context!.homescore.pen-=1
            WKPen.setText(String(_context!.homescore.pen))
        }
        else {
            _context!.awayscore.pen-=1
            WKPen.setText(String(_context!.awayscore.pen))
        }
        setEnabled()
    }
    
    @IBAction func WKOKButton() {
        dismiss()
    }
    
}
