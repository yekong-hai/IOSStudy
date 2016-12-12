//
//  HAAppstoreSuperHttpRequest.h
//  IOSStudy
//
//  Created by haiwang on 14-9-18.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HARootHttpRequest.h"

@class HAAppstoreSuperHttpRequest;

@protocol HAAppstoreSuperHttpRequestDelegate <NSObject>

- (void)requestStarted:(HAAppstoreSuperHttpRequest *) request;

- (void)requestFinished:(HAAppstoreSuperHttpRequest *)request;

- (void)requestFailed:(HAAppstoreSuperHttpRequest *)request;

@end

/**
 * 网络请求的父类
 */
@interface HAAppstoreSuperHttpRequest : HARootHttpRequest

@property (nonatomic, assign) id<HAAppstoreSuperHttpRequestDelegate> delegate;

//----------delegate----------

- (id)initWithParams:(NSDictionary *)params delegate:(id<HAAppstoreSuperHttpRequestDelegate>) delegate;

//------------block-----------

- (id)initWithParams:(NSDictionary *) params
    onRequestStarted:(void(^)(HAAppstoreSuperHttpRequest *request)) onRequestStarted
   onRequestFinished:(void(^)(HAAppstoreSuperHttpRequest *request)) onRequestFinished
     onRequestFailed:(void(^)(HAAppstoreSuperHttpRequest *request)) onRequestFailed;

+ (void)requestWithParams:(NSDictionary *)params
         onRequestStarted:(void(^)(HAAppstoreSuperHttpRequest *request)) onRequestStarted
        onRequestFinished:(void(^)(HAAppstoreSuperHttpRequest *request)) onRequestFinished
          onRequestFailed:(void(^)(HAAppstoreSuperHttpRequest *request)) onRequestFailed;

+ (HAAppstoreSuperHttpRequest *)requestInstanceWithParams:(NSDictionary *)params
                                 onRequestStarted:(void(^)(HAAppstoreSuperHttpRequest *request)) onRequestStarted
                                onRequestFinished:(void(^)(HAAppstoreSuperHttpRequest *request)) onRequestFinished
                                  onRequestFailed:(void(^)(HAAppstoreSuperHttpRequest *request)) onRequestFailed;


@end
