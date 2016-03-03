//
//  NSNotificationMessageSubscription.swift
//  MHMessageKit
//
//  Created by Milen Halachev on 1/15/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

struct NSNotificationMessageSubscription: MessageSubscription {
    
    let observer: NSObjectProtocol
    
    init(observer: NSObjectProtocol) {
        
        self.observer = observer
    }
}

struct NSNotificationWeakMessageSubscription: WeakMessageSubscription {
    
    let observer: NSObjectProtocol
    
    init(observer: NSObjectProtocol) {
        
        self.observer = observer
    }
}