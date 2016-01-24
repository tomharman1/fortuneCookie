//
//  GlanceController.swift
//  FortuneCookie WatchKit Extension
//
//  Created by Thomas Harman on 9/13/15.
//  Copyright © 2015 Toms Apps. All rights reserved.
//

import WatchKit
import Foundation


class GlanceController: WKInterfaceController, FortuneControllerProtocol {

    @IBOutlet var label: WKInterfaceLabel!
    
    private var fortunesModel: FortunesModel?

    override init () {
        super.init()
        fortunesModel = FortunesModel(fortuneController: self)
    }

    func showGreedyMessage(greedyMessage: String) {
        label.setText(greedyMessage)
    }

    func showFortune(fortune: String) {
        label.setText(fortune)
    }

    func showRanOutOfFortunes(fortune: String){
        label.setText(fortune)
    }

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        self.fortunesModel?.makeFortune(true)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
