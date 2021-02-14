//
//  InterfaceController.swift
//  RefWatchWatch Extension
//
//  Created by Martin Croker on 12/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import WatchKit
import Foundation

enum EscalationState {
    case none;
    case caution;
    case yellowCard;
    case redCard;
}

class SanctionIC: RefWatchSuperIC {
    
    @IBOutlet weak var sanctionPicker: WKInterfacePicker!
    @IBOutlet weak var cautionButton: WKInterfaceButton!
    @IBOutlet weak var yellowCardButton: WKInterfaceButton!
    @IBOutlet weak var redCardButton: WKInterfaceButton!
    
    private var sharedState : SharedTeamState = SharedTeamState.getInstance();
    private let match : Match = Match.getCurrentMatch();
    private let settings : MatchSettings = Match.getCurrentMatch().settings;
    
    override func awake(withContext: Any?) {
        super.awake(withContext: withContext);
        let pickerItems: [WKPickerItem] = settings.sanctionList.map {
            let pickerItem = WKPickerItem();
            pickerItem.caption = $0.caption;
            pickerItem.title = $0.title;
            return pickerItem;
        }
        sanctionPicker.setItems(pickerItems);
    }
    
    override func willActivate() {
        self.setTitle(self.sharedState.team!.title);
    }
    
    private func toggleEscalation(escalation: EscalationState) {
        switch escalation {
        case .redCard:
            if (self.sharedState.escalation != .redCard) {
                self.sharedState.escalation = .redCard;
            } else {
                self.sharedState.escalation = .none;
            }
        case .yellowCard:
            if (self.sharedState.escalation != .yellowCard) {
                self.sharedState.escalation = .yellowCard;
            } else {
                self.sharedState.escalation = .none;
            }
        case .caution:
            if (self.sharedState.escalation != .caution) {
                self.sharedState.escalation = .caution;
            } else {
                self.sharedState.escalation = .none;
            }
        default:
            self.sharedState.escalation = .none;
        }
        if (self.sharedState.escalation == .redCard) {
            self.redCardButton.setBackgroundColor(.red);
            let attString = NSMutableAttributedString(string: "RC");
            attString.setAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], range: NSMakeRange(0, attString.length));

            self.redCardButton.setAttributedTitle(attString);
        } else {
            self.redCardButton.setBackgroundColor(nil);
            self.redCardButton.setTitle("RC");
        }
        if (self.sharedState.escalation == .yellowCard) {
            self.yellowCardButton.setBackgroundColor(.yellow);
            let attString = NSMutableAttributedString(string: "YC");
            attString.setAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], range: NSMakeRange(0, attString.length));

            self.yellowCardButton.setAttributedTitle(attString);
        } else {
            self.yellowCardButton.setBackgroundColor(nil);
            self.yellowCardButton.setTitle("YC");
        }
        if (self.sharedState.escalation == .caution) {
            self.cautionButton.setBackgroundColor(.gray);
        } else {
            self.cautionButton.setBackgroundColor(nil);
        }
    }
    
    
    @IBAction func offencePickerUpdated(_ value: Int) {
        self.sharedState.offenceIndex = (0 != value) ? value : nil;
    }
    
    @IBAction func cautionButtonClick() {
        toggleEscalation(escalation: .caution);
    }
    
    @IBAction func yellowCardButtonClick() {
        toggleEscalation(escalation: .yellowCard);
    }
    
    @IBAction func redCardButtonClick() {
        toggleEscalation(escalation: .redCard);
    }
    
    @IBAction func cancelButtonClick() {
        goHomePage();
    }
    
    @IBAction func okButtonClick() {
        if (self.sharedState.escalation == .none) {
            match.addEvent(self.sharedState.toEvent());
            goHomePage();
        } else {
            activatePlayerPage();
        }
    }
    
}
