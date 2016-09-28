//
//  NSNotificationCenter+NSNotificationMessage.swift
//  MHMessageKit
//
//  Created by Milen Halachev on 1/15/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

public extension NotificationCenter {
    
    ///Adds an entry to the receiver’s dispatch table with a message queue and a block handler to add to the queue, and optional criteria: sender.
    public func addObserver<M>(_ sender: AnyObject? = nil, queue: OperationQueue? = nil, handler: @escaping (_ message: M) -> Void) -> NSObjectProtocol
    where M : NotificationMessage {
        
        return self.addObserver(forName: NSNotification.Name(rawValue: M.notificationName()), object: sender, queue: queue, using: { (notification) in
            
            guard
            let message = notification.message as? M
            else {
                
                NSLog("Unhandled notification \(notification)")
                return
            }
            
            handler(message)
        })
    }
    
    ///Adds an entry to the receiver’s dispatch table with a message queue and a block handler to add to the queue for a given message type, and optional criteria: sender.
    public func addObserver(_ sender: AnyObject? = nil, queue: OperationQueue? = nil, messageType: NotificationMessage.Type, handler: @escaping (_ message: NotificationMessage) -> Void) -> NSObjectProtocol {
        
        let observer = self.addObserver(forName: NSNotification.Name(rawValue: messageType.notificationName()), object: sender, queue: queue) { (notification: Notification) -> Void in
            
            guard
            let message = notification.message
            else {
                
                NSLog("Unhandled notification \(notification)")
                return
            }
            
            handler(message)
        }
        
        return observer
    }
}

public extension NotificationCenter {
    
    ///Posts a given message to the receiver.
    public func post(_ message: NotificationMessage, sender: AnyObject? = nil) {
        
        let notification = Notification(message: message, object: sender)
        self.post(notification)
    }
}
