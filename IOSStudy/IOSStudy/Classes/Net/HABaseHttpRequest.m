//
//  HABaseHttpRequest.m
//  IOSStudy
//
//  Created by hai on 14-7-3.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HABaseHttpRequest.h"
#import "ASIHTTPRequest.h"

@interface HABaseHttpRequest ()

@property (nonatomic, copy) NSString *requestHost;

@property (nonatomic, copy) NSString *requestPath;

@end

@implementation HABaseHttpRequest

#pragma mark -- init methods

- (void)dealloc
{
    [_requestHost release];
    [_requestPath release];
    [_requestUrl release];
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        [self joinHostAndPath];
    }
    return self;
}

#pragma mark -- protect methods

//host
- (NSString *)getRequestHost
{
    return nil;
}

//path
- (NSString *)getRequestPath
{
    return nil;
}

- (HAHttpRequestMethod)getRequestMethod
{
    return HAHttpRequestMethodGet;
}

#pragma mark -- private methods

- (void)joinHostAndPath
{
    NSString *host = [self getRequestHost];
    if (host == nil || host.length == 0) {
        NSLog(@"request host not null.");
        return;
    }
    NSString *path = [self getRequestPath];
    if (path == nil || path.length == 0) {
        NSLog(@"request path not null.");
        return;
    }
    self.requestUrl = [NSString stringWithFormat:@"%@%@",host,path];
}

#pragma mark -- public methods

//请求是否成功
- (BOOL)isSuccess
{
    return NO;
}

@end
