//
//  NSDate+Chinese.m
//  IOSStudy
//
//  Created by haiwang on 14-7-16.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "NSDate+Chinese.h"

#define DATE_FORMATER_YMDHMS @"yyyy-MM-dd hh:mm:ss"

@implementation NSDate (Chinese)


//获取本地时间，北京时间
+ (NSDate *)localDate
{
    NSDate *date = [NSDate date];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSInteger seconds = [timeZone secondsFromGMTForDate:date];
    NSDate *localDate = [date dateByAddingTimeInterval:seconds];
//    NSLog(@"local date :%@",localDate);
    return localDate;
}

//返回yyyy-MM-dd hh:mm:ss格式的时间字符串
+ (NSString *)dateWithYMDHMSFormater
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = DATE_FORMATER_YMDHMS;
    return [formater stringFromDate:date];
}

@end
