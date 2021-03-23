//
//  InterfaceController.swift
//  RefWatchWatch Extension
//
//  Created by Martin Croker on 12/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import WatchKit
import Foundation

class EventList: WKInterfaceController {
    
    @IBOutlet weak var eventTable: WKInterfaceTable!
    
    var match : Match = MatchFactory.getCurrentMatch();
    
    override func willActivate() {
        let displayEvents : [MatchEvent] = match.getEvents()
            .sorted { $0.realTime > $1.realTime }
            .filter { $0 is ClockPeriodEvent || $0 is ScoreEvent || $0 is SanctionEvent || $0 is ReplacePlayerEvent }
        
        for (index, event) in displayEvents.enumerated() {
            eventTable.insertRows(at: IndexSet(integer: index), withRowType: "MatchEvent");
            let row = eventTable.rowController(at: index) as! EventRowCtl;
                row.event = event;
        }
    }
    
}
