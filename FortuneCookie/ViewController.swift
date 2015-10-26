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

        let firstLocalNotification = UILocalNotification()
//        firstLocalNotification.alertAction = "testing notifications"
        firstLocalNotification.alertBody = "Your Fortune Cookie is here!"
        firstLocalNotification.category = "INVITATION_CATEGORY"
        firstLocalNotification.fireDate = NSDate(timeIntervalSinceNow: 10)
        UIApplication.sharedApplication().scheduleLocalNotification(firstLocalNotification)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

