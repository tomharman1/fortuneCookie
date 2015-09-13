//
//  InterfaceController.swift
//  FortuneCookie WatchKit Extension
//
//  Created by Thomas Harman on 9/13/15.
//  Copyright © 2015 Toms Apps. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var label: WKInterfaceLabel!

    @IBOutlet var hapticTestBtn: WKInterfaceButton!
    
    var count = 0
    
    let fortunesModel = FortunesModel()
    
    var hapticTypes = [
        WKHapticType.Notification,
        WKHapticType.DirectionUp,
        WKHapticType.DirectionDown,
        WKHapticType.Success,
        WKHapticType.Failure,
        WKHapticType.Retry,
        WKHapticType.Start,
        WKHapticType.Stop,
        WKHapticType.Click,
    ]
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        self.updateHapticTestBtnText()
        self.showNextFortune()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func hapticTestBtnPressed() {
        let hapticType = hapticTypes[self.count]
        WKInterfaceDevice.currentDevice().playHaptic(hapticType)
        
        self.count = self.count + 1
        if (self.count == self.hapticTypes.count - 1) {
            self.count = 0 // reset count
        }
        self.updateHapticTestBtnText()
        self.showNextFortune()
    }
    
    func showNextFortune() {
        self.label.setText(self.fortunesModel.getFortune())
    }
    
    func updateHapticTestBtnText() {
        self.hapticTestBtn.setTitle("Play Haptic:\(self.count)")
    }
    
    override func handleActionWithIdentifier(identifier: String?, forLocalNotification localNotification: UILocalNotification) {
        print("got a local notification")
    }
    
    override func handleActionWithIdentifier(identifier: String?, forRemoteNotification remoteNotification: [NSObject : AnyObject]) {
        print("got a remote notification")
    }
}
