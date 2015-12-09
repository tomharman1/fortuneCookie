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
    
    let RAN_OUT_OF_FORTUNES_MSG = "You ran out of Fortunes!"
    let HAPTIC_TYPES = [
        WKHapticType.Notification,
        WKHapticType.DirectionUp,
        WKHapticType.DirectionDown, // show fortune
        WKHapticType.Success,
        WKHapticType.Failure, // no fortunes
        WKHapticType.Retry,
        WKHapticType.Start,
        WKHapticType.Stop,
        WKHapticType.Click,
    ]
    
    @IBOutlet var fortuneLabel: WKInterfaceLabel!
    @IBOutlet var fortuneCookieButton: WKInterfaceButton!

    let fortunesModel = FortunesModel()
    let nsDataFacade = NSDataFacade()
    let fortuneLabelHeight = CGFloat(50)
    var isDancing = false
    var isFortuneQueuedToShow = false

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        nsDataFacade.reset() // TODO: remove before shipping
        
        showDancingFortune()
        showFortune(true)
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
        showFortune(false)
    }
    
    override func handleActionWithIdentifier(identifier: String?, forLocalNotification localNotification: UILocalNotification) {
        print("got a local notification to handle")
        
        // TODO: This doesn't get called when opening local notification. Find out how to make fortune dance when opening via notification
        
//        showDancingFortune()
//        showFortune(true)
//        print("identifier was: \(identifier)")
    }
    
    override func handleActionWithIdentifier(identifier: String?, forRemoteNotification remoteNotification: [NSObject : AnyObject]) {
        print("got an action to handle")
    }
    
    private func showFortune(isShowDelayed: Bool) {
        if (isFortuneQueuedToShow) {
            return
        }
        
        let delaySeconds = isShowDelayed ? 4.0 : 0.0
        let delay = delaySeconds * Double(NSEC_PER_SEC) // nanoseconds per seconds
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        isFortuneQueuedToShow = true
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            self.hideDancingFortune()
            
            print("can show fortune: \(self.canShowFortune())")
            if (self.canShowFortune()) {
                let fortune = self.fortunesModel.getFortune() ?? self.RAN_OUT_OF_FORTUNES_MSG
                let hapticType = fortune == self.RAN_OUT_OF_FORTUNES_MSG ? self.HAPTIC_TYPES[4] : self.HAPTIC_TYPES[2]
                self.nsDataFacade.saveFortuneLastAccessedNow() // TODO: perhaps this should be in the model. Not the view controller
                self.playHaptic(hapticType)
                self.fortuneLabel.setText(fortune)
                self.fortuneCookieButton.setBackgroundImageNamed("fortune-guy-speech-bubble")
            }
            else {
                self.playHaptic(self.HAPTIC_TYPES[4])
                self.fortuneLabel.setText("Wow, you're greedy!\n Come back tomorrow for your next fortune")
                self.fortuneCookieButton.setBackgroundImageNamed("fortune-guy-greedy")
            }
            
            self.isFortuneQueuedToShow = false
        })
    }
    
    private func hideDancingFortune() {
        self.animateWithDuration(0.5, animations: {
            self.fortuneLabel.setAlpha(1.0)
            self.fortuneLabel.setHeight(self.fortuneLabelHeight)
            self.fortuneCookieButton.setVerticalAlignment(WKInterfaceObjectVerticalAlignment.Bottom)
        })
        self.isDancing = false
    }
    
    private func showDancingFortune() {
        if (self.isDancing) {
            return
        }
        self.isDancing = true
        self.fortuneCookieButton.setBackgroundImageNamed("fortune")
        self.fortuneLabel.setHeight(0)
        self.fortuneLabel.setAlpha(0)
        self.fortuneCookieButton.setVerticalAlignment(WKInterfaceObjectVerticalAlignment.Center)
    }
    
    private func playHaptic(type: WKHapticType) {
        WKInterfaceDevice.currentDevice().playHaptic(type)
    }
    
    private func canShowFortune()-> Bool {
        //        return true
        let fortuneLastAccessedDate = nsDataFacade.getFortuneLastAccessedDate()
        if (fortuneLastAccessedDate == nil) {
            return true // no previosuly saved date
        }
        
        let hoursElapsedSinceLastFortuneAccessed = NSDate().timeIntervalSinceDate(fortuneLastAccessedDate!) / (60 * 60)
        //        let secondsElapsedSinceLastFortuneAccessed = NSDate().timeIntervalSinceDate(fortuneLastAccessedDate!)
        if (hoursElapsedSinceLastFortuneAccessed > -1) {
            return true
        }
        else {
            return false
        }
    }
}
