//
//  HAObjectStudy.h
//  IOSStudy
//
//  Created by haiwang on 15-1-14.
//  Copyright (c) 2015年 hai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HAObjectStudy : NSObject

- (void)studyObject;

- (void)studyString;

+(HAObjectStudy *)getInstance;

+(HAObjectStudy *)getInitializeInstance;

@end
