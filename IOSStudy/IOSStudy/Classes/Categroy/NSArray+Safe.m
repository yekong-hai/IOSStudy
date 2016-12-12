//
//  NSArray+Safe.m
//  IOSStudy
//
//  Created by haiwang on 14-7-16.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "NSArray+Safe.h"

@implementation NSArray (Safe)

//安全索引
- (id)objectAtIndexSafe:(NSUInteger)index
{
    if (self != nil && self.count != 0 && index < self.count) {
        return [self objectAtIndex:index];
    }
    return nil;
}

@end
