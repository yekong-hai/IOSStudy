//
//  HAUserLoginRequestParams.h
//  IOSStudy
//
//  Created by hai on 14-7-7.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HABaseHttpRequestParams.h"

//可写到request的类文件中
@interface HAUserLoginRequestParams : HABaseHttpRequestParams

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *password;

@end
