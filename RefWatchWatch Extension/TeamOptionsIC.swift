//
//  InterfaceController.swift
//  RefWatchWatch Extension
//
//  Created by Martin Croker on 12/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import WatchKit
import Foundation

struct TeamOptionsPageContext {
    var team: MatchTeam
}

class TeamOptionsIC: RefWatchSuperIC {
    
    private let settings : MatchSettings = Match.getCurrentMatch().settings;
    private var pickerValue: UIColor?;
    var context : TeamOptionsPageContext?;

    override init() {
        super.init();
    }

    @IBOutlet weak var colorPicker: WKInterfacePicker!
    
    @IBAction func pickerDidChange(_ value: Int) {
        pickerValue = settings.colorsList[value].colour;
    }
    
    @IBAction func okButtonClick() {
        if (self.context!.team.teamKey == .home) {
            settings.homeColor = pickerValue!;
        } else {
            settings.awayColor = pickerValue!;
        }
        goHomePage();
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context);
        self.context = (context as! TeamOptionsPageContext);
        let pickerItems: [WKPickerItem] = settings.colorsList.map {
                let pickerItem = WKPickerItem();
                pickerItem.caption = $0.caption;
                pickerItem.title = $0.title;
                return pickerItem;
        }
        colorPicker.setItems(pickerItems);
        var startIndex: Int?;
        if (self.context!.team.teamKey == .home) {
            startIndex = settings.colorsList.firstIndex(where: { $0.colour == settings.homeColor});
            pickerValue = settings.homeColor;
        } else {
            startIndex = settings.colorsList.firstIndex(where: { $0.colour == settings.awayColor});
            pickerValue = settings.awayColor;
        }
        if (startIndex != nil) {
          colorPicker.setSelectedItemIndex(startIndex!);
        }
    }
}
