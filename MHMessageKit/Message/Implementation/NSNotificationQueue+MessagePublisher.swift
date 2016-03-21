//
//  NSNotificationQueue+MessagePublisher.swift
//  MHMessageKit
//
//  Created by Milen Halachev on 1/15/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

extension NSNotificationQueue: MessagePublisher {
    
    public func publishMessage(message: Message) {
        
        guard
            let message = message as? NSNotificationMessage
            else {
                
                NSException(name: NSInternalInconsistencyException, reason: "Only NSNotificationMessage is supported", userInfo: nil).raise()
                return
        }
        
        self.enqueueMessage(message)
    }
}