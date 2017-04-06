//
//  SubscriptionContainer.swift
//  MHMessageKit
//
//  Created by Milen Halachev on 2/10/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

///A type that stores subscriptions statically
public protocol StaticSubscriptionContainer {
    
    static var subscriptions: [MessageSubscription] {get set}
}
