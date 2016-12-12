//
//  HAManager.m
//  IOSStudy
//
//  Created by haiwang on 14-12-2.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAManager.h"

@implementation HAManager

static HAManager *defaultManager = nil;
static int createTimes = 0;
static HAManager *defaultNoSynManager = nil;
static int createTimesOfNoSyn = 0;
static int createTimesOfOnce = 0;

+ (instancetype)defaultManager
{
    NSLog(@"syn---当前线程%@",[NSThread currentThread].name);
    @synchronized(self){
        if (defaultManager == nil) {
            createTimes++;
            defaultManager = [[HAManager alloc] init];
            NSLog(@"线程 %@ -- syn创建管理器第 %d 个",[NSThread currentThread].name,createTimes);
        }
        return defaultManager;
    }
}

+ (instancetype)defaultManagerNoSyn
{
    NSLog(@"nosyn---当前线程%@",[NSThread currentThread].name);
    if (defaultNoSynManager == nil) {
        createTimesOfNoSyn++;
        defaultNoSynManager = [[HAManager alloc] init];
        NSLog(@"线程 %@ -- nosyn创建管理器第 %d 个",[NSThread currentThread].name,createTimesOfNoSyn);
    }
    return defaultNoSynManager;
}


+ (instancetype)shareManager
{
    NSLog(@"once---当前线程%@",[NSThread currentThread].name);
    static HAManager *shareManager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        createTimesOfOnce++;
        shareManager = [[HAManager alloc] init];
        NSLog(@"线程 %@ -- once创建管理器第 %d 个",[NSThread currentThread].name,createTimesOfOnce);
    });
    return shareManager;
}

@end
