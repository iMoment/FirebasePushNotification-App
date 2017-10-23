//
//  NotificationService.swift
//  FirebaseNotificationServiceExtension
//
//  Created by Stanley Pan on 23/10/2017.
//  Copyright © 2017 Stanley Pan. All rights reserved.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    //  MARK: This will get called if our payload contains mutable content, gives us time to modify notification before user sees
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
//            // Modify the notification content here...
//            bestAttemptContent.title = "\(bestAttemptContent.title) [modified]"
            guard let imageUrlString = bestAttemptContent.userInfo["imageUrl"] as? String else {
                contentHandler(request.content)
                return
            }
            
            DownloadService.sharedInstance.getImage(with: imageUrlString, completion: { (url) in
                //  MARK: Create attachment from this url
                do {
                    let attachment = try UNNotificationAttachment(identifier: "image", url: url, options: nil)
                    bestAttemptContent.attachments = [attachment]
                    contentHandler(bestAttemptContent)
                } catch {
                    print(error.localizedDescription)
                    contentHandler(bestAttemptContent)
                }
            })
//            contentHandler(bestAttemptContent)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}
