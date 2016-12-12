//
//  HAAPPUser.h
//  IOSStudy
//
//  Created by haiwang on 14-9-18.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HASuperRespResult.h"

@class HAUserDescription;

@interface HAAPPUser : HASuperRespResult

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) int age;

@property (nonatomic, retain) HAUserDescription *userDep;

@property (nonatomic, retain) NSArray *comments;

@end

@interface HAUserDescription : HASuperRespResult

@property (nonatomic, copy) NSString *descript;

@property (nonatomic, assign) int level;

@end

@interface HAUserComment : HASuperRespResult

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *commentContent;

@end