//
//  NSNotificationCenter+WeakObserver.m
//  QuickOrders
//
//  Created by Milen Halachev on 6/21/15.
//  Copyright (c) 2015 Milen Halachev. All rights reserved.
//

#import "NSNotificationCenter+WeakObserver.h"
#import <objc/runtime.h>

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface NSNotificationCenterWeakObserver : NSObject

@property(weak) id observer;
@property(assign) SEL selector;
@property(copy) NSString *name;
@property(weak) id object;

-(instancetype)initWithObserver:(id)observer selector:(SEL)selector name:(NSString *)name object:(id)object;
-(void)receivedNotification:(NSNotification*)notification;
-(void)associateWithObserver:(id)observer;

@end

@implementation NSNotificationCenterWeakObserver {
    
    char _associatedKey;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(instancetype)initWithObserver:(id)observer selector:(SEL)selector name:(NSString *)name object:(id)object
{
    self = [super init];
    if (self) {
        
        _observer = observer;
        _selector = selector;
        _name = [name copy];
        _object = object;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotification:) name:name object:object];
    }
    return self;
}

-(void)receivedNotification:(NSNotification *)notification {
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self.observer performSelector:self.selector withObject:notification];
#pragma clang diagnostic pop
}

-(void)associateWithObserver:(id)observer {
    
    objc_setAssociatedObject(observer, &_associatedKey, self, OBJC_ASSOCIATION_RETAIN);
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface NSNotificationCenterWeakBlockObserver : NSObject

@property(strong) id<NSObject> observer;

-(instancetype)initWithObserver:(id)observer;

@end

@implementation NSNotificationCenterWeakBlockObserver

-(instancetype)initWithObserver:(id)observer {
    
    self = [super init];
    if (self) {
        
        self.observer = observer;
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self.observer];
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@implementation NSNotificationCenter (WeakObserver)

-(void)addWeakObserver:(id)observer selector:(SEL)selector name:(NSString *)name object:(id)object {
    
    NSNotificationCenterWeakObserver *weakObserver = [[NSNotificationCenterWeakObserver alloc] initWithObserver:observer selector:selector name:name object:object];
    [weakObserver associateWithObserver:observer];
}

-(id<NSObject>)addWeakObserverForName:(NSString *)name object:(id)obj queue:(NSOperationQueue *)queue usingBlock:(void (^)(NSNotification *))block {
    
    id<NSObject> observer = [self addObserverForName:name object:obj queue:queue usingBlock:block];
    
    NSNotificationCenterWeakBlockObserver *weakObserver = [[NSNotificationCenterWeakBlockObserver alloc] initWithObserver:observer];
    return weakObserver;
}

@end
