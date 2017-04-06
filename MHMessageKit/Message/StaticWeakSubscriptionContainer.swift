//
//  StaticWeakSubscriptionContainer.swift
//  MHMessageKit
//
//  Created by Milen Halachev on 2/10/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

///A type that stores weak subscriptions statically
public protocol StaticWeakSubscriptionContainer {
    
    static var weakSubscriptions: [WeakMessageSubscription] {get set}
}
