//
//  HAUser.h
//  IOSStudy
//
//  Created by hai on 14-7-7.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HASuperDataModel.h"

@class HAUserDescModel;

@interface HAUserModel : HASuperDataModel

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, assign) int age;

@property (nonatomic, retain) HAUserDescModel *descInfo;

@end

@interface HAUserDescModel : HASuperDataModel

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *descTime;

@end