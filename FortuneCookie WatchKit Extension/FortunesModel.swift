//
//  FortunesModel.swift
//  FirstWatchApp
//
//  Created by Thomas Harman on 7/12/15.
//  Copyright © 2015 Toms Apps. All rights reserved.
//

import WatchKit

class FortunesModel {
    
    let nsDataFacade = NSDataFacade()
    
    let maxLengthFortuneSupported = 115
    
    var currentFortuneIndex = -1
    
    let fortunes: [String] = ["Your shoes will make you happy today.",
        "You learn from your mistakes... You will learn a lot today.",
        "If you have something good in your life, don't let it go!",
        "What ever you're goal is in life, embrace it visualize it, and for it will be yours.",
        "You cannot love life until you live the life you love.",
        "Be on the lookout for coming events; They cast their shadows beforehand."]
    
    func getFortune() -> String {
        while(isHaveAFortuneToShow()) {
            let i = (random() % fortunes.count)
            let fortune = self.fortunes[i]
            if (isValidFortune(i)) {
                nsDataFacade.sawFortuneWithIndex(i)
                currentFortuneIndex = i
                return fortune
            }
            else {
                print("couldn't find a fortune on this attempt! (length: \(fortune.characters.count))")
            }
        }
        
        return "You ran out of Fortunes!"
    }
    
    private func isHaveAFortuneToShow() -> Bool {
        return nsDataFacade.seenFortunesCount() < fortunes.count
    }
    
    private func isValidFortune(i: Int) -> Bool {
        let fortuneLength = self.fortunes[i].characters.count
        return (i != currentFortuneIndex) &&
                (fortuneLength < maxLengthFortuneSupported) &&
                    !nsDataFacade.isHaveAlreadySeenFortuneWithIndex(i)
    }
}
