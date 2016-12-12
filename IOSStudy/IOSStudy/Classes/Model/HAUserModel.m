//
//  HAUser.m
//  IOSStudy
//
//  Created by hai on 14-7-7.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAUserModel.h"

@implementation HAUserModel

//- (NSDictionary *)dicWithTargetKeyAndSourceKey
//{
//    return [NSDictionary dictionaryWithObjectsAndKeys:@"name",@"userName", nil];
//}

- (void)dealloc
{
    [_name release];
    [_sex release];
    [super dealloc];
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"user:{name:%@, sex:%@, age:%d, descInfo:%@}",_name,_sex,_age,_descInfo];
}

@end

@implementation HAUserDescModel

- (void)dealloc
{
    [_desc release];
    [_descTime release];
    [super dealloc];
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"descInfo:{desc:%@, descTime:%@}",_desc,_descTime];
}

@end