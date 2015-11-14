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
    
    let userDefaults = NSUserDefaults(suiteName:"group.com.tomharman.me.FortuneCookie.userdefaults")
    
    func reset() {
        userDefaults?.setObject(nil, forKey: LAST_FORTUNE_ACCESSED_DATE_KEY)
        userDefaults?.setObject(nil, forKey: SEEN_FORTUNES_LIST_KEY)
    }
    
    func saveFortuneLastAccessedNow() {
        let today = NSDate()
        userDefaults?.setObject(today, forKey: LAST_FORTUNE_ACCESSED_DATE_KEY)
    }
    
    func getFortuneLastAccessedDate() -> NSDate? {
        return (userDefaults?.objectForKey(LAST_FORTUNE_ACCESSED_DATE_KEY)) as? NSDate
    }
    
    func seenFortunesCount() -> Int {
        return getSeenFortunesList().count
    }
    
    func isHaveAlreadySeenFortuneWithIndex(i: Int) -> Bool {
        return getSeenFortunesList().containsObject(i)
    }
    
    func sawFortuneWithIndex(i: Int) {
        let seenFortuneList = getSeenFortunesList()
        seenFortuneList.addObject(i)
        userDefaults?.setObject(seenFortuneList, forKey: SEEN_FORTUNES_LIST_KEY)
    }
    
    func getSeenFortunesList() -> NSMutableArray {
        if let fortunesArray = userDefaults?.objectForKey(SEEN_FORTUNES_LIST_KEY) {
            return fortunesArray.mutableCopy() as! NSMutableArray
        }
        else {
            return NSMutableArray()
        }
    }
}
