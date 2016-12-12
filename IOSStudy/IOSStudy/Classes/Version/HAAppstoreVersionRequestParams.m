//
//  HAAppstoreVersionRequestParams.m
//  IOSStudy
//
//  Created by haiwang on 14-9-18.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAAppstoreVersionRequestParams.h"

@implementation HAAppstoreVersionRequestParams

- (NSString *)jsonNameWithPropertyName:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"appId"]) {
        return @"id";
    }else{
        return [super jsonNameWithPropertyName:propertyName];
    }
}

@end
