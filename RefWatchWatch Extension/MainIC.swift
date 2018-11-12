//
//  InterfaceController.swift
//  RefWatchWatch Extension
//
//  Created by Martin Croker on 12/06/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import WatchKit
import Foundation
import UIKit
import UserNotifications

class MainIC: WKInterfaceController {
    
    @IBOutlet var WKGameTimer: WKInterfaceTimer!
    
    @IBOutlet var WKElapsedTimer: WKInterfaceTimer!
    
    @IBOutlet var WKTimeButton: WKInterfaceButton!
    
    @IBOutlet var WKHomeScore: WKInterfaceLabel!
    
    @IBOutlet var WKAwayScore: WKInterfaceLabel!

    @IBOutlet var WKGrpHomeSin1: WKInterfaceGroup!
    
    @IBOutlet var WKHomeSinP1: WKInterfaceLabel!
    
    @IBOutlet var WKHomeSinT1: WKInterfaceTimer!
    
    @IBOutlet var WKGrpAwaySin1: WKInterfaceGroup!
    
    @IBOutlet var WKAwaySinP1: WKInterfaceLabel!
    
    @IBOutlet var WKAwaySinT1: WKInterfaceTimer!
    
    @IBOutlet var WKGrpHomeSin2: WKInterfaceGroup!
    
    @IBOutlet var WKHomeSinP2: WKInterfaceLabel!
    
    @IBOutlet var WKHomeSinT2: WKInterfaceTimer!
    
    @IBOutlet var WKGrpAwaySin2: WKInterfaceGroup!
    
    @IBOutlet var WKAwaySinP2: WKInterfaceLabel!
    
    @IBOutlet var WKAwaySinT2: WKInterfaceTimer!
    
    @IBOutlet var WKGrpHomeOff: WKInterfaceGroup!
    
    @IBOutlet var WKHomeOffP: WKInterfaceLabel!
    
    @IBOutlet var WKHomeCautionP: WKInterfaceLabel!
    
    @IBOutlet var WKGrpAwayOff: WKInterfaceGroup!
    
    @IBOutlet var WKAwayOffP: WKInterfaceLabel!
    
    @IBOutlet var WKAwayCautionP: WKInterfaceLabel!
    
    
    func draw() {
        if _context.istimeon {
            WKTimeButton.setTitle("Time Off")
        }
        else {
            WKTimeButton.setTitle("Time On")
        }

        WKAwayScore.setText(String(_context.awayscore.score))
        WKHomeScore.setText(String(_context.homescore.score))
        
        //WKGameTimer.setDate(Date(timeIntervalSinceNow: _context.periodplayedtime ))
        
        if _context.istimeon {
            if _context.istimeup {
                WKGameTimer.setTextColor(UIColor.red)
            }
            else {
                WKGameTimer.setTextColor(UIColor.white)
            }
        }
        else {
            WKGameTimer.setTextColor(UIColor.darkGray)
        }
        
        //WKElapsedTimer.setDate(Date(timeIntervalSinceNow: _context.periodelapsedtime ))
        
        drawsanctions()
    }
    
