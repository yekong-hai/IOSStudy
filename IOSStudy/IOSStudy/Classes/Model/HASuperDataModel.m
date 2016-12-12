//
//  HASuperDataModel.m
//  IOSStudy
//
//  Created by hai on 14-7-7.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HASuperDataModel.h"

@implementation HASuperDataModel

- (void)parseWithDic:(NSDictionary *)dicModel
{
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:dicModel];
    NSDictionary *dictionary = [self dicWithTargetKeyAndSourceKey];
    for (NSString *key in dictionary.allKeys) {
        id keyValue = [dicModel objectForKey:key];
        if (keyValue) {
            id newKey = [dictionary objectForKey:key];
            if (newKey) {
                [tempDic setValue:keyValue forKey:newKey];
                [tempDic removeObjectForKey:key];
            }
        }
    }
    [self setValuesForKeysWithDictionary:tempDic];
}

//对象属性名称替换字典，key--原字典的属性名称，value---新字典的属性名称
- (NSDictionary *)dicWithTargetKeyAndSourceKey
{
    return nil;
}

@end

@implementation HASuperDataModel (HttpResultParse)

- (void)gennerationWithHttpResultData:(NSObject *) resultData
{
    if (resultData) {
        if ([resultData isKindOfClass:[NSArray class]]) {
            NSArray *resultArray = (NSArray *)resultData;
            id first = [resultArray firstObject];
            NSDictionary *firstDic = first;
            [self parseWithDic:firstDic];
        }else if ([resultData isKindOfClass:[NSDictionary class]]){
            [self parseWithDic:(NSDictionary *)resultData];
        }
    }
}

@end