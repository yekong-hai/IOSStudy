//
//  HACodeMsgDataResult.h
//  IOSStudy
//
//  Created by hai on 14-7-4.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HASuperHttpResult.h"

@interface HACodeMsgDataResult : HASuperHttpResult

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, retain) NSObject *data;

//返回数据是否成功，根据协议确定
- (BOOL)isSuccess;

//网络错误result信息
+ (instancetype)failedResult;

@end