    func drawsanctions() {
        var homeoff : String = String()
        var awayoff : String = String()
        var homecaution : String = String()
        var awaycaution : String = String()
        var homesinP1 : Int = -1
        var homesinP2 : Int = -1
        var homesinT1 : TimeInterval = 0
        var homesinT2 : TimeInterval = 0
        var awaysinP1 : Int = -1
        var awaysinP2 : Int = -1
        var awaysinT1 : TimeInterval = 0
        var awaysinT2 : TimeInterval = 0
        
        for sanctionitem : RefWatchContextSanction in _context.sanctions {
            if sanctionitem.isingraceperiod {
                
                if sanctionitem.sanctiontype == RefWatchContextSanction.SanctionEnum.sendOff {
    
                    if sanctionitem.ishometeam {
                        if homeoff.characters.count != 0 {
                            homeoff = "\(homeoff),\(sanctionitem.player)"
                        }
                        else {
                            homeoff = "\(sanctionitem.player)"
                        }
                    }
                    else {
                        if awayoff.characters.count != 0 {
                            awayoff = "\(awayoff),\(sanctionitem.player)"
                        }
                        else {
                            awayoff = "\(sanctionitem.player)"
                        }
                    }
                }
                
                if sanctionitem.sanctiontype == RefWatchContextSanction.SanctionEnum.caution {
                    
                    if sanctionitem.ishometeam {
                        if homecaution.characters.count != 0 {
                            homecaution = "\(homecaution),\(sanctionitem.player)"
                        }
                        else {
                            homecaution = "\(sanctionitem.player)"
                        }
                    }
                    else {
                        if awaycaution.characters.count != 0 {
                            awaycaution = "\(awaycaution),\(sanctionitem.player)"
                        }
                        else {
                            awaycaution = "\(sanctionitem.player)"
                        }
                    }
                }
                
                if sanctionitem.sanctiontype == RefWatchContextSanction.SanctionEnum.sinBin {
                    
                    if sanctionitem.ishometeam {
                        if homesinP1 == -1 || sanctionitem.timeremaining < homesinT1 {
                            homesinP2 = homesinP1
                            homesinT2 = homesinT1
                            homesinP1 = sanctionitem.player
                            homesinT1 = sanctionitem.timeremaining
                        } else if homesinP2 == -1 || sanctionitem.timeremaining < homesinT2 {
                            homesinP2 = sanctionitem.player
                            homesinT2 = sanctionitem.timeremaining
                        }
                    }
                    else {
                        if awaysinP1 == -1 || sanctionitem.timeremaining < awaysinT1 {
                            awaysinP2 = awaysinP1
                            awaysinT2 = awaysinT1
                            awaysinP1 = sanctionitem.player
                            awaysinT1 = sanctionitem.timeremaining

                        } else if awaysinP2 == -1 || sanctionitem.timeremaining < awaysinT2 {
                            awaysinP2 = sanctionitem.player
                            awaysinT2 = sanctionitem.timeremaining
                        }
                    }
                }
                
            }
        }

        WKHomeOffP.setText(homeoff)
        WKAwayOffP.setText(awayoff)
        WKHomeCautionP.setText(homecaution)
        WKAwayCautionP.setText(awaycaution)
        
        if homesinP1 != -1 {
            WKHomeSinP1.setText("\(homesinP1) ")
            WKHomeSinT1.setDate(Date(timeIntervalSinceNow: homesinT1 ))
            WKGrpHomeSin1.setHidden(false)
            if homesinT1 == 0 {
                WKHomeSinP1.setTextColor(UIColor.green)
                WKHomeSinT1.setTextColor(UIColor.green)	
            }
            else {
                WKHomeSinP1.setTextColor(UIColor.yellow)
                WKHomeSinT1.setTextColor(UIColor.yellow)
            }
            if homesinP2 != -1 {
                WKHomeSinP2.setText("\(homesinP2) ")
                WKHomeSinT2.setDate(Date(timeIntervalSinceNow: homesinT2 ))
                WKGrpHomeSin2.setHidden(false)
                if homesinT2 == 0 {
                    WKHomeSinP2.setTextColor(UIColor.green)
                    WKHomeSinT2.setTextColor(UIColor.green)
                }
                else {
                    WKHomeSinP2.setTextColor(UIColor.yellow)
                    WKHomeSinT2.setTextColor(UIColor.yellow)
                }
            }
            else {
                WKGrpHomeSin2.setHidden(true)
            }
        }
        else {
            WKGrpHomeSin1.setHidden(true)
            WKGrpHomeSin2.setHidden(true)
        }
        
        if awaysinP1 != -1 {
            WKAwaySinP1.setText("\(awaysinP1) ")
            WKAwaySinT1.setDate(Date(timeIntervalSinceNow: awaysinT1 ))
            WKGrpAwaySin1.setHidden(false)
            if awaysinT1 == 0 {
                WKAwaySinP1.setTextColor(UIColor.green)
                WKAwaySinT1.setTextColor(UIColor.green)
            }
            else {
                WKAwaySinP1.setTextColor(UIColor.yellow)
                WKAwaySinT1.setTextColor(UIColor.yellow)
            }
            if awaysinP2 != -1 {
                WKAwaySinP2.setText("\(awaysinP2) ")
                WKAwaySinT2.setDate(Date(timeIntervalSinceNow: awaysinT2 ))
                WKGrpAwaySin2.setHidden(false)
                if awaysinT2 == 0 {
                    WKAwaySinP2.setTextColor(UIColor.green)
                    WKAwaySinT2.setTextColor(UIColor.green)
                }
                else {
                    WKAwaySinP2.setTextColor(UIColor.yellow)
                    WKAwaySinT2.setTextColor(UIColor.yellow)
                }
            }
            else {
                WKGrpAwaySin2.setHidden(true)
            }
        }
        else {
            WKGrpAwaySin1.setHidden(true)
            WKGrpAwaySin2.setHidden(true)
        }
    }
    
