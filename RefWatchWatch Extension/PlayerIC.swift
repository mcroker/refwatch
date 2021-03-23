//
//  InterfaceController.swift
//  RefWatchWatch Extension
//
//  Created by Martin Croker on 12/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import WatchKit
import Foundation

class PlayerIC: RefWatchSuperIC {

    @IBOutlet var okButton: WKInterfaceButton!
    @IBOutlet var playerNumber: WKInterfaceLabel!
    @IBOutlet var backButton: WKInterfaceButton!
    @IBOutlet weak var num1Button: WKInterfaceButton!
    @IBOutlet weak var num2Button: WKInterfaceButton!
    @IBOutlet weak var num3Button: WKInterfaceButton!
    @IBOutlet weak var num4Button: WKInterfaceButton!
    @IBOutlet weak var num5Button: WKInterfaceButton!
    @IBOutlet weak var num6Button: WKInterfaceButton!
    @IBOutlet weak var num7Button: WKInterfaceButton!
    @IBOutlet weak var num8Button: WKInterfaceButton!
    @IBOutlet weak var num9Button: WKInterfaceButton!
    @IBOutlet weak var num0Button: WKInterfaceButton!
    
    private var sharedState : SharedTeamState = SharedTeamState.getInstance();
    private var match: Match = MatchFactory.getCurrentMatch();
    
    override init() {
        super.init();
        NotificationCenter.default.addObserver(self, selector: #selector(activatePlayerPageHander(notification:)), name: .activatePlayerPage, object: nil);
    }
    
    override func awake(withContext: Any?) {
        super.awake(withContext: withContext);
        self.okButton.setTitle("Skip No.");
        backButton.setEnabled(false);
        
        /*
 keypressed = false;
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(10), execute: {
            if !self.keypressed {
                self.okButtonClick();
            }
        })
 */
    }
    
    override func willActivate() {
       self.setTitle(self.sharedState.toPlayerTitle());
    }

    @objc public func activatePlayerPageHander(notification: NSNotification) {
        self.becomeCurrentPage();
    }
    
    @IBAction func okButtonClick() {
        // self.keypressed = true;
        match.addEvent(self.sharedState.toEvent());
        goHomePage();
    }
    
    fileprivate func numberButtonClick(_ number: Int) {
        // self.keypressed = true;
        self.okButton.setTitle("Ok");
        var nextstring : String
        if nil == self.sharedState.player {
            self.sharedState.player = number
            nextstring = "\(number)"
        }
        else {
            nextstring = "\(self.sharedState.player!)\(number)"
            self.sharedState.player = Int(nextstring)!
        }
        playerNumber.setText(nextstring)
        okButton.setEnabled(true)
        backButton.setEnabled(true)
        
        if nextstring.count > 1 {
            num1Button.setEnabled(false)
            num2Button.setEnabled(false)
            num3Button.setEnabled(false)
            num4Button.setEnabled(false)
            num5Button.setEnabled(false)
            num6Button.setEnabled(false)
            num7Button.setEnabled(false)
            num8Button.setEnabled(false)
            num9Button.setEnabled(false)
            num0Button.setEnabled(false)
        }
    }
    
    @IBAction func backspaceButtonClick() {
        if nil != self.sharedState.player {
            let curstring : String = String(self.sharedState.player!);
            let truncated = String(curstring.dropLast())
            playerNumber.setText(truncated)
            
            if truncated.count > 0 {
                self.sharedState.player = Int(truncated)!
            }
            else {
                self.sharedState.player = nil
                backButton.setEnabled(false)
                self.okButton.setTitle("Skip No.");
            }
            num1Button.setEnabled(true)
            num2Button.setEnabled(true)
            num3Button.setEnabled(true)
            num4Button.setEnabled(true)
            num5Button.setEnabled(true)
            num6Button.setEnabled(true)
            num7Button.setEnabled(true)
            num8Button.setEnabled(true)
            num9Button.setEnabled(true)
            num0Button.setEnabled(true)
        }
    }
    
    @IBAction func WKNo1Button() {
        numberButtonClick(1)
    }
    
    @IBAction func WKNo2Button() {
        numberButtonClick(2)
    }

    @IBAction func WKNo3Button() {
        numberButtonClick(3)
    }
    
    @IBAction func WKNo4Button() {
        numberButtonClick(4)
    }
    
    @IBAction func WKNo5Button() {
        numberButtonClick(5)
    }
    
    @IBAction func WKNo6Button() {
        numberButtonClick(6)
    }
    
    @IBAction func WKNo7Button() {
        numberButtonClick(7)
    }
    
    @IBAction func WKNo8Button() {
        numberButtonClick(8)
    }
    
    @IBAction func WKNo9Button() {
        numberButtonClick(9)
    }
    
    @IBAction func WKNo0Button() {
        numberButtonClick(0)
    }
    
}
