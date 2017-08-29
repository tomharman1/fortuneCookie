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
    
    fileprivate var fortunesModel: FortunesModel?

    override init () {
        super.init()
        fortunesModel = FortunesModel(fortuneController: self)
    }

    func showGreedyMessage(message: String) {
        label.setText(message)
    }

    func showFortune(fortune: String) {
        label.setText(fortune)
    }

    func showRanOutOfFortunes(fortune: String){
        label.setText(fortune)
    }

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        self.fortunesModel?.makeFortune(isGlance: true)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
