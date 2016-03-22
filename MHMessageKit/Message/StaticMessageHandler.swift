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
        
    static func registerSubscriptions<S where S: MessageSubscriber>(subscriber: S, input: RegistrationInput)
    static func unregisterSubscriptions<S where S: MessageSubscriber>(subscriber: S)
}

public extension StaticMessageHandler where Self: StaticSubscriptionContainer {
    
    static func unregisterSubscriptions<S where S: MessageSubscriber>(subscriber: S) {
        
        self.subscriptions.forEach { (s) -> () in
            
            subscriber.unsubscribe(s)
        }
        
        self.subscriptions = []
    }
}

public extension StaticMessageHandler where Self: StaticWeakSubscriptionContainer {
    
    static func unregisterSubscriptions<S where S: MessageSubscriber>(subscriber: S) {
        
        self.weakSubscriptions = []
    }
}

public extension StaticMessageHandler where Self: StaticSubscriptionContainer, Self: StaticWeakSubscriptionContainer {
    
    static func unregisterSubscriptions<S where S: MessageSubscriber>(subscriber: S) {
        
        self.subscriptions.forEach { (s) -> () in
            
            subscriber.unsubscribe(s)
        }
        
        self.subscriptions = []
        
        self.weakSubscriptions = []
    }
}