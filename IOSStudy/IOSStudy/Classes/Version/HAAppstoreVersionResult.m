//
//  HAAppstoreVersionResult.m
//  IOSStudy
//
//  Created by haiwang on 14-9-18.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAAppstoreVersionResult.h"

@interface HAAppstoreVersionResult ()

@end

@implementation HAAppstoreVersionResult

- (void)dealloc
{
    [_results release];
    [super dealloc];
}

- (Class)classForPropertyName:(NSString *) propertyName
{
    if ([propertyName isEqualToString:@"results"]) {
        return [HASoftwareInfo class];
    }
    return nil;
}

@end
