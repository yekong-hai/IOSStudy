//
//  HAUser.h
//  IOSStudy
//
//  Created by hai on 14-6-25.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HAUser : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *info;

+ (NSArray *)userList;

@end
