//
//  InterfaceController.swift
//  RefWatchWatch Extension
//
//  Created by Martin Croker on 12/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import WatchKit
import Foundation


class SanctionTypeIC: WKInterfaceController {
    
    var _context : RefWatchContext?

    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        _context = context as? RefWatchContext
        
        // If player is already set close dialogue
    }
    
    override func willActivate() {
        super.willActivate()
        // This method is called when watch view controller is about to be visible to user
        
       // if _context!.tmpsanction.player >= 0 {
       //     _context!.addsanction(_context!.tmpsanction.ishometeam, player: _context!.tmpsanction.player, sanctiontype: _context!.tmpsanction.sanctiontype )
       //     dismissController()
       // }

    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
   @IBAction func WKCautionButton() {
            _context?.tmpsanction.sanctiontype = RefWatchContextSanction.SanctionEnum.caution
            presentController(withName: "SanctionPlayer", context: _context)
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
