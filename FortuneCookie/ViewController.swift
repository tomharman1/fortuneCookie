//
//  ViewController.swift
//  FortuneCookie
//
//  Created by Thomas Harman on 9/13/15.
//  Copyright © 2015 Toms Apps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let dateComponent = NSDateComponents()
        dateComponent.hour = 12
        dateComponent.minute = 30
        let lunchTime = NSCalendar.currentCalendar().dateFromComponents(dateComponent)
        
        let firstLocalNotification = UILocalNotification()
//        firstLocalNotification.alertAction = "testing notifications"
        firstLocalNotification.alertBody = "Your Fortune is here!"
        firstLocalNotification.category = "NEW_COOKIE_CATEGORY"
        firstLocalNotification.repeatInterval = NSCalendarUnit.Day
        firstLocalNotification.fireDate = lunchTime
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        UIApplication.sharedApplication().scheduleLocalNotification(firstLocalNotification)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

