//
//  MessageSubscriber.swift
//  MHMessageKit
//
//  Created by Milen Halachev on 1/15/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

public protocol MessageSubscriber {
    
    func subscribe<M where M: Message>(handler: (message: M) -> Void) -> MessageSubscription
    func subscribe<M where M: Message>(handler: (message: M) -> Void) -> WeakMessageSubscription
    func unsubscribe(subscription: MessageSubscription)
    
    func registerHandler<H, I where H: StaticMessageHandler, I == H.RegistrationInput>(handler: H.Type, input: I)
    func unregisterHandler<H where H: StaticMessageHandler>(handler: H.Type)
}

public extension MessageSubscriber {
    
    func registerHandler<H, I where H: StaticMessageHandler, I == H.RegistrationInput>(handler: H.Type, input: I) {
        
        handler.registerSubscriptions(self, input: input)
    }
    
    func unregisterHandler<H where H: StaticMessageHandler>(handler: H.Type) {
        
        handler.unregisterSubscriptions(self)
    }
}

public extension MessageSubscriber {
    
    func registerHandler<H where H: StaticMessageHandler, H.RegistrationInput == Void>(handler: H.Type) {
        
        self.registerHandler(handler, input: ())
    }
}