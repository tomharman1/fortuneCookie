//
//  FortuneInterfaceController.swift
//  FortuneCookie
//
//  Created by Thomas Harman on 10/26/15.
//  Copyright © 2015 Toms Apps. All rights reserved.
//

import WatchKit
import Foundation

class FortuneInterfaceController: WKInterfaceController {
    
    @IBOutlet var fortuneLabel: WKInterfaceLabel!
    
    @IBOutlet var fortuneCookieButton: WKInterfaceButton!

    let fortunesModel = FortunesModel()
    
    let userDefaults = NSUserDefaults(suiteName:"group.com.tomharman.me.FortuneCookie.userdefaults")

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func fortuneCookieBtnTapped() {
        print("can show fortune: \(self.canShowFortune())")
        if (self.canShowFortune()) {
            self.saveFortuneLastAccessedDate()
            self.fortuneLabel.setText(self.fortunesModel.getFortune())
            self.fortuneCookieButton.setBackgroundImageNamed("fortune-guy-speech-bubble")
        }
        else {
            self.fortuneLabel.setText("Wow, you're greedy!\n Come back tomorrow for your next fortune")
            self.fortuneCookieButton.setBackgroundImageNamed("fortune-guy-greedy")
        }
    }
    
    func saveFortuneLastAccessedDate() {
        let today = NSDate()
        userDefaults?.setObject(today, forKey: "lastFortuneAccessedDate")
    }
    
    func canShowFortune()-> Bool {
        let fortuneLastAccessedDate = userDefaults?.objectForKey("lastFortuneAccessedDate")
        if (fortuneLastAccessedDate == nil) {
            return true // no previosuly saved date
        }

//        let hoursElapsedSinceLastFortuneAccessed = fortuneLastAccessedDate.timeIntervalSinceNow / (60 * 60)
        let secondsElapsedSinceLastFortuneAccessed = NSDate().timeIntervalSinceDate(fortuneLastAccessedDate as! NSDate)
        
        if (secondsElapsedSinceLastFortuneAccessed > 5) {
            return true
        }
        else {
            return false
        }
    }
}
