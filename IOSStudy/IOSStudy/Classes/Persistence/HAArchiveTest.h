//
//  HAArchiveTest.h
//  IOSStudy
//
//  Created by haiwang on 14-10-31.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HAUserDesc,HAUserAge;

@interface HAArchiveTest : NSObject<NSCoding>

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) HAUserAge *age;

@property (nonatomic, retain) HAUserDesc *userDesc;

@property (nonatomic, assign) int userAge;

@end

@interface HAUserAge : NSObject<NSCoding,NSCopying>

@property (nonatomic, copy) NSString *age;

@property (nonatomic, copy) NSString *ageTime;

@end

@interface HAUserDesc : NSObject<NSCoding>

@property (nonatomic, copy) NSString *userDesc;

@property (nonatomic, copy) NSString *descTime;

@end