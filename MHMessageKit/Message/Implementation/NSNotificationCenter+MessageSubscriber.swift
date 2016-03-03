//
//  NSNotificationCenter+MessageSubscriber.swift
//  MHMessageKit
//
//  Created by Milen Halachev on 1/15/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

extension NSNotificationCenter: MessageSubscriber {
    
    public func subscribe<M where M : Message>(handler: (message: M) -> Void) -> MessageSubscription {
        
        guard
            let messageType = M.self as? NSNotificationMessage.Type
            else {
                
                NSException(name: NSInternalInconsistencyException, reason: "Only NSNotificationMessage is supported", userInfo: nil).raise()
                return NSNotificationMessageSubscription(observer: "")
        }
        
        let observer = self.addObserver(messageType: messageType, handler: { (message) -> Void in
            
            if let message = message as? M {
                
                handler(message: message)
                return
            }
            
            NSLog("Unhandled message \(messageType.notificationName()) - \(message)")
        })
        
        return NSNotificationMessageSubscription(observer: observer)
    }
    
    public func subscribe<M where M : Message>(handler: (message: M) -> Void) -> WeakMessageSubscription {
        
        guard
            let messageType = M.self as? NSNotificationMessage.Type
            else {
                
                NSException(name: NSInternalInconsistencyException, reason: "Only NSNotificationMessage is supported", userInfo: nil).raise()
                return NSNotificationWeakMessageSubscription(observer: "")
        }
        
        let observer = self.addWeakObserver(messageType: messageType, handler: { (message) -> Void in
            
            if let message = message as? M {
                
                handler(message: message)
                return
            }
            
            NSLog("Unhandled message \(messageType.notificationName()) - \(message)")
        })
        
        return NSNotificationWeakMessageSubscription(observer: observer)
    }
    
    public func unsubscribe(subscription: MessageSubscription) {
        
        guard let subscription = subscription as? NSNotificationMessageSubscription else {
            
            NSException(name: NSInvalidArgumentException, reason: "Only subscriptions created by NSNotificationCenter are supported", userInfo: nil).raise()
            return
        }
        
        self.removeObserver(subscription.observer)
    }
}
