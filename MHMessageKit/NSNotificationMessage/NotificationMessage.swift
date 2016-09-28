//
//  NSNotificationMessage.swift
//  MHMessageKit
//
//  Created by Milen Halachev on 1/15/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

///Adopt this protocol to any type that you want to use as message.
public protocol NotificationMessage {
    
    ///The underlying notification name that will be used by NSNotification, NSNotificationCenter and NSNotificationQueue to transfer the message. The value must be unique per type. There is a default implementation of this method that retrieves the reflecting type name.
    static func notificationName() -> String
}

public extension NotificationMessage {
    
    ///A default implementation of this method that retrieves the reflecting type name.
    public static func notificationName() -> String {
        
        let notificationName = String(reflecting: self)
        return notificationName
    }
}
