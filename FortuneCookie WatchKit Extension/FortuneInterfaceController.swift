//
//  FortuneInterfaceController.swift
//  FortuneCookie
//
//  Created by Thomas Harman on 10/26/15.
//  Copyright © 2015 Toms Apps. All rights reserved.
//

import WatchKit
import Foundation

class FortuneInterfaceController: WKInterfaceController, FortuneControllerProtocol {
    
    let GREEDY_FORTUNE_IMAGE_NAME = "fortune-guy-greedy"
    let SPEECH_BUBBLE_FORTUNE_IMAGE_NAME = "fortune-guy-speech-bubble"
    let RAN_OUT_OF_FORTUNES_HAPTIC = WKHapticType.Failure
    let NEW_FORTUNE_HAPTIC = WKHapticType.DirectionDown
    
    @IBOutlet var fortuneLabel: WKInterfaceLabel!
    @IBOutlet var fortuneCookieButton: WKInterfaceButton!

    var fortunesModel: FortunesModel?
    let fortuneLabelHeight = CGFloat(50)
    var isDancing = false
    var isFortuneQueuedToShow = false
    
    override init() {
        super.init()
        fortunesModel = FortunesModel(fortuneController: self)
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }
    
    override func willActivate() {
        // Called when watch interface is active and able to be updated.
        // Can be called when interface is not visible.
        super.willActivate()
//        let appRunning = (self.currentState != nil)
//        if (appRunning) { // app already running on watch so didAppear() won't be called. Show fortune
//            showNewFortune(true)
//        }
    }
    
    override func didAppear() {
        // NOT called when app already running on watch
        super.didAppear()
        showNewFortune(true)
    }

    @IBAction func fortuneCookieBtnTapped() {
        showNewFortune(false)
    }
    
    private func showNewFortune(danceBefore: Bool) {
        if (isFortuneQueuedToShow) {
            return
        }
        
        if (danceBefore) {
            dance()
        }
        
        let delaySeconds = danceBefore ? 4.0 : 0.0
        let delay = delaySeconds * Double(NSEC_PER_SEC)
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        isFortuneQueuedToShow = true
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            self.hideDancingFortune()
            self.fortunesModel!.makeFortune()
            self.isFortuneQueuedToShow = false
        })
    }
    
    func showGreedyMessage(greedyMessage: String) {
        self.playHaptic(self.RAN_OUT_OF_FORTUNES_HAPTIC)
        self.fortuneLabel.setText(greedyMessage)
        self.fortuneCookieButton.setBackgroundImageNamed(self.GREEDY_FORTUNE_IMAGE_NAME)
    }
    
    func showFortune(fortune: String) {
        let hapticType = self.NEW_FORTUNE_HAPTIC
        self.playHaptic(hapticType)
        self.fortuneLabel.setText(fortune)
        self.fortuneCookieButton.setBackgroundImageNamed(self.SPEECH_BUBBLE_FORTUNE_IMAGE_NAME)
    }
    
    func showRanOutOfFortunes(fortune: String) {
        let hapticType = self.RAN_OUT_OF_FORTUNES_HAPTIC
        self.playHaptic(hapticType)
        self.fortuneLabel.setText(fortune)
        self.fortuneCookieButton.setBackgroundImageNamed(self.SPEECH_BUBBLE_FORTUNE_IMAGE_NAME)
    }

    private func hideDancingFortune() {
        self.animateWithDuration(0.5, animations: {
            self.fortuneLabel.setAlpha(1.0)
            self.fortuneLabel.setHeight(self.fortuneLabelHeight)
            self.fortuneCookieButton.setVerticalAlignment(WKInterfaceObjectVerticalAlignment.Bottom)
        })
        self.isDancing = false
    }
    
    private func dance() {
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
}
