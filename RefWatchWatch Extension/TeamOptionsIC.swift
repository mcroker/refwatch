//
//  InterfaceController.swift
//  RefWatchWatch Extension
//
//  Created by Martin Croker on 12/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import WatchKit
import Foundation

class TeamOptionsIC: WKInterfaceController {
    
    let settings : MatchSettings = Match.getCurrentMatch().settings;
    var _context : RefWatchContext?;
    
    var dateFormatter : DateComponentsFormatter = DateComponentsFormatter();

    @IBOutlet weak var colorPicker: WKInterfacePicker!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        _context = context as? RefWatchContext
        
            let pickerItems: [WKPickerItem] = settings.colorsList.map {
                let pickerItem = WKPickerItem();
                pickerItem.caption = $0.caption;
                pickerItem.title = $0.title;
                return pickerItem;
            }
            colorPicker.setItems(pickerItems);
    }
}
