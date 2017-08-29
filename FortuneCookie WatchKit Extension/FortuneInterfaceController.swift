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
    let RAN_OUT_OF_FORTUNES_HAPTIC = WKHapticType.failure
    let NEW_FORTUNE_HAPTIC = WKHapticType.directionDown
    
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
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    override func willActivate() {
        // Called when watch interface is active and able to be updated.
        // Can be called when interface is not visible.
        super.willActivate()
    }
    
    override func didAppear() {
        // NOT called when app already running on watch
        super.didAppear()
        showNewFortune(danceBefore: true)
    }

    @IBAction func fortuneCookieBtnTapped() {
        showNewFortune(danceBefore: false)
    }
    
    fileprivate func showNewFortune(danceBefore: Bool) {
        if (isFortuneQueuedToShow) {
            return
        }
        
        if (danceBefore) {
            dance()
        }
        
        let delaySeconds = danceBefore ? 4.0 : 0.0
        let dispatchTime = DispatchTime.now() + Double(delaySeconds)
        
        isFortuneQueuedToShow = true
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            self.hideDancingFortune()
            self.fortunesModel!.makeFortune()
            self.isFortuneQueuedToShow = false
        })
    }
    
    func showGreedyMessage(message: String) {
        self.playHaptic(type: self.RAN_OUT_OF_FORTUNES_HAPTIC)
        self.fortuneLabel.setText(message)
        self.fortuneCookieButton.setBackgroundImageNamed(self.GREEDY_FORTUNE_IMAGE_NAME)
    }
    
    func showFortune(fortune: String) {
        let hapticType = self.NEW_FORTUNE_HAPTIC
        self.playHaptic(type: hapticType)
        self.fortuneLabel.setText(fortune)
        self.fortuneCookieButton.setBackgroundImageNamed(self.SPEECH_BUBBLE_FORTUNE_IMAGE_NAME)
    }
    
    func showRanOutOfFortunes(fortune: String) {
        let hapticType = self.RAN_OUT_OF_FORTUNES_HAPTIC
        self.playHaptic(type: hapticType)
        self.fortuneLabel.setText(fortune)
        self.fortuneCookieButton.setBackgroundImageNamed(self.SPEECH_BUBBLE_FORTUNE_IMAGE_NAME)
    }

    fileprivate func hideDancingFortune() {
        self.animate(withDuration: 0.5, animations: {
            self.fortuneLabel.setAlpha(1.0)
            self.fortuneLabel.setHeight(self.fortuneLabelHeight)
            self.fortuneCookieButton.setVerticalAlignment(WKInterfaceObjectVerticalAlignment.bottom)
        })
        self.isDancing = false
    }
    
    fileprivate func dance() {
        if (self.isDancing) {
            return
        }
        self.isDancing = true
        self.fortuneCookieButton.setBackgroundImageNamed("fortune")
        self.fortuneLabel.setHeight(0)
        self.fortuneLabel.setAlpha(0)
        self.fortuneCookieButton.setVerticalAlignment(WKInterfaceObjectVerticalAlignment.center)
    }
    
    fileprivate func playHaptic(type: WKHapticType) {
        WKInterfaceDevice.current().play(type)
    }
}
