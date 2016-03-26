//
//  NSNotificationCenter+WeakObserver.h
//  QuickOrders
//
//  Created by Milen Halachev on 6/21/15.
//  Copyright (c) 2015 Milen Halachev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (WeakObserver)

-(void)addWeakObserver:(nonnull id)observer selector:(nonnull SEL)aSelector name:(nullable NSString *)aName object:(nullable id)anObject;
- (nonnull id<NSObject>)addWeakObserverForName:(nullable NSString *)name object:(nullable id)obj queue:(nullable NSOperationQueue *)queue usingBlock:(nonnull void (^)(NSNotification * _Nonnull note))block NS_AVAILABLE(10_6, 4_0);

@end
