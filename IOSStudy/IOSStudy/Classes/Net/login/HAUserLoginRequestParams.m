//
//  HAUserLoginRequestParams.m
//  IOSStudy
//
//  Created by hai on 14-7-7.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAUserLoginRequestParams.h"

@implementation HAUserLoginRequestParams

- (void)dealloc
{
    [_userId release];
    [_password release];
    [super dealloc];
}

@end
