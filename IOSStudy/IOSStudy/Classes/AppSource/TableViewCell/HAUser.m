//
//  HAUser.m
//  IOSStudy
//
//  Created by hai on 14-6-25.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAUser.h"

@implementation HAUser

- (void)dealloc
{
    [_name release];
    [_info release];
    [super dealloc];
}

#pragma mark -- public methods

+ (NSArray *)userList
{
    NSMutableArray *userArray = [NSMutableArray array];
    for (int i = 0; i < 10; i ++) {
        HAUser *user = [[HAUser alloc] init];
        user.name = @"小红";
        user.info = @"很方便在弹出的键盘上方添加一个自定义的工具条，可以在工具条中添加任意多的按钮，并且自定义按钮的文字和点击动作。很方便在弹出的键盘上方添加一个自定义的工具条，可以在工具条中添加任意多的按钮，并且自定义按钮的文字和点击动作。很方便在弹出的键盘上方添加一个自定义的工具条，可以在工具条中添加任意多的按钮，并且自定义按钮的文字和点击动作。很方便在弹出的键盘上方添加一个自定义的工具条，可以在工具条中添加任意多的按钮，并且自定义按钮的文字和点击动作。";
        [userArray addObject:user];
        [user release];
    }
    return userArray;
}

@end
