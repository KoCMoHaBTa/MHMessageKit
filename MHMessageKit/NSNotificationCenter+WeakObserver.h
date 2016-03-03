//
//  NSNotificationCenter+WeakObserver.h
//  QuickOrders
//
//  Created by Milen Halachev on 6/21/15.
//  Copyright (c) 2015 Milen Halachev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (WeakObserver)

-(void)addWeakObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject;
- (id<NSObject>)addWeakObserverForName:(NSString *)name object:(id)obj queue:(NSOperationQueue *)queue usingBlock:(void (^)(NSNotification *note))block NS_AVAILABLE(10_6, 4_0);

@end
