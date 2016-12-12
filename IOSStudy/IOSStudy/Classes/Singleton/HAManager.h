//
//  HAManager.h
//  IOSStudy
//
//  Created by haiwang on 14-12-2.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HAManager : NSObject

+ (instancetype)defaultManager;

+ (instancetype)shareManager;

+ (instancetype)defaultManagerNoSyn;

@end
