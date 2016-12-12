//
//  HASuperRespResult.m
//  IOSStudy
//
//  Created by haiwang on 14-9-18.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HASuperRespResult.h"
#import <objc/runtime.h>

@interface HASuperRespResult ()
{
    BOOL _isParsed;
}

@end

@implementation HASuperRespResult

#pragma mark -- private methods

- (NSDictionary *)dictionaryWithJson:(NSString *) json
{
//    json = @"{\"name\":\"haiwang\",\"age\":28,\"userDep\":{\"descript\":\"脾气不大好\",\"level\":7},\"comments\":[{\"userId\":\"123\",\"commentContent\":\"脾气很不好\"},{\"userId\":\"666\",\"commentContent\":\"臭脾气，好好改改\"}]}";
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (error != nil) {
        HALog(@"数据解析失败，错误原因：%@",[error localizedDescription]);
        _isParsed = NO;
    }
    return dic;
}

- (void)parserWithResult:(NSString *)result
{
    NSDictionary *resultDic = [self dictionaryWithJson:result];
    [self parseWithDic:resultDic];
}

- (void)parseWithDic:(NSDictionary *)dicModel
{
    [self parseWithDicionary:dicModel];
    //    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:dicModel];
    //    NSDictionary *dictionary = [self dicWithTargetKeyAndSourceKey];
    //    for (NSString *key in dictionary.allKeys) {
    //        id keyValue = [dicModel objectForKey:key];
    //        if (keyValue) {
    //            id newKey = [dictionary objectForKey:key];
    //            if (newKey) {
    //                [tempDic setValue:keyValue forKey:newKey];
    //                [tempDic removeObjectForKey:key];
    //            }
    //        }
    //    }
    //    [self setValuesForKeysWithDictionary:tempDic];
    //    _isParsed = YES;
}

- (void)parseWithDicionary:(NSDictionary *)dicModel
{
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    for (NSString *key in dicModel.allKeys) {
        id value = [dicModel objectForKey:key];
        if ([value isKindOfClass:[NSArray class]]) {
            Class class = [self classForPropertyName:key];
            NSMutableArray *array = [NSMutableArray array];
            NSArray *valueArray = value;
            if (valueArray.count != 0) {
                if (class != nil) {
                    for (id arrayObject in value) {
                        id object = [[class alloc] init];
                        [object parseWithDicionary:arrayObject];
                        [array addObject:object];
                        [object release];
                    }
                    value = array;
                }
            }
            if ([self isExistForPropertyName:key]) {
                [tempDic setValue:value forKey:key];
            }
        }else if ([value isKindOfClass:[NSDictionary class]]){
            Class class = [self classForPropertyName:key];
            if (class != nil) {
                id object = [[class alloc] init];
                [object parseWithDicionary:value];
                value = object;
                if ([self isExistForPropertyName:key]) {
                    [tempDic setValue:value forKey:key];
                }
                [object release];
            }
        }else{
            if ([self isExistForPropertyName:key]) {
                [tempDic setValue:value forKey:key];
            }
        }
    }
    [self setValuesForKeysWithDictionary:tempDic];
    _isParsed = YES;
}

- (BOOL)isExistForPropertyName:(NSString *) propertyName
{
    BOOL isExist = NO;
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *classPropertyName = [NSString stringWithUTF8String:property_getName(property)];
        if ([propertyName isEqualToString:classPropertyName]) {
            isExist = YES;
            break;
        }
    }
    return isExist;
}

//- (void)setValuesForKeysWithDictionary:(NSDictionary *)keyedValues
//{
//    
//}

- (Class)classForPropertyName:(NSString *) propertyName
{
    return nil;
}

//对象属性名称替换字典，key--原字典的属性名称，value---新字典的属性名称
- (NSDictionary *)dicWithTargetKeyAndSourceKey
{
    return nil;
}

#pragma mark -- public methods

- (BOOL)isParse
{
    return _isParsed;
}

@end
