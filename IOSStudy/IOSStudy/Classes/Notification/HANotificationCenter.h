//
//  HANotificationCenter.h
//  IOSStudy
//
//  Created by haiwang on 14-12-3.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 模拟通知中心
 */
@interface HANotificationCenter : NSObject

+ (HANotificationCenter *)defaultCenter;

- (void)addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject;

- (void)postNotificationName:(NSString *)aName object:(id)anObject;

- (void)removeObserver:(id)observer;

@end

@interface HAObserver : NSObject

@property (nonatomic, assign) id target;

@property (nonatomic, assign) SEL selector;

@property (nonatomic, retain) id object;

@property (nonatomic, copy) NSString *notifiName;

@end