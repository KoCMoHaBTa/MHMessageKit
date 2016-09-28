//
//  MessageSubscriber.swift
//  MHMessageKit
//
//  Created by Milen Halachev on 1/15/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

public protocol MessageSubscriber {
    
    func subscribe<M>(_ handler: @escaping (_ message: M) -> Void) -> MessageSubscription
    where M: Message
    
    func subscribe<M>(_ handler: @escaping  (_ message: M) -> Void) -> WeakMessageSubscription
    where M: Message
    
    func unsubscribe(from subscription: MessageSubscription)
    
    func register<H, I>(_ handler: H.Type, input: I)
    where H: StaticMessageHandler, I == H.RegistrationInput
    
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
