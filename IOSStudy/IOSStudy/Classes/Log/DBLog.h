//
//  DBLog.h
//  IOSStudy
//
//  Created by haiwang on 14-8-18.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG

#define HALog(format...) DBLog(__FILE__, __LINE__, format)

#else

#define HALog(format...)

#endif


void DBLog(const char *fileName, int lineNumber, NSString *fmt,...);