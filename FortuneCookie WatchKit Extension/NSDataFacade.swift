//
//  NSDataFacade.swift
//  FortuneCookie
//
//  Created by Thomas Harman on 11/13/15.
//  Copyright © 2015 Toms Apps. All rights reserved.
//

import WatchKit

class NSDataFacade: NSObject {

    let SEEN_FORTUNES_LIST_KEY = "seenFortunesList"
    let LAST_FORTUNE_ACCESSED_DATE_KEY = "lastFortuneAccessedDate"
    
    let userDefaults = UserDefaults(suiteName:"group.com.tomharman.me.FortuneCookie.userdefaults")
    
    func reset() {
        userDefaults?.set(nil, forKey: LAST_FORTUNE_ACCESSED_DATE_KEY)
        userDefaults?.set(nil, forKey: SEEN_FORTUNES_LIST_KEY)
    }
    
    func saveFortuneLastAccessedNow() {
        let today = Date()
        userDefaults?.set(today, forKey: LAST_FORTUNE_ACCESSED_DATE_KEY)
    }
    
    func getFortuneLastAccessedDate() -> Date? {
        return (userDefaults?.object(forKey: LAST_FORTUNE_ACCESSED_DATE_KEY)) as? Date
    }
    
    func lastShownFortuneIndex() -> Int {
        let lastFortuneShownIndex = getSeenFortunesList().count - 1
        return getSeenFortunesList()[lastFortuneShownIndex] as! Int
    }

    func seenFortunesCount() -> Int {
        return getSeenFortunesList().count
    }
    
    func isHaveAlreadySeenFortuneWithIndex(index: Int) -> Bool {
        return getSeenFortunesList().contains(index)
    }
    
    func sawFortuneWithIndex(index: Int) {
        let seenFortuneList = getSeenFortunesList()
        seenFortuneList.add(index)
        userDefaults?.setValue(seenFortuneList.copy(), forKey: SEEN_FORTUNES_LIST_KEY)
        userDefaults?.synchronize()
    }
    
    func getSeenFortunesList() -> NSMutableArray {
        if let fortunesArray = userDefaults?.mutableArrayValue(forKey: SEEN_FORTUNES_LIST_KEY) {
            return fortunesArray
        }
        else {
            return NSMutableArray()
        }
    }
}
