//
//  AppDelegate.swift
//  FortuneCookie
//
//  Created by Thomas Harman on 9/13/15.
//  Copyright © 2015 Toms Apps. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        registerNotificationSettings()
        scheduleDailyFortuneNotification()
        
        return true
    }
    
    func scheduleDailyFortuneNotification() {
        var dateComponent = DateComponents()
        dateComponent.hour = 12
        dateComponent.minute = 30
        let lunchTime = Calendar.current.date(from: dateComponent)
        
        let firstLocalNotification = UILocalNotification()
        firstLocalNotification.alertBody = "Your Fortune is here!"
        firstLocalNotification.category = "NEW_COOKIE_CATEGORY"
        firstLocalNotification.repeatInterval = NSCalendar.Unit.day
        firstLocalNotification.fireDate = lunchTime
        UIApplication.shared.cancelAllLocalNotifications()
        UIApplication.shared.scheduleLocalNotification(firstLocalNotification)
    }
    
    func registerNotificationSettings() {
        // see: https://developer.apple.com/library/prerelease/ios/documentation/General/Conceptual/WatchKitProgrammingGuide/BasicSupport.html#//apple_ref/doc/uid/TP40014969-CH18-SW1

        var categories = Set<UIUserNotificationCategory>()
        
        let acceptAction = UIMutableUserNotificationAction()
        acceptAction.title = NSLocalizedString("Open", comment: "Open Cookie")
        acceptAction.identifier = "open"
        acceptAction.activationMode = UIUserNotificationActivationMode.foreground
        acceptAction.isAuthenticationRequired = false
  
        let category = UIMutableUserNotificationCategory()
        category.setActions([acceptAction], for: UIUserNotificationActionContext.default)
        category.setActions([acceptAction], for: UIUserNotificationActionContext.minimal)
        category.identifier = "NEW_COOKIE_CATEGORY"
        categories.insert(category)
        
        let settings = UIUserNotificationSettings(types: UIUserNotificationType.alert, categories: categories)
        
        UIApplication.shared.registerUserNotificationSettings(settings)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

