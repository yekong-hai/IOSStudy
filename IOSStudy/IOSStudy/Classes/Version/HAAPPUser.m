//
//  HAAPPUser.m
//  IOSStudy
//
//  Created by haiwang on 14-9-18.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAAPPUser.h"

@implementation HAAPPUser

- (void)dealloc
{
    [_name release];
    [_userDep release];
    [_comments release];
    [super dealloc];
}

- (Class)classForPropertyName:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"userDep"]) {
        return [HAUserDescription class];
    }else if ([propertyName isEqualToString:@"comments"]){
        return [HAUserComment class];
    }
    return nil;
}

@end

@implementation HAUserDescription

- (void)dealloc
{
    [_descript release];
    [super dealloc];
}

@end

@implementation HAUserComment

- (void)dealloc
{
    [_userId release];
    [_commentContent release];
    [super dealloc];
}

@end