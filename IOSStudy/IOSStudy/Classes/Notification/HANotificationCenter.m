//
//  HANotificationCenter.m
//  IOSStudy
//
//  Created by haiwang on 14-12-3.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HANotificationCenter.h"

@interface HANotificationCenter ()

@property (nonatomic, retain) NSMutableArray *observerArray;

@end

@implementation HANotificationCenter

- (void)dealloc
{
    [_observerArray release];
    [super dealloc];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _observerArray = [[NSMutableArray array] retain];
    }
    return self;
}

+ (HANotificationCenter *)defaultCenter
{
    static HANotificationCenter *defaultCenter;
    static dispatch_once_t onceQueue;
    dispatch_once(&onceQueue, ^{
        defaultCenter = [[HANotificationCenter alloc] init];
    });
    return defaultCenter;
}

- (void)addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject
{
//    BOOL isExist = NO;
//    for (HAObserver *observerObj in _observerArray) {
//        if (observerObj.target == observer) {
//            isExist = YES;
//            break;
//        }
//    }
//    if (isExist) {
//        
//    }
    HAObserver *observerObj = [[[HAObserver alloc] init] autorelease];
    observerObj.target = observer;
    observerObj.selector = aSelector;
    observerObj.object = anObject;
    observerObj.notifiName = aName;
    [_observerArray addObject:observerObj];
}

- (void)postNotificationName:(NSString *)aName object:(id)anObject
{
    for (HAObserver *observerObj in _observerArray) {
        if ([observerObj.notifiName isEqualToString:aName]) {
            [observerObj.target performSelector:observerObj.selector withObject:anObject];
//            objc_msgSend(observerObj.target,observerObj.selector);
        }
    }
}

- (void)removeObserver:(id)observer
{
    HAObserver *targetObserver;
    for (HAObserver *observerObj in _observerArray) {
        if (observerObj.target == observer) {
            targetObserver = observerObj;
        }
    }
    [_observerArray removeObject:targetObserver];
}

- (void)removeObserver:(id)observer name:(NSString *)aName object:(id)anObject
{
    
}



@end

@implementation HAObserver

- (void)dealloc
{
    [_object release];
    [_notifiName release];
    [super dealloc];
}

- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

@end
