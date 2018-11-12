//
//  InterfaceController.swift
//  RefWatchWatch Extension
//
//  Created by Martin Croker on 12/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import WatchKit
import Foundation


class SettingsHomeIC: WKInterfaceController {
    
    @IBOutlet var WKPicker: WKInterfacePicker!
    
    var colourList: [(String, String)] = [
        ("Red", "Red"),
        ("Blue", "Blue"),
        ("Green", "Green"),
        ("White", "White"),
        ("Black", "Black"),
        ("Pink", "Pink") ]
    
    override func willActivate() {
        super.willActivate()
        
        let pickerItems: [WKPickerItem] = colourList.map {
            let pickerItem = WKPickerItem()
            pickerItem.title = $0.0
            pickerItem.caption = $0.1
            return pickerItem
        }
        
        WKPicker.setItems(pickerItems)
    }
 
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func WKOkButton() {
        let context=""
        presentController(withName: "Main" , context: context)
    }

}
