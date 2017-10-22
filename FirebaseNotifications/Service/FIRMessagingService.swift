//
//  FIRMessagingService.swift
//  FirebaseNotifications
//
//  Created by Stanley Pan on 22/10/2017.
//  Copyright © 2017 Stanley Pan. All rights reserved.
//

import Foundation
import FirebaseMessaging

enum SubscriptionTopic: String {
    case newProducts = "newProducts"
}

class FIRMessagingService {
    
    private init() {}
    static let sharedInstance = FIRMessagingService()
    let messaging = Messaging.messaging()
    
    func subscribe(to topic: SubscriptionTopic) {
        messaging.subscribe(toTopic: topic.rawValue)
    }
    
    func unsubscribe(from topic: SubscriptionTopic) {
        messaging.unsubscribe(fromTopic: topic.rawValue)
    }
}
