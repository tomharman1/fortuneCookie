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
    let nsDataFacade = NSDataFacade()
    
    var isDancing = true
    
    let fortuneLabelHeight = CGFloat(50)

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        nsDataFacade.reset()
        
        // Configure interface objects here.
        self.fortuneCookieButton.setBackgroundImageNamed("fortune")
        self.fortuneLabel.setHeight(0)
        self.fortuneLabel.setAlpha(0)
        self.fortuneCookieButton.setVerticalAlignment(WKInterfaceObjectVerticalAlignment.Center)
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
        
        if (self.isDancing) {
            self.animateWithDuration(0.5, animations: {
                self.fortuneLabel.setAlpha(1.0)
                self.fortuneLabel.setHeight(self.fortuneLabelHeight)
                self.fortuneCookieButton.setVerticalAlignment(WKInterfaceObjectVerticalAlignment.Bottom)
            })
        }
        
        print("can show fortune: \(self.canShowFortune())")
        if (self.canShowFortune()) {
            nsDataFacade.saveFortuneLastAccessedNow()
            
            self.fortuneLabel.setText(self.fortunesModel.getFortune())
            self.fortuneCookieButton.setBackgroundImageNamed("fortune-guy-speech-bubble")
        }
        else {
            self.fortuneLabel.setText("Wow, you're greedy!\n Come back tomorrow for your next fortune")
            self.fortuneCookieButton.setBackgroundImageNamed("fortune-guy-greedy")
        }
    }
    
    func canShowFortune()-> Bool {
        let fortuneLastAccessedDate = nsDataFacade.getFortuneLastAccessedDate()
        if (fortuneLastAccessedDate == nil) {
            return true // no previosuly saved date
        }

//        let hoursElapsedSinceLastFortuneAccessed = fortuneLastAccessedDate.timeIntervalSinceNow / (60 * 60)
        let secondsElapsedSinceLastFortuneAccessed = NSDate().timeIntervalSinceDate(fortuneLastAccessedDate!)
        
        if (secondsElapsedSinceLastFortuneAccessed > 5) {
            return true
        }
        else {
            return false
        }
    }
    
    override func handleActionWithIdentifier(identifier: String?, forLocalNotification localNotification: UILocalNotification) {
        print("got an action to handle")
    }
    
    override func handleActionWithIdentifier(identifier: String?, forRemoteNotification remoteNotification: [NSObject : AnyObject]) {
        print("got an action to handle")
    }
    

}
