//
//  HABaseHttpRequestParams.h
//  IOSStudy
//
//  Created by hai on 14-7-4.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <Foundation/Foundation.h>

//请求参数协议---自动转换成字典
@protocol HABaseHttpRequestParams <NSObject>

- (NSDictionary *)dictionaryWithParams;

@end

/**
 * 对象属性转换为字典内容
 */
@interface HABaseHttpRequestParams : NSObject<HABaseHttpRequestParams>

- (NSString *)jsonNameWithPropertyName:(NSString *) propertyName;

@end
