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
        self.fortuneLabel.setText(self.fortunesModel.getFortune())
    }
}
