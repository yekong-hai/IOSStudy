//
//  HARootHttpRequest.h
//  IOSStudy
//
//  Created by hai on 14-7-4.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HABaseHttpRequest.h"
#import "ASIHTTPRequest.h"

/**
 * 网络请求根类
 */
@interface HARootHttpRequest : HABaseHttpRequest

@property (nonatomic, retain) NSDictionary *requestParams;

@property (nonatomic, copy) NSString *responseContent;

- (id)initWithParams:(NSDictionary *)paramsDic;

//request
- (void)request;

//检查返回结果是否正确
- (BOOL)isSuccess;

- (void)cancelRequest;

- (void)cancelASIRequest;

- (void)requestOnStarted:(HARootHttpRequest *)request;

- (void)requestOnFinished:(HARootHttpRequest *)request;

- (void)requestOnFailed:(HARootHttpRequest *)request;

@end
