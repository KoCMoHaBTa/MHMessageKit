//
//  NSNotificationCenter+NSNotificationMessage+WeakObserver.swift
//  MHMessageKit
//
//  Created by Milen Halachev on 2/5/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

public extension NotificationCenter {
    
    ///Adds an entry to the receiver’s dispatch table with a message queue and a block handler to add to the queue, and optional criteria: sender.
    public func addWeakObserver<M>(_ sender: AnyObject? = nil, queue: OperationQueue? = nil, handler: @escaping (_ message: M) -> Void) -> NSObjectProtocol where M : NotificationMessage {

        return self.addWeakObserver(forName: M.notificationName(), object: sender, queue: queue, using: { (notification) in
            
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
    public func addWeakObserver(_ sender: AnyObject? = nil, queue: OperationQueue? = nil, messageType: NotificationMessage.Type, handler: @escaping (_ message: NotificationMessage) -> Void) -> NSObjectProtocol {
        
        let observer = self.addWeakObserver(forName: messageType.notificationName(), object: sender, queue: queue) { (notification) -> Void in
            
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
