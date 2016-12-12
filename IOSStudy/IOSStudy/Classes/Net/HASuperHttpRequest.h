//
//  HASuperHttpRequest.h
//  IOSStudy
//
//  Created by hai on 14-7-4.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HARootHttpRequest.h"
#import "HASuperHttpResult.h"

@class HASuperHttpRequest;

@protocol HASuperHttpRequestDelegate <NSObject>

- (void)requestStarted:(HASuperHttpRequest *) request;

- (void)requestFinished:(HASuperHttpRequest *)request withResult:(HASuperHttpResult *) result;

- (void)requestFailed:(HASuperHttpRequest *)request withResult:(HASuperHttpResult *) result;

@end

/**
 * 网络请求的父类
 */
@interface HASuperHttpRequest : HARootHttpRequest

@property (nonatomic, assign) id<HASuperHttpRequestDelegate> delegate;

//----------delegate----------

- (id)initWithParams:(NSDictionary *)params delegate:(id<HASuperHttpRequestDelegate>) delegate;

//------------block-----------

- (id)initWithParams:(NSDictionary *) params
    onRequestStarted:(void(^)(HASuperHttpRequest *request)) onRequestStarted
   onRequestFinished:(void(^)(HASuperHttpRequest *request,HASuperHttpResult *result)) onRequestFinished
     onRequestFailed:(void(^)(HASuperHttpRequest *request,HASuperHttpResult *result)) onRequestFailed;

+ (void)requestWithParams:(NSDictionary *)params
         onRequestStarted:(void(^)(HASuperHttpRequest *request)) onRequestStarted
        onRequestFinished:(void(^)(HASuperHttpRequest *request,HASuperHttpResult *result)) onRequestFinished
          onRequestFailed:(void(^)(HASuperHttpRequest *request,HASuperHttpResult *result)) onRequestFailed;

+ (HASuperHttpRequest *)requestInstanceWithParams:(NSDictionary *)params
                                 onRequestStarted:(void(^)(HASuperHttpRequest *request)) onRequestStarted
                                onRequestFinished:(void(^)(HASuperHttpRequest *request,HASuperHttpResult *result)) onRequestFinished
                                  onRequestFailed:(void(^)(HASuperHttpRequest *request,HASuperHttpResult *result)) onRequestFailed;

@end
