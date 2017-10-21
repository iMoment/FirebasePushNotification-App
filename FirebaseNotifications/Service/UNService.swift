//
//  UNService.swift
//  FirebaseNotifications
//
//  Created by Stanley Pan on 21/10/2017.
//  Copyright © 2017 Stanley Pan. All rights reserved.
//

import UIKit
import UserNotifications

class UNService: NSObject {
    
    private override init() {}
    let unCenter = UNUserNotificationCenter.current()
    
    static let sharedInstance = UNService()
    
    func authorize() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        unCenter.requestAuthorization(options: options) { (granted, error) in
            print(error ?? "No UN Authorization Error.")
            guard granted else { return }
            DispatchQueue.main.async {
                self.configure()
            }
        }
    }
    
    func configure() {
        unCenter.delegate = self
        
        let application = UIApplication.shared
        application.registerForRemoteNotifications()
    }
}

extension UNService: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("UN did receive")
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("UN will present.")
        
        let options: UNNotificationPresentationOptions = [.alert, .sound]
        completionHandler(options)
    }
}








