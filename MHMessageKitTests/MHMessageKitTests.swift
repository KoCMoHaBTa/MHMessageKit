//
//  MHMessageKitTests.swift
//  MHMessageKitTests
//
//  Created by Milen Halachev on 3/4/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import XCTest
@testable import MHMessageKit

class MHMessageKitTests: XCTestCase {
    
    struct N1: NotificationMessage {}
    class N2: NotificationMessage {}
    class N3: N2 {}
    
    class S1: NotificationMessage, Message {}
    struct S2: NotificationMessage, Message {}
    class S3: S1 {}
   
    func testNotificationMessageCenter() {
        
        self.performExpectation { (expectation) in
            
            let n1 = NotificationCenter.default.addObserver { (n: N1) in
                
                expectation.fulfill()
            }
            
            let n2 = NotificationCenter.default.addWeakObserver { (n: N2) in
                
                XCTFail()
            }
            
            let n3 = NotificationCenter.default.addObserver { (n: N3) in
                
                XCTFail()
            }
        
            NotificationCenter.default.post(N1())
            
            NotificationCenter.default.removeObserver(n1)
            print(n2)
            NotificationCenter.default.removeObserver(n3)
        }
        
        self.performExpectation { (expectation) in
            
            let n1 = NotificationCenter.default.addObserver { (n: N1) in
                
                XCTFail()
            }
            
            let n2 = NotificationCenter.default.addWeakObserver { (n: N2) in
                
                expectation.fulfill()
            }
            
            let n3 = NotificationCenter.default.addWeakObserver { (n: N3) in
                
                XCTFail()
            }
            
            NotificationCenter.default.post(N2())
            
            NotificationCenter.default.removeObserver(n1)
            print(n2)
            print(n3)
        }
        
        self.performExpectation { (expectation) in
            
            let n1 = NotificationCenter.default.addWeakObserver { (n: N1) in
                
                XCTFail()
            }
            
            let n2 = NotificationCenter.default.addWeakObserver { (n: N2) in
                
                XCTFail()
            }
            
            let n3 = NotificationCenter.default.addWeakObserver { (n: N3) in
                
                expectation.fulfill()
            }
            
            NotificationCenter.default.post(N3())
            
            print(n1)
            print(n2)
            print(n3)
        }
    }
    
    func testNotificationMessageQueue() {
        
        self.performExpectation { (expectation) in
            
            expectation.add(conditions: [N1.notificationName(), N2.notificationName(), N3.notificationName()])
            
            let n1 = NotificationCenter.default.addObserver { (n: N1) in
                
                expectation.fulfill(condition: type(of: n).notificationName())
            }
            
            let n2 = NotificationCenter.default.addWeakObserver { (n: N2) in
                
                expectation.fulfill(condition: type(of: n).notificationName())
            }
            
            let n3 = NotificationCenter.default.addObserver { (n: N3) in
                
                expectation.fulfill(condition: type(of: n).notificationName())
            }
            
            NotificationQueue.default.enqueue(N1(), sender: nil, postingStyle: .now)
            NotificationQueue.default.enqueue(N2(), sender: nil, postingStyle: .now)
            NotificationQueue.default.enqueue(N3(), sender: nil, postingStyle: .now)
            
            NotificationCenter.default.removeObserver(n1)
            print(n2)
            NotificationCenter.default.removeObserver(n3)
        }
    }
    
    func testDynamicTypeObservers() {
        
        self.performExpectation { (expectation) in
            
            expectation.add(conditions: [N1.notificationName(), N3.notificationName()])
            
            let n1 = NotificationCenter.default.addObserver(messageType: N1.self) { (n) in
                
                expectation.fulfill(condition: type(of: n).notificationName())
            }
            
            let n2 = NotificationCenter.default.addWeakObserver(messageType: N2.self) { (n) in
                
                XCTFail()
            }
            
            let n3 = NotificationCenter.default.addObserver(messageType: N3.self) { (n) in
                
                expectation.fulfill(condition: type(of: n).notificationName())
            }
            
            NotificationQueue.default.enqueue(N1(), sender: nil, postingStyle: .now)
            NotificationQueue.default.enqueue(N3(), sender: nil, postingStyle: .now)
            
            NotificationCenter.default.removeObserver(n1)
            print(n2)
            NotificationCenter.default.removeObserver(n3)
        }
    }
    
    func testNotificationMessageNameUniqueness() {
        
        XCTAssertNotEqual(N1.notificationName(), N2.notificationName())
        XCTAssertNotEqual(N2.notificationName(), N3.notificationName())
    }
    
    func testNotificationMessageCreation() {
        
        let message = N1()
        let object: AnyObject? = 5 as AnyObject
        let notification = Notification(message: message, object: object)
        
        XCTAssertNotNil(notification.message)
        XCTAssertTrue(notification.message is N1)
        XCTAssertEqual(notification.name.rawValue, type(of: message).notificationName())
        
        XCTAssertNotNil(notification.object)
    }
    
    func testSubscrptions() {
        
        self.performExpectation { (expectation) in
            
            expectation.add(conditions: [S1.notificationName(), S3.notificationName()])
            
            let s1: MessageSubscription = NotificationCenter.default.subscribe({ (s: S1) in
                
                expectation.fulfill(condition: type(of: s).notificationName())
            })
            
            let s2: MessageSubscription = NotificationCenter.default.subscribe({ (s: S2) in
                
                XCTFail()
            })
            
            let s3: MessageSubscription = NotificationCenter.default.subscribe({ (s: S3) in
                
                expectation.fulfill(condition: type(of: s).notificationName())
            })
            
            NotificationCenter.default.publish(S1())
            NotificationCenter.default.publish(S3())
            
            NotificationCenter.default.unsubscribe(from: s1)
            print(s2)
            NotificationCenter.default.unsubscribe(from: s3)
        }
    }
}
