//
//  MessageHandler.swift
//  MHMessageKit
//
//  Created by Milen Halachev on 1/15/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

public protocol StaticMessageHandler {
    
    associatedtype RegistrationInput
        
    static func registerSubscriptions<S>(from subscriber: S, input: RegistrationInput)
    where S: MessageSubscriber
    
    static func unregisterSubscriptions<S>(from subscriber: S)
    where S: MessageSubscriber
}

public extension StaticMessageHandler where Self: StaticSubscriptionContainer {
    
    static func unregisterSubscriptions<S>(from subscriber: S) where S: MessageSubscriber {
        
        self.subscriptions.forEach { (s) -> () in
            
            subscriber.unsubscribe(from: s)
        }
        
        self.subscriptions = []
    }
}

public extension StaticMessageHandler where Self: StaticWeakSubscriptionContainer {
    
    static func unregisterSubscriptions<S>(from subscriber: S) where S: MessageSubscriber {
        
        self.weakSubscriptions = []
    }
}

public extension StaticMessageHandler where Self: StaticSubscriptionContainer, Self: StaticWeakSubscriptionContainer {
    
    static func unregisterSubscriptions<S>(from subscriber: S) where S: MessageSubscriber {
        
        self.subscriptions.forEach { (s) -> () in
            
            subscriber.unsubscribe(from: s)
        }
        
        self.subscriptions = []
        self.weakSubscriptions = []
    }
}
