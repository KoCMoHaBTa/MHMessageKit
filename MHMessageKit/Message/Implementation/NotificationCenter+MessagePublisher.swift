//
//  NSNotificationCenter+MessagePublisher.swift
//  MHMessageKit
//
//  Created by Milen Halachev on 3/21/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

extension NotificationCenter: MessagePublisher {
    
    public func publish(_ message: Message) {
        
        guard
        let message = message as? NotificationMessage
        else {
            
            NSException(name: NSExceptionName.internalInconsistencyException, reason: "Only NSNotificationMessage is supported", userInfo: nil).raise()
            return
        }
        
        self.post(message)
    }
}
