//
//  NSNotification+NotificationMessage.swift
//  MHMessageKit
//
//  Created by Milen Halachev on 1/15/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

public extension Notification {
    
    private struct UserInfoKey {
        
        static let message = "NSNotification.UserInfoKey.message"
    }
    
    ///The message transported by the Notification
    public var message: NotificationMessage? {
        
        return self.userInfo?[Notification.UserInfoKey.message] as? NotificationMessage
    }
    
    ///Creates an isntance of the receiver with a message and object
    ///- parameter message: The message to transport.
    ///- parameter object: The object for the new notification.
    public init(message: NotificationMessage, object: AnyObject? = nil) {
        
        let name = type(of: message).notificationName()
        let userInfo = [Notification.UserInfoKey.message: message]
        
        self.init(name: name, object: object, userInfo: userInfo)
    }
}
