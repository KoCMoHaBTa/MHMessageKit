//
//  NSNotification+NSNotificationMessage.swift
//  MHMessageKit
//
//  Created by Milen Halachev on 1/15/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

public extension NSNotification {
    
    private struct UserInfoKey {
        
        private static let Message = "NSNotification.UserInfoKey.Message"
    }
    
    public var message: NSNotificationMessage? {
        
        return self.userInfo?[NSNotification.UserInfoKey.Message] as? NSNotificationMessage
    }
    
    public convenience init(message: NSNotificationMessage, object: AnyObject? = nil) {
        
        let name = message.dynamicType.notificationName()
        
        var userInfo = [NSObject: AnyObject]()
        userInfo[NSNotification.UserInfoKey.Message] = message
        
        self.init(name: name, object: object, userInfo: userInfo)
    }
    
//    ///A Generic method that tries to create and return a NSNotificationMessage instance from the current NSNotification object
//    public func message<M where M: NSNotificationMessage>() -> M? {
//        
//        return self.message(M) as? M
//    }
//    
//    ///A Generic method that tries to create and return a NSNotificationMessage instance of a provided type from the current NSNotification object
//    public func message(type: NSNotificationMessage.Type) -> NSNotificationMessage? {
//        
//        return type.init()
//    }
}