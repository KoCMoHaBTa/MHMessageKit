//
//  NSNotificationMessageSubscription.swift
//  MHMessageKit
//
//  Created by Milen Halachev on 1/15/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

struct NotificationMessageSubscription: MessageSubscription {
    
    let observer: NSObjectProtocol
    
    init(observer: NSObjectProtocol) {
        
        self.observer = observer
    }
}

struct NotificationWeakMessageSubscription: WeakMessageSubscription {
    
    //automatic unsubscribe upon deallocation is handled trough the sbuscription process, using a weak observer
    let observer: NSObjectProtocol
    
    init(observer: NSObjectProtocol) {
        
        self.observer = observer
    }
}
