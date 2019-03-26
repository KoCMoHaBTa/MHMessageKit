//
//  NSNotificationCenter+NotificationMessage+WeakObserver.swift
//  MHMessageKit
//
//  Created by Milen Halachev on 2/5/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

extension NotificationCenter {
    
    /**
     
     Adds an entry to the receiver’s dispatch table with a message queue and a block handler to add to the queue, and optional criteria: sender. The observer is automatically unsubscribed upon deallocation.
     
     - parameter object: See `addObserver(forName:object:queue:using:)` for more information.
     - parameter queue: See `addObserver(forName:object:queue:using:)` for more information.
     - parameter handler: The closure to be executed when the notification is received. The closure receives one argument that is of generic type M.
     
     - returns: An opaque object to act as the observer. Upon deallocation, the object unsubscribes itself automatically.
     */
    public func addWeakObserver<M>(forObject object: AnyObject? = nil, queue: OperationQueue? = nil, handler: @escaping (_ message: M) -> Void) -> NSObjectProtocol where M : NotificationMessage {

        return self.addWeakObserver(forName: M.notificationName(), object: object, queue: queue, using: { (notification) in
            
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
     
     Adds an entry to the receiver’s dispatch table with a message queue and a block handler to add to the queue for a given message type, and optional criteria: message type and sender. The observer is automatically unsubscribed upon deallocation.
     
     - parameter object: See `addObserver(forName:object:queue:using:)` for more information.
     - parameter queue: See `addObserver(forName:object:queue:using:)` for more information.
     - parameter messageType: The message type for which to subscribe.
     - parameter handler: The closure to be executed when the notification is received. The closure receives one argument that is of NotificationMessage type.
     
     - returns: An opaque object to act as the observer. Upon deallocation, the object unsubscribes itself automatically.
     */
    public func addWeakObserver(forObject object: AnyObject? = nil, queue: OperationQueue? = nil, messageType: NotificationMessage.Type, handler: @escaping (_ message: NotificationMessage) -> Void) -> NSObjectProtocol {
        
        let observer = self.addWeakObserver(forName: messageType.notificationName(), object: object, queue: queue) { (notification) -> Void in
            
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
