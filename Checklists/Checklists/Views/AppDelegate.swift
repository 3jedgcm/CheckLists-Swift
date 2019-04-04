//
//  AppDelegate.swift
//  Checklists
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 Clément MERLET. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound])
        { (granted, error) in

        }
     
        let content = UNMutableNotificationContent()
        content.title = "Weekly Staff Meeting"
        content.body = "Every Tuesday at 2pm"
        // Configure the recurring date.
        var dateComponents = DateComponents()
        dateComponents = Calendar.current.dateComponents([.hour,.minute,.second],from:Date(timeIntervalSinceNow: 10))
      
  
        
 
 
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents, repeats: true)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content, trigger: trigger)
        
        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if error != nil {
                // Handle any errors.
            }
        }
        
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        DataSingleton.sharedInstance.save()
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }


    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

