//
//  NSNotificationQueueNSNotificationMessage.swift
//  MHMessageKit
//
//  Created by Milen Halachev on 1/15/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

public extension NSNotificationQueue {
    
    ///Adds a message to the notification queue with a specified sender and  posting style.
    public func enqueueMessage(message: NSNotificationMessage, sender: AnyObject? = nil, postingStyle: NSPostingStyle = .PostWhenIdle) {
        
        let notification = NSNotification(message: message, object: sender)
        self.enqueueNotification(notification, postingStyle: postingStyle)
    }
}