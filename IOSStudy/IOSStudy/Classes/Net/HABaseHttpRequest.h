//
//  HABaseHttpRequest.h
//  IOSStudy
//
//  Created by hai on 14-7-3.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <Foundation/Foundation.h>

//请求方法
typedef enum HAHttpRequestMethod{
    HAHttpRequestMethodGet = 0,
    HAHttpRequestMethodPost = 1
}HAHttpRequestMethod;

/**
 * 网络请求基类
 * 负责处理请求
 */
@interface HABaseHttpRequest : NSObject

@property (nonatomic, copy) NSString *requestUrl;

//------------------子类需要实现以下方法---------------
//host
- (NSString *)getRequestHost;

//path
- (NSString *)getRequestPath;

//method
- (HAHttpRequestMethod)getRequestMethod;

//请求是否成功---检查返回的数据是否协议正确
- (BOOL)isSuccess;

@end
