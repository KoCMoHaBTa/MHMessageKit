//
//  MessagePublisher.swift
//  MHMessageKit
//
//  Created by Milen Halachev on 1/15/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

///A type that can send messages.
public protocol MessagePublisher {
    
    ///Publish a message.
    func publish(_ message: Message)
}
