//
//  InterfaceController.swift
//  RefWatchWatch Extension
//
//  Created by Martin Croker on 12/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import WatchKit
import Foundation


class SanctionPlayerIC: WKInterfaceController {
    
    var _context : RefWatchContext?
    
    var _currentno : Int = -1
    
    var _ishometeam : Bool = true

    @IBOutlet var WKTeamButton: WKInterfaceButton!
    
    @IBOutlet var WKOKButton: WKInterfaceButton!

    @IBOutlet var WKValue: WKInterfaceLabel!

    @IBOutlet var WKBackButton: WKInterfaceButton!
    
    @IBOutlet var WKBut1: WKInterfaceButton!
    
    @IBOutlet var WKBut2: WKInterfaceButton!
    
    @IBOutlet var WKBut3: WKInterfaceButton!
    
    @IBOutlet var WKBut4: WKInterfaceButton!
    
    @IBOutlet var WKBut5: WKInterfaceButton!
    
    @IBOutlet var WKBut6: WKInterfaceButton!
    
    @IBOutlet var WKBut7: WKInterfaceButton!
    
    @IBOutlet var WKBut8: WKInterfaceButton!
    
    @IBOutlet var WKBut9: WKInterfaceButton!
    
    @IBOutlet var WKBut0: WKInterfaceButton!
    
    override func willActivate() {
        super.willActivate()
        _ishometeam = true
        WKTeamButton.setTitle("Home")
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        _context = context as? RefWatchContext

        _currentno = -1
        
        // For these santion types a player is required.
        if (_context?.tmpsanction.sanctiontype == RefWatchContextSanction.SanctionEnum.sendOff
            || _context?.tmpsanction.sanctiontype == RefWatchContextSanction.SanctionEnum.sinBin
            || _context?.tmpsanction.sanctiontype == RefWatchContextSanction.SanctionEnum.caution
            ) {
            WKOKButton.setHidden(true)
        }
        WKBackButton.setHidden(true)
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func WKOKButtonClick() {
        _context?.tmpsanction.player = _currentno
        _context!.addsanction(_ishometeam, player: _currentno, sanctiontype: _context!.tmpsanction.sanctiontype )
        presentController(withName: "Main" , context: _context)
    }
    
    @IBAction func WKTeamButtonClick() {
        if _ishometeam {
            _ishometeam = false
            WKTeamButton.setTitle("Away")
        }
        else {
            _ishometeam = true
            WKTeamButton.setTitle("Home")
        }
    }
    
    func buttonClick(_ number: Int) {
        var nextstring : String
        if _currentno == -1 {
            _currentno = number
            nextstring = "\(number)"
        }
        else {
            nextstring = "\(_currentno)\(number)"
            _currentno = Int(nextstring)!
        }
        WKValue.setText(nextstring)
        WKOKButton.setHidden(false)
        WKBackButton.setHidden(false)
        
        if nextstring.count > 1 {
            WKBut0.setEnabled(false)
            WKBut1.setEnabled(false)
            WKBut2.setEnabled(false)
            WKBut3.setEnabled(false)
            WKBut4.setEnabled(false)
            WKBut5.setEnabled(false)
            WKBut6.setEnabled(false)
            WKBut7.setEnabled(false)
            WKBut8.setEnabled(false)
            WKBut9.setEnabled(false)
        }
    }
    
    @IBAction func WKBackspaceClick() {
        if _currentno != -1 {
            let curstring : String = "\(_currentno)"
            let truncated = curstring.substring(to: curstring.index(before: curstring.endIndex))
            WKValue.setText(truncated)
            
            if truncated.count > 0 {
                _currentno = Int(truncated)!
            }
            else {
                _currentno = -1
                // For these santion types a player is required.
                if (_context?.tmpsanction.sanctiontype == RefWatchContextSanction.SanctionEnum.sendOff
                    || _context?.tmpsanction.sanctiontype == RefWatchContextSanction.SanctionEnum.sinBin
                    || _context?.tmpsanction.sanctiontype == RefWatchContextSanction.SanctionEnum.caution
                    ) {
                    WKOKButton.setHidden(true)
                }
                WKBackButton.setHidden(true)
            }
            WKBut0.setEnabled(true)
            WKBut1.setEnabled(true)
            WKBut2.setEnabled(true)
            WKBut3.setEnabled(true)
            WKBut4.setEnabled(true)
            WKBut5.setEnabled(true)
            WKBut6.setEnabled(true)
            WKBut7.setEnabled(true)
            WKBut8.setEnabled(true)
            WKBut9.setEnabled(true)
        }
    }
    
    @IBAction func WKNo1Button() {
        buttonClick(1)
    }
    
    @IBAction func WKNo2Button() {
        buttonClick(2)
    }

    @IBAction func WKNo3Button() {
        buttonClick(3)
    }
    
    @IBAction func WKNo4Button() {
        buttonClick(4)
    }
    
    @IBAction func WKNo5Button() {
        buttonClick(5)
    }
    
    @IBAction func WKNo6Button() {
        buttonClick(6)
    }
    
    @IBAction func WKNo7Button() {
        buttonClick(7)
    }
    
    @IBAction func WKNo8Button() {
        buttonClick(8)
    }
    
    @IBAction func WKNo9Button() {
        buttonClick(9)
    }
    
    @IBAction func WKNo0Button() {
        buttonClick(0)
    }
    
}
