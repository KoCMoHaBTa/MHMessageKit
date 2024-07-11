//
//  NotificationCender+WeakObserver.swift
//  MHMessageKit
//
//  Created by Milen Halachev on 4/10/17.
//  Copyright © 2017 Milen Halachev. All rights reserved.
//

import Foundation

extension NotificationCenter {
    
    public func addWeakObserver(_ observer: Any, selector: Selector, name: NSNotification.Name?, object: Any?) {
        
        let weakObserver = WeakObserver(observer: observer, selector: selector, name: name, object: object)
        weakObserver.associate(with: observer)
    }
    
    public func addWeakObserver(forName name: NSNotification.Name?, object: Any?, queue: OperationQueue?, using block: @escaping (Notification) -> Void) -> NSObjectProtocol {
        
        let observer = self.addObserver(forName: name, object: object, queue: queue, using: block)
        let weakObserver = WeakBlockObserver(observer: observer)
        return weakObserver
    }
}

extension NotificationCenter {
    
    fileprivate class WeakObserver: NSObject {
        
        private unowned let observer: AnyObject
        private let selector: Selector
        private let name: NSNotification.Name?
        private weak var object: AnyObject?
        private var associatedKey: Void?
        
        init(observer: Any, selector: Selector, name: NSNotification.Name?, object: Any?) {
            
            self.observer = observer as AnyObject
            self.selector = selector
            self.name = name
            self.object = object as AnyObject
        }
        
        deinit {
            
            NotificationCenter.default.removeObserver(self)
        }

        @objc dynamic func received(notification: Notification) {
            
            _ = self.observer.perform(self.selector, with: notification)
        }
        
        func associate(with observer: Any) {
            
            objc_setAssociatedObject(observer, &self.associatedKey, self, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}

extension NotificationCenter {
    
    fileprivate class WeakBlockObserver: NSObject {
        
        private let observer: Any
        
        init(observer: Any) {
            
            self.observer = observer
        }
        
        deinit {
            
            NotificationCenter.default.removeObserver(self.observer)
        }
    }
}
