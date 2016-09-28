//
//  NSNotificationCenter+MessageSubscriber.swift
//  MHMessageKit
//
//  Created by Milen Halachev on 1/15/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

extension NotificationCenter: MessageSubscriber {
    
    public func subscribe<M>(_ handler: @escaping (_ message: M) -> Void) -> MessageSubscription
    where M : Message {
        
        guard
        let messageType = M.self as? NotificationMessage.Type
        else {
            
            NSException(name: NSExceptionName.internalInconsistencyException, reason: "Only NSNotificationMessage is supported", userInfo: nil).raise()
            return NotificationMessageSubscription(observer: "" as NSObjectProtocol)
        }
        
        let observer = self.addObserver(messageType: messageType, handler: { (message) -> Void in
            
            if let message = message as? M {
                
                handler(message)
                return
            }
            
            NSLog("Unhandled message \(messageType.notificationName()) - \(message)")
        })
        
        return NotificationMessageSubscription(observer: observer)
    }
    
    public func subscribe<M>(_ handler: @escaping (_ message: M) -> Void) -> WeakMessageSubscription
    where M : Message {
        
        guard
        let messageType = M.self as? NotificationMessage.Type
        else {
            
            NSException(name: NSExceptionName.internalInconsistencyException, reason: "Only NSNotificationMessage is supported", userInfo: nil).raise()
            return NotificationWeakMessageSubscription(observer: "" as NSObjectProtocol)
        }
        
        let observer = self.addWeakObserver(messageType: messageType, handler: { (message) -> Void in
            
            if let message = message as? M {
                
                handler(message)
                return
            }
            
            NSLog("Unhandled message \(messageType.notificationName()) - \(message)")
        })
        
        return NotificationWeakMessageSubscription(observer: observer)
    }
    
    public func unsubscribe(from subscription: MessageSubscription) {
        
        guard let subscription = subscription as? NotificationMessageSubscription else {
            
            NSException(name: NSExceptionName.invalidArgumentException, reason: "Only subscriptions created by NSNotificationCenter are supported", userInfo: nil).raise()
            return
        }
        
        self.removeObserver(subscription.observer)
    }
}
