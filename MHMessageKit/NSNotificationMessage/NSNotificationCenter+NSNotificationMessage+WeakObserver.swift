//
//  NSNotificationCenter+NSNotificationMessage+WeakObserver.swift
//  MHMessageKit
//
//  Created by Milen Halachev on 2/5/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

public extension NSNotificationCenter {
    
    ///Adds an entry to the receiver’s dispatch table with a message queue and a block handler to add to the queue, and optional criteria: sender.
    public func addWeakObserver<M where M : NSNotificationMessage>(sender: AnyObject? = nil, queue: NSOperationQueue? = nil, handler: (message: M) -> Void) -> NSObjectProtocol {
        
        return self.addWeakObserver(sender, queue: queue, messageType: M.self, handler: { (message) -> Void in
            
            if let message = message as? M {
                
                handler(message: message)
                return
            }
            
            NSLog("Unhandled message \(M.notificationName()) - \(message)")
        })
    }
    
    ///Adds an entry to the receiver’s dispatch table with a message queue and a block handler to add to the queue for a given message type, and optional criteria: sender.
    public func addWeakObserver(sender: AnyObject? = nil, queue: NSOperationQueue? = nil, messageType: NSNotificationMessage.Type, handler: (message: NSNotificationMessage) -> Void) -> NSObjectProtocol {
        
        let observer = self.addWeakObserverForName(messageType.notificationName(), object: nil, queue: nil) { (notification) -> Void in
            
            guard
                let message = notification.message
                else {
                    
                    NSLog("Unhandled notification \(notification)")
                    return
            }
            
            handler(message: message)
        }
        
        return observer
    }
}
