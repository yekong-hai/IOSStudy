//
//  HASuperHttpRequest.m
//  IOSStudy
//
//  Created by hai on 14-7-4.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HASuperHttpRequest.h"
#import "HACodeMsgDataResult.h"

@interface HASuperHttpRequest ()
{
    void (^_onRequestStartBlock)(HASuperHttpRequest *);
    void (^_onRequestFinishedBlock)(HASuperHttpRequest *,HASuperHttpResult *);
    void (^_onRequestFailedBlock)(HASuperHttpRequest *,HASuperHttpResult *);
}

@end

@implementation HASuperHttpRequest

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
    HACodeMsgDataResult *result = [[[HACodeMsgDataResult alloc] init] autorelease];
    [result parserWithResult:request.responseContent];
    if ([result isParse]) {
        if (_delegate && [_delegate respondsToSelector:@selector(requestFinished:withResult:)]) {
            [_delegate requestFinished:self withResult:result];
        }
        if (_onRequestFinishedBlock) {
            _onRequestFinishedBlock(self,result);
        }
    }else{
        if (_delegate && [_delegate respondsToSelector:@selector(requestFailed:withResult:)]) {
            [_delegate requestFailed:self withResult:result];
        }
        if (_onRequestFailedBlock) {
            _onRequestFailedBlock(self,result);
        }
    }
}

- (void)requestOnFailed:(HARootHttpRequest *)request
{
    HACodeMsgDataResult *result = [[[HACodeMsgDataResult alloc] init] autorelease];
    [result createFailedResult];
    if (_delegate && [_delegate respondsToSelector:@selector(requestFailed:withResult:)]) {
        [_delegate requestFailed:self withResult:result];
    }
    if (_onRequestFailedBlock) {
        _onRequestFailedBlock(self,result);
    }
}

#pragma mark -- init methods

- (id)initWithParams:(NSDictionary *)params delegate:(id<HASuperHttpRequestDelegate>) delegate
{
    self = [super initWithParams:params];
    if (self) {
        _delegate = delegate;
    }
    return self;
}

- (id)initWithParams:(NSDictionary *) params
    onRequestStarted:(void(^)(HASuperHttpRequest *request)) onRequestStarted
   onRequestFinished:(void(^)(HASuperHttpRequest *request,HASuperHttpResult *result)) onRequestFinished
     onRequestFailed:(void(^)(HASuperHttpRequest *request,HASuperHttpResult *result)) onRequestFailed
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
         onRequestStarted:(void(^)(HASuperHttpRequest *request)) onRequestStarted
        onRequestFinished:(void(^)(HASuperHttpRequest *request,HASuperHttpResult *result)) onRequestFinished
          onRequestFailed:(void(^)(HASuperHttpRequest *request,HASuperHttpResult *result)) onRequestFailed
{
    HASuperHttpRequest *request = [[[[self class] alloc] initWithParams:params onRequestStarted:onRequestStarted onRequestFinished:onRequestFinished onRequestFailed:onRequestFailed] autorelease];
    [request request];
}

+ (HASuperHttpRequest *)requestInstanceWithParams:(NSDictionary *)params
                                 onRequestStarted:(void(^)(HASuperHttpRequest *request)) onRequestStarted
                                onRequestFinished:(void(^)(HASuperHttpRequest *request,HASuperHttpResult *result)) onRequestFinished
                                  onRequestFailed:(void(^)(HASuperHttpRequest *request,HASuperHttpResult *result)) onRequestFailed
{
    HASuperHttpRequest *request = [[[[self class] alloc] initWithParams:params onRequestStarted:onRequestStarted onRequestFinished:onRequestFinished onRequestFailed:onRequestFailed] autorelease];
    [request request];
    return request;
}

@end
