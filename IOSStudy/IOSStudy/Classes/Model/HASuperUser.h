//
//  HASuperUser.h
//  IOSStudy
//
//  Created by haiwang on 14-7-16.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HASuperUser : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *sex;

- (instancetype)initWithName:(NSString *) name;

- (id)initWithSex:(NSString *)sex;

+ (id)user;

- (void)setUserName:(NSString *)name;

@end
