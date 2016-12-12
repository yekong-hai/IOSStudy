//
//  HAAppstoreSuperHttpRequest.m
//  IOSStudy
//
//  Created by haiwang on 14-9-18.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAAppstoreSuperHttpRequest.h"
#import "HAHttpRequestManager.h"

@interface HAAppstoreSuperHttpRequest ()
{
    void (^_onRequestStartBlock)(HAAppstoreSuperHttpRequest *);
    void (^_onRequestFinishedBlock)(HAAppstoreSuperHttpRequest *);
    void (^_onRequestFailedBlock)(HAAppstoreSuperHttpRequest *);
}

@end

@implementation HAAppstoreSuperHttpRequest

- (void)dealloc
{
    [_onRequestFailedBlock release];
    [_onRequestFinishedBlock release];
    [_onRequestStartBlock release];
    [super dealloc];
}

#pragma mark -- 处理response结果

- (void)requestOnStarted:(HARootHttpRequest *)request
{
    if (_delegate && [_delegate respondsToSelector:@selector(requestStarted:)]) {
        [_delegate requestStarted:self];
    }
    if (_onRequestStartBlock) {
        _onRequestStartBlock(self);
    }
}

- (void)requestOnFinished:(HARootHttpRequest *)request
{
    if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:)]) {
            [_delegate requestFinished:self];
        }
    if (_onRequestFinishedBlock) {
        _onRequestFinishedBlock(self);
    }
}

- (void)requestOnFailed:(HARootHttpRequest *)request
{
    if (_delegate && [_delegate respondsToSelector:@selector(requestFailed:)]) {
        [_delegate requestFailed:self];
    }
    if (_onRequestFailedBlock) {
        _onRequestFailedBlock(self);
    }
}

#pragma mark -- init methods

- (id)initWithParams:(NSDictionary *)params delegate:(id<HAAppstoreSuperHttpRequestDelegate>) delegate
{
    self = [super initWithParams:params];
    if (self) {
        _delegate = delegate;
    }
    return self;
}

- (id)initWithParams:(NSDictionary *) params
    onRequestStarted:(void(^)(HAAppstoreSuperHttpRequest *request)) onRequestStarted
   onRequestFinished:(void(^)(HAAppstoreSuperHttpRequest *request)) onRequestFinished
     onRequestFailed:(void(^)(HAAppstoreSuperHttpRequest *request)) onRequestFailed
{
    self = [super initWithParams:params];
    if (self) {
        if (onRequestStarted) {
            _onRequestStartBlock = [onRequestStarted copy];
        }
        if (onRequestFinished) {
            _onRequestFinishedBlock = [onRequestFinished copy];
        }
        if (onRequestFailed) {
            _onRequestFailedBlock = [onRequestFailed copy];
        }
    }
    return self;
}

+ (void)requestWithParams:(NSDictionary *)params
         onRequestStarted:(void(^)(HAAppstoreSuperHttpRequest *request)) onRequestStarted
        onRequestFinished:(void(^)(HAAppstoreSuperHttpRequest *request)) onRequestFinished
          onRequestFailed:(void(^)(HAAppstoreSuperHttpRequest *request)) onRequestFailed
{
    HAAppstoreSuperHttpRequest *request = [[[[self class] alloc] initWithParams:params onRequestStarted:onRequestStarted onRequestFinished:onRequestFinished onRequestFailed:onRequestFailed] autorelease];
    [request request];
}

+ (HAAppstoreSuperHttpRequest *)requestInstanceWithParams:(NSDictionary *)params
                                 onRequestStarted:(void(^)(HAAppstoreSuperHttpRequest *request)) onRequestStarted
                                onRequestFinished:(void(^)(HAAppstoreSuperHttpRequest *request)) onRequestFinished
                                  onRequestFailed:(void(^)(HAAppstoreSuperHttpRequest *request)) onRequestFailed
{
    HAAppstoreSuperHttpRequest *request = [[[[self class] alloc] initWithParams:params onRequestStarted:onRequestStarted onRequestFinished:onRequestFinished onRequestFailed:onRequestFailed] autorelease];
    [request request];
    return request;
}

@end