    @IBAction func WKMenuReset() {
        context.resetAll()
        _oldistimeup = false
        draw()
        
        for complicaationitem : CLKComplication in _complicationserver.activeComplications! {
            _complicationserver.reloadTimeline(for: complicaationitem)
        }
    }
    
    @IBAction func WKMenuHalfTime() {
        context.resetTime()
        _oldistimeup = false
        draw()
        
        for complicaationitem : CLKComplication in _complicationserver.activeComplications! {
            _complicationserver.reloadTimeline(for: complicaationitem)
        }
    }

    @IBAction func WKMenuSettings() {
        presentController(withName: "SettingsCtl" , context: _context)
        for complicaationitem : CLKComplication in _complicationserver.activeComplications! {
            _complicationserver.reloadTimeline(for: complicaationitem)
        }
    }
    
    @IBAction func WKMenuSanction() {
        _context.tmpsanction.player = -1
        presentController(withName: "SanctionTypeCtl", context: _context)
        
    }

    @IBAction func WKHomeScoreGroupButton() {
        context.ishomeopp = true
        presentController(withName: "ScoreCtl" , context: _context)
    }

    @IBAction func WKAwayScoreGroupButton() {
        context.ishomeopp=false
        presentController(withName: "ScoreCtl" , context: _context)
        WKAwayScore.setText(String(_context.awayscore.score))
    }
    
    var context : RefWatchContext {
        get {
            return _context
        }
    }
    
    var myTimer : Timer?  //internal timer to keep track
    var TimerInterval : TimeInterval = 1
    
    var _context : RefWatchContext
    var _complicationserver : CLKComplicationServer
    var _oldistimeup : Bool = false

    override init() {
        _context=RefWatchContext.sharedInstance
        _complicationserver=CLKComplicationServer.sharedInstance()
        super.init()
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        if context is RefWatchContext {
            _context = context as! RefWatchContext
        }
        draw()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        	draw()
        
        // Start the timer
        myTimer = Timer.scheduledTimer(timeInterval: TimerInterval, target: self, selector: #selector(MainIC.timerDone), userInfo: nil, repeats: true)

       WKGameTimer.setDate(_context.logicalperiodend)
    }
    
    @objc func timerDone(){
        
        //WKGameTimer.setDate(Date(timeIntervalSinceNow: _context.periodplayedtime ))
        
        if _context.istimeup && !_oldistimeup {
            WKGameTimer.setTextColor(UIColor.red)
            for complicaationitem : CLKComplication in _complicationserver.activeComplications! {
                _complicationserver.reloadTimeline(for: complicaationitem)
            }
            
            WKInterfaceDevice.current().play(WKHapticType.notification)
            
            // Create the content
            let content = UNMutableNotificationContent()
            content.title = NSString.localizedUserNotificationString(forKey: "RefWatch", arguments: nil)
            content.body = NSString.localizedUserNotificationString(forKey: "Time Up", arguments: nil)
            content.sound = UNNotificationSound.default
            
            // Deliver the notification in five seconds.
            let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 1, repeats: false)
            let request = UNNotificationRequest.init(identifier: "TimeUp", content: content, trigger:trigger)
            
            // Schedule the notification.
            let center = UNUserNotificationCenter.current()
            center.add(request)
            
        }
        
        _oldistimeup = _context.istimeup
        
        drawsanctions()
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func TimeButtonClick() {
        
        if !_context.istimeon {
            if !_context.isperiodrunning {
                WKElapsedTimer.setDate(Date(timeIntervalSinceNow: _context.periodelapsedtime))
                WKElapsedTimer.start()
            }
            if _context.istimeup {
                WKGameTimer.setTextColor(UIColor.red)
            }
            else {
                WKGameTimer.setTextColor(UIColor.white)
            }
            _context.istimeon=true

            WKGameTimer.setDate(_context.logicalperiodend)
            WKGameTimer.start()
        }
        else {
            WKGameTimer.setTextColor(UIColor.darkGray)
            WKGameTimer.stop()
            _context.istimeon=false
        }
        
        
        for complicaationitem : CLKComplication in _complicationserver.activeComplications! {
            _complicationserver.reloadTimeline(for: complicaationitem)
        }
        
    }

}
