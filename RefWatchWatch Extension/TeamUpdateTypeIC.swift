//
//  InterfaceController.swift
//  RefWatchWatch Extension
//
//  Created by Martin Croker on 12/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import WatchKit
import Foundation


class TeamUpdateTypeIC: WKInterfaceController {
    
    @IBOutlet var WKSinBinButtonOutlet: WKInterfaceButton!
    
    var _context : RefWatchContext?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        _context = context as? RefWatchContext
    }
    
    override func willActivate() {
        super.willActivate()
        if _context?.settings.sinbinduration == 0 {
            WKSinBinButtonOutlet.setHidden(true)
        } else {
            WKSinBinButtonOutlet.setHidden(false)
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
   @IBAction func WKScoreButton() {
        _context?.tmpsanction.sanctiontype = RefWatchContextSanction.SanctionEnum.caution
        presentController(withName: "ScoreCtl", context: _context)
    }
    
    @IBAction func WKPenalityButton() {
        _context!.addsanction(_context!.ishometeam, player: 0, sanctiontype: RefWatchContextSanction.SanctionEnum.penalty )
        presentController(withName: "Main" , context: _context)
    }
    
    @IBAction func WKSinBinButton() {
        _context?.tmpsanction.sanctiontype = RefWatchContextSanction.SanctionEnum.sinBin
        presentController(withName: "SanctionPlayer", context: _context)
    }
    
    @IBAction func WKSendOffButton() {
        _context?.tmpsanction.sanctiontype = RefWatchContextSanction.SanctionEnum.sendOff
        presentController(withName: "SanctionPlayer", context: _context)
    }
    
}
