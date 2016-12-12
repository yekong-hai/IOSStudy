//
//  DBLog.m
//  IOSStudy
//
//  Created by haiwang on 14-8-18.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "DBLog.h"

void DBLog(const char *fileName, int lineNumber, NSString *fmt,...)
{
    va_list args;
    
    va_start(args, fmt);
    
    static NSDateFormatter *debugFormatter = nil;
    
    if (debugFormatter == nil) {
        debugFormatter = [[NSDateFormatter alloc] init];
        [debugFormatter setDateFormat:@"yyyy MM dd.HH:mm:ss"];
    }
    
    NSString *msg = [[NSString alloc] initWithFormat:fmt arguments:args];
    
    NSString        *filePath = [[NSString alloc] initWithUTF8String:fileName];
    NSString        *timestamp = [debugFormatter stringFromDate:[NSDate date]];
    NSDictionary    *info = [[NSBundle mainBundle] infoDictionary];
    NSString        *appName = [info objectForKey:(NSString *)kCFBundleNameKey];
    fprintf(stdout, "-->%s %s \n[%s:%d] \n%s\n", [timestamp UTF8String], [appName UTF8String], [[filePath lastPathComponent] UTF8String], lineNumber, [msg UTF8String]);
    
    va_end(args);
    [msg release];
    [filePath release];
}