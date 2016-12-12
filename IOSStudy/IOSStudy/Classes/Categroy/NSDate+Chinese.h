//
//  NSDate+Chinese.h
//  IOSStudy
//
//  Created by haiwang on 14-7-16.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
    好像是从ios4.1开始[NSDate date];获取的是GMT时间，这个时间和北京时间相差8个小时，以下代码可以解决这个问题
 */
@interface NSDate (Chinese)

//获取本地时间，北京时间
+ (NSDate *)localDate;


//返回yyyy-MM-dd hh:mm:ss格式的时间字符串
+ (NSString *)dateWithYMDHMSFormater;

@end
