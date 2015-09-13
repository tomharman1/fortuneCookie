//
//  FortunesModel.swift
//  FirstWatchApp
//
//  Created by Thomas Harman on 7/12/15.
//  Copyright © 2015 Toms Apps. All rights reserved.
//

import WatchKit

class FortunesModel {
    
    var currentFortuneIndex = -1
    
    let fortunes: [String] = ["Your shoes will make you happy today.",
        "You learn from your mistakes... You will learn a lot today.",
        "If you have something good in your life, don't let it go!",
        "What ever you're goal is in life, embrace it visualize it, and for it will be yours.",
        "You cannot love life until you live the life you love.",
        "Be on the lookout for coming events; They cast their shadows beforehand."]
    
    func getFortune() -> String {
        var foundNewFortune = false
        let i = (random() % fortunes.count)
        
        while(!foundNewFortune) { // make sure it's unique
            if (i != currentFortuneIndex) {
                currentFortuneIndex = i
                foundNewFortune = true
            }
        }
        
        return self.fortunes[currentFortuneIndex]
    }
}
