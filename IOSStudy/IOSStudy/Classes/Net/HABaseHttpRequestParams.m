//
//  HABaseHttpRequestParams.m
//  IOSStudy
//
//  Created by hai on 14-7-4.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HABaseHttpRequestParams.h"
#import <objc/runtime.h>

@implementation HABaseHttpRequestParams

#pragma mark -- HABaseHttpRequestParams Protocol

- (NSDictionary *)dictionaryWithParams
{
    Class class = [self class];
    u_int count;
    objc_property_t *properties = class_copyPropertyList(class,&count);
    NSMutableArray *propertyArray = [NSMutableArray arrayWithCapacity:count];
    NSMutableArray *valueArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++) {
        objc_property_t prop = properties[i];
        const char *propertyName = property_getName(prop);
        //为了一些json中的特殊字符，如id，需要转换成其他字段名称；或者一些本是客户端想改变名称的字段
        const char *newPropertyName = [[self jsonNameWithPropertyName:[NSString stringWithUTF8String:propertyName]] UTF8String];
        [propertyArray addObject:[NSString stringWithCString:newPropertyName encoding:NSUTF8StringEncoding]];
        id value = [self performSelector:NSSelectorFromString([NSString stringWithUTF8String:propertyName])];
        if (value == nil) {
            [valueArray addObject:[NSNull null]];
        }else{
            [valueArray addObject:value];
        }
    }
    free(properties);
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:valueArray forKeys:propertyArray];
    return dic;
}

- (NSString *)jsonNameWithPropertyName:(NSString *)propertyName
{
    return propertyName;
}

@end
