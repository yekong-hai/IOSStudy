//
//  HAAppstoreVersionRequest.m
//  IOSStudy
//
//  Created by haiwang on 14-9-18.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAAppstoreVersionRequest.h"

@implementation HAAppstoreVersionRequest

- (NSString *)getRequestHost
{
    return @"http://itunes.apple.com/";
}

- (NSString *)getRequestPath
{
    return @"lookup";
}

- (HAHttpRequestMethod)getRequestMethod
{
    return HAHttpRequestMethodGet;
}

@end
