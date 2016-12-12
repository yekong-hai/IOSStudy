//
//  NSArray+Safe.h
//  IOSStudy
//
//  Created by haiwang on 14-7-16.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Safe)

//安全索引
- (id)objectAtIndexSafe:(NSUInteger)index;

@end
