//
//  NSNotificationQueueNSNotificationMessage.swift
//  MHMessageKit
//
//  Created by Milen Halachev on 1/15/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

public extension NotificationQueue {
    
    ///Adds a message to the notification queue with a specified sender and  posting style.
    public func enqueue(_ message: NotificationMessage, sender: AnyObject? = nil, postingStyle: NotificationQueue.PostingStyle = .whenIdle) {
        
        let notification = Notification(message: message, object: sender)
        self.enqueue(notification, postingStyle: postingStyle)
    }
}
