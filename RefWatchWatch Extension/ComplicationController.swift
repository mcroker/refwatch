//
//  ComplicationController.swift
//  Temp WatchKit Extension
//
//  Created by Martin Croker on 12/11/2016.
//  Copyright © 2016 Martin Croker. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    var _context = RefWatchContext.sharedInstance
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        
        if complication.family == .modularLarge {
            let dateFormatter = DateFormatter()
            //dateFormatter.dateStyle = .none
            //dateFormatter.timeStyle = .short
            dateFormatter.dateFormat = "mm:ss"
            
            let template = CLKComplicationTemplateModularLargeTallBody()

            template.headerTextProvider = CLKSimpleTextProvider(text: "RefWatch")
            
            if (_context.istimeup) {
                template.tintColor = UIColor.red
                template.bodyTextProvider.tintColor = UIColor.red
                template.bodyTextProvider = CLKSimpleTextProvider(text: "00:00")
            } else {
                              if (_context.istimeon) {
                                template.bodyTextProvider = CLKRelativeDateTextProvider(date: _context.logicalperiodend, style: CLKRelativeDateStyle.timer, units: NSCalendar.Unit.minute.union(NSCalendar.Unit.second))

                    template.tintColor = UIColor.white
                    template.bodyTextProvider.tintColor = UIColor.white
                    
                } else {
                                template.bodyTextProvider = CLKSimpleTextProvider(text: dateFormatter.string(from: Date(timeIntervalSinceNow: _context.periodremainingtime)))
                    template.tintColor = UIColor.darkGray
                    template.bodyTextProvider.tintColor = UIColor.darkGray
                }
            }
            
            let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate:template)
            
            handler(entry)
        } else {
            handler(nil)
        }
    }

    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([])
        //handler([.forward, .backward])

    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    internal func getNextRequestedUpdateDate(handler: @escaping (Date?) -> Void) {
        // Update every minite
        handler(Date(timeIntervalSinceNow: 1))
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    

    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping (	[CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        handler(nil)
    }
    
    func getPlaceholderTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        var template: CLKComplicationTemplate? = nil
        switch complication.family {
        case .modularSmall:
            template = nil
        case .modularLarge:
            let modularTemplate = CLKComplicationTemplateModularLargeTallBody()
            modularTemplate.bodyTextProvider = CLKTimeTextProvider(date: Date())
            modularTemplate.headerTextProvider = CLKSimpleTextProvider(text: "RefWatch")
            template = modularTemplate
        case .utilitarianSmall:
            template = nil
        case .utilitarianLarge:
            template = nil
        case .circularSmall:
            let circularTemplate = CLKComplicationTemplateCircularSmallStackText()
            circularTemplate.line1TextProvider = CLKSimpleTextProvider(text: "TEAM")
            circularTemplate.line2TextProvider = CLKSimpleTextProvider(text: "--")
            template = circularTemplate
        default:
            template = nil
        }
        handler(template)
    }
    
}
