//
//  MessageSubscriber.swift
//  MHMessageKit
//
//  Created by Milen Halachev on 1/15/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

///A type that manage message subscriptions.
public protocol MessageSubscriber {
    
    /**
     Subscribes for messages of generic type M with a given handler. You must unsubscribe the returned subscription when you are done.
    
     - parameter handler: The handler to be executed when the message is received.
     - returns: A message subscription.
     */
    
    func subscribe<M>(_ handler: @escaping (_ message: M) -> Void) -> MessageSubscription
    where M: Message
    
    /**
     Subscribes for messages of generic type M with a given handler. The returned subscription unsubscibe itself automatically upon deallocation.
     
     - parameter handler: The handler to be executed when the message is received.
     - returns: A message subscription that unsubscibe itself automatically upon deallocation.
     */
    func subscribe<M>(_ handler: @escaping  (_ message: M) -> Void) -> WeakMessageSubscription
    where M: Message
    
    ///Unsubscribe from a subscirption
    func unsubscribe(from subscription: MessageSubscription)
    
    ///Register a static handler with a given input
    func register<H, I>(_ handler: H.Type, input: I)
    where H: StaticMessageHandler, I == H.RegistrationInput
    
    ///Unregister a static handler
    func unregister<H>(_ handler: H.Type)
    where H: StaticMessageHandler
}

public extension MessageSubscriber {
    
    func register<H, I>(_ handler: H.Type, input: I)
    where H: StaticMessageHandler, I == H.RegistrationInput {
        
        handler.registerSubscriptions(from: self, input: input)
    }
    
    func unregister<H>(_ handler: H.Type)
    where H: StaticMessageHandler {
        
        handler.unregisterSubscriptions(from: self)
    }
}

public extension MessageSubscriber {
    
    func register<H>(_ handler: H.Type)
    where H: StaticMessageHandler, H.RegistrationInput == Void {
        
        self.register(handler, input: ())
    }
}
