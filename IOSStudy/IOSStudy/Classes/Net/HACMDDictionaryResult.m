//
//  HACMDDictionaryResult.m
//  IOSStudy
//
//  Created by hai on 14-7-4.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HACMDDictionaryResult.h"

@interface HACMDDictionaryResult ()
{
    BOOL _isParsed;
}

@end

@implementation HACMDDictionaryResult

- (void)parserWithResult:(NSString *)result
{
    [super parserWithResult:result];
    if (self.data && [self.data isKindOfClass:[NSDictionary class]]) {
        _isParsed = YES;
    }else{
        _isParsed = NO;
        NSLog(@"HACMDDictionaryResult Error: data is not kind of NSdictionary.");
    }
}

#pragma mark -- public methods

- (BOOL)isParse
{
    return _isParsed;
}

- (NSDictionary *)dictionaryData
{
    return (NSDictionary *)self.data;
}

@end
