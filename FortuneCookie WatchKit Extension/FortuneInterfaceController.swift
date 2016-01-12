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
    
    let YOU_ARE_GREEDY_STR = "Wow, you're greedy!\n Come back tomorrow for a New fortune"
    let RAN_OUT_OF_FORTUNES_HAPTIC = WKHapticType.Failure
    let NEW_FORTUNE_HAPTIC = WKHapticType.DirectionDown
    
    @IBOutlet var fortuneLabel: WKInterfaceLabel!
    @IBOutlet var fortuneCookieButton: WKInterfaceButton!

    let fortunesModel = FortunesModel()
    let nsDataFacade = NSDataFacade()
    let fortuneLabelHeight = CGFloat(50)
    var isDancing = false
    var isFortuneQueuedToShow = false

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
//        nsDataFacade.reset()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        if (self.canShowFortune()) {
            showDancingFortune()
            showFortune(true)
        }
        else {
            showLastFortune()
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func fortuneCookieBtnTapped() {
        showFortune(false)
    }
    
    private func showFortune(isShowDelayed: Bool) {
        if (isFortuneQueuedToShow) {
            return
        }
        
        let delaySeconds = isShowDelayed ? 4.0 : 0.0
        let delay = delaySeconds * Double(NSEC_PER_SEC)
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        isFortuneQueuedToShow = true
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            self.hideDancingFortune()
            
            print("can show fortune: \(self.canShowFortune())")
            let canShowFortune = self.canShowFortune() // true
            if (canShowFortune) {
                let fortune = self.fortunesModel.getFortune()
//                let fortune = "Open me on your watch. iPhone app coming soon..."
                let hapticType = (fortune == self.fortunesModel.RAN_OUT_OF_FORTUNES_STR) ? self.RAN_OUT_OF_FORTUNES_HAPTIC : self.NEW_FORTUNE_HAPTIC
                self.nsDataFacade.saveFortuneLastAccessedNow() // TODO: perhaps this should be in the model. Not the view controller
                self.playHaptic(hapticType)
                self.fortuneLabel.setText(fortune)
                self.fortuneCookieButton.setBackgroundImageNamed("fortune-guy-speech-bubble")
            }
            else {
                self.playHaptic(self.RAN_OUT_OF_FORTUNES_HAPTIC)
                self.fortuneLabel.setText(self.YOU_ARE_GREEDY_STR)
                self.fortuneCookieButton.setBackgroundImageNamed("fortune-guy-greedy")
            }
            
            self.isFortuneQueuedToShow = false
        })
    }

    private func showLastFortune() {
        self.fortuneLabel.setText(self.fortunesModel.getLastShownFortune())
        self.fortuneCookieButton.setBackgroundImageNamed("fortune-guy-speech-bubble")
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
        let fortuneLastAccessedDate = nsDataFacade.getFortuneLastAccessedDate()
        if (fortuneLastAccessedDate == nil) {
            return true // no previosuly saved date
        }
        
        let hoursElapsedSinceLastFortuneAccessed = NSDate().timeIntervalSinceDate(fortuneLastAccessedDate!) / (60 * 60)
        if (hoursElapsedSinceLastFortuneAccessed > 12) {
            return true
        }
        else {
            return false
        }
    }
}
