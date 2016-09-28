//
//  NSNotificationQueue+MessagePublisher.swift
//  MHMessageKit
//
//  Created by Milen Halachev on 1/15/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

extension NotificationQueue: MessagePublisher {
    
    public func publish(_ message: Message) {
        
        guard
        let message = message as? NotificationMessage
        else {
            
            NSException(name: NSExceptionName.internalInconsistencyException, reason: "Only NSNotificationMessage is supported", userInfo: nil).raise()
            return
        }
        
        self.enqueue(message)
    }
}
