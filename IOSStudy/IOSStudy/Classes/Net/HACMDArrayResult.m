//
//  HACMDArrayResult.m
//  IOSStudy
//
//  Created by hai on 14-7-4.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HACMDArrayResult.h"

@interface HACMDArrayResult ()
{
    BOOL _isParsed;
    
}
@end

@implementation HACMDArrayResult

- (void)parserWithResult:(NSString *)result
{
    [super parserWithResult:result];
    if (self.data && [self.data isKindOfClass:[NSArray class]]) {
        _isParsed = YES;
    }else{
        _isParsed = NO;
        NSLog(@"HACMDArrayResult Error: data is not kind of NSArray.");
    }
}

#pragma mark -- public methods

- (BOOL)isParse
{
    return _isParsed;
}

- (NSArray *)arrayData
{
    return (NSArray *)self.data;
}

@end
