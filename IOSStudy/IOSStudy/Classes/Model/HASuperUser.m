//
//  HASuperUser.m
//  IOSStudy
//
//  Created by haiwang on 14-7-16.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HASuperUser.h"

@implementation HASuperUser

- (void)dealloc
{
    [_name release];
    [_sex release];
    [super dealloc];
}

- (instancetype)initWithName:(NSString *) name
{
    self = [super init];
    if (self) {
        _name = [name copy];
    }
    return self;
}

- (id)initWithSex:(NSString *)sex
{
    self = [super init];
    if (self) {
        _sex = [sex copy];
    }
    return self;
}

- (void)setUserName:(NSString *)name
{
    if (_name) {
        [_name release];
    }
    _name = [name copy];
}

+ (id)user
{
    return nil;
}

@end
