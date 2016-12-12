//
//  HATopHttpRequest.m
//  IOSStudy
//
//  Created by hai on 14-7-7.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HATopHttpRequest.h"
#import "HAHttpRequestConfig.h"
#import "HAUserLoginRequestParams.h"

@implementation HATopHttpRequest

- (NSString *)getRequestHost
{
    return SERVICE_HOST;
}

- (NSString *)getRequestPath
{
    return nil;
}

- (HAHttpRequestMethod)getRequestMethod
{
    return HAHttpRequestMethodPost;
}

@end
