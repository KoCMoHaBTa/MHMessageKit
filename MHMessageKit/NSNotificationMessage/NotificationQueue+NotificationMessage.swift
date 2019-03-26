//
//  NSNotificationQueue+NotificationMessage.swift
//  MHMessageKit
//
//  Created by Milen Halachev on 1/15/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

extension NotificationQueue {
    
    /**
     Adds a message to the notification queue with a specified sender and  posting style.
     
     - parameter message: The message to be send.
     - parameter object: The object for the notification.
     */
    public func enqueue(_ message: NotificationMessage, object: AnyObject? = nil, postingStyle: NotificationQueue.PostingStyle = .whenIdle) {
        
        let notification = Notification(message: message, object: object)
        self.enqueue(notification, postingStyle: postingStyle)
    }
}
