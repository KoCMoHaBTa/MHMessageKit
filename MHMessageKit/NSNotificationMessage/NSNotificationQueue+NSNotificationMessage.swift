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
    public func enqueue(_ message: NSNotificationMessage, sender: AnyObject? = nil, postingStyle: NotificationQueue.PostingStyle = .whenIdle) {
        
        let notification = Notification(name: message as! Notification.Name, object: sender)
        self.enqueue(notification, postingStyle: postingStyle)
    }
}
