//
//  MessageHandler.swift
//  MHMessageKit
//
//  Created by Milen Halachev on 1/15/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

///A type that statically register and unregister subscriptions.
///If the type also conforms to StaticSubscriptionContainer and/or StaticWeakSubscriptionContainer - there is default implementation for the required methods
public protocol StaticMessageHandler {
    
    associatedtype RegistrationInput
    
    ///Perform subscription registration for a given subscriber and input
    static func registerSubscriptions<S>(from subscriber: S, input: RegistrationInput)
    where S: MessageSubscriber
    
    ///Perform subscription unregistration for a given subscriber
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
