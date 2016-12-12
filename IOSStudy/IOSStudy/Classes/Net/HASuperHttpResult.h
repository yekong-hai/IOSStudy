//
//  HASuperHttpResult.h
//  IOSStudy
//
//  Created by hai on 14-7-4.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HAHttpResponseResult <NSObject>

- (BOOL)isParse;

//解析response数据
- (void)parserWithResult:(NSString *) result;

@end
/**
 * 网络请求结果数据
 * 自定义协议格式
 */
@interface HASuperHttpResult : NSObject<HAHttpResponseResult>

//网络错误result信息
- (void)createFailedResult;

@end
