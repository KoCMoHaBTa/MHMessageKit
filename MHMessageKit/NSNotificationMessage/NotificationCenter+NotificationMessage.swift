//
//  NSNotificationCenter+NotificationMessage.swift
//  MHMessageKit
//
//  Created by Milen Halachev on 1/15/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

extension NotificationCenter {
    
    /**
     
     Adds an entry to the receiver’s dispatch table with a message queue and a block handler to add to the queue, and optional criteria: sender.
     
     - parameter object: See `addObserver(forName:object:queue:using:)` for more information.
     - parameter queue: See `addObserver(forName:object:queue:using:)` for more information.
     - parameter handler: The closure to be executed when the notification is received. The closure receives one argument that is of generic type M.
     
     - returns: An opaque object to act as the observer.
     */
    
    public func addObserver<M>(forObject object: AnyObject? = nil, queue: OperationQueue? = nil, handler: @escaping (_ message: M) -> Void) -> NSObjectProtocol
    where M : NotificationMessage {
        
        return self.addObserver(forName: M.notificationName(), object: object, queue: queue, using: { (notification) in
            
            guard
            let message = notification.message as? M
            else {
                
                NSLog("Unhandled notification \(notification)")
                return
            }
            
            handler(message)
        })
    }
    
    /**
     
     Adds an entry to the receiver’s dispatch table with a message queue and a block handler to add to the queue for a given message type, and optional criteria: message type and sender.
     
     - parameter object: See `addObserver(forName:object:queue:using:)` for more information.
     - parameter queue: See `addObserver(forName:object:queue:using:)` for more information.
     - parameter messageType: The message type for which to subscribe.
     - parameter handler: The closure to be executed when the notification is received. The closure receives one argument that is of NotificationMessage type.
     
     - returns: An opaque object to act as the observer.
     */
    
    public func addObserver(forObject object: AnyObject? = nil, queue: OperationQueue? = nil, messageType: NotificationMessage.Type, handler: @escaping (_ message: NotificationMessage) -> Void) -> NSObjectProtocol {
        
        let observer = self.addObserver(forName: messageType.notificationName(), object: object, queue: queue) { (notification: Notification) -> Void in
            
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

extension NotificationCenter {
    
    /**
     Posts a given message to the receiver.
     
     - parameter message: The message to be send.
     - parameter object: The object for the notification.
     
     */
    
    public func post(_ message: NotificationMessage, object: AnyObject? = nil) {
        
        let notification = Notification(message: message, object: object)
        self.post(notification)
    }
}
