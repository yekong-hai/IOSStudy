//
//  HAHttpRequestManager.m
//  IOSStudy
//
//  Created by hai on 14-7-3.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAHttpRequestManager.h"

@interface HAHttpRequestManager ()

@property (nonatomic, retain) NSMutableArray *containerArray;

@end

@implementation HAHttpRequestManager

static HAHttpRequestManager *defaultManager;

#pragma mark -- init methods

- (void)dealloc
{
    [_containerArray release];
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        _containerArray = [[NSMutableArray array] retain];
    }
    return self;
}

#pragma mark -- public methods

+(HAHttpRequestManager *)shareManager
{
    @synchronized(self){
        if (defaultManager == nil) {
            defaultManager = [[HAHttpRequestManager alloc] init];
        }
        return defaultManager;
    }
}

- (void)addHttpRequest:(HARootHttpRequest *) request
{
    @synchronized(self){
        if (request) {
            [_containerArray addObject:request];
        }
    }
}

- (void)removeHttpRequest:(HARootHttpRequest *) request
{
    @synchronized(self){
        if (request) {
            [_containerArray removeObject:request];
        }
    }
}

- (void)cancelAllRequest
{
    @synchronized(self){
        for (HARootHttpRequest *request in _containerArray) {
            [request cancelASIRequest];
        }
        [_containerArray removeAllObjects];
    }
}

@end
