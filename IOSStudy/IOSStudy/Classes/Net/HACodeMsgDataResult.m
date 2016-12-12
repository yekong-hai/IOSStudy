//
//  HACodeMsgDataResult.m
//  IOSStudy
//
//  Created by hai on 14-7-4.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HACodeMsgDataResult.h"

#define RESULT_CODE @"code"

#define RESULT_MESSAGE @"message"

#define RESULT_DATA @"data"

//成功状态码
#define RESULT_CODE_SUCCESS @"0000"

//网络错误状态码
#define RESULT_CODE_NET_ERROR @"2000"

//数据解析失败状态码
#define RESULT_CODE_PARSE_ERROR @"2001"


@interface HACodeMsgDataResult ()
{
    BOOL _isParsed;
}

@end

@implementation HACodeMsgDataResult

- (void)dealloc
{
    [_code release];
    [_message release];
    [_data release];
    [super dealloc];
}

#pragma mark -- private methods

- (NSDictionary *)dictionaryWithJson:(NSString *) json
{
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (error != nil) {
        HALog(@"数据解析失败，错误原因：%@",[error localizedDescription]);        
        self.code = RESULT_CODE_PARSE_ERROR;
        self.message = @"数据解析失败";
        _isParsed = NO;
    }
    return dic;
}

#pragma mark -- public methods

- (BOOL)isParse
{
    return _isParsed;
}

- (void)parserWithResult:(NSString *)result
{
    NSDictionary *resultDic = [self dictionaryWithJson:result];
    if (resultDic == nil) {
        return;
    }
    id resultCode = [resultDic objectForKey:RESULT_CODE];
    id resultMessage = [resultDic objectForKey:RESULT_MESSAGE];
    id resultData = [resultDic objectForKey:RESULT_DATA];
    self.data = resultData;
    BOOL isCodeOk = resultCode && [resultCode isKindOfClass:[NSString class]];
    BOOL isMessageOk = resultMessage && [resultMessage isKindOfClass:[NSString class]];
    if (isCodeOk && isMessageOk) {
        self.code = (NSString *)resultCode;
        self.message = (NSString *)resultMessage;
        _isParsed = YES;
    }else{
        self.code = RESULT_CODE_PARSE_ERROR;
        self.message = @"数据解析失败";
        _isParsed = NO;
    }
}

//返回数据是否成功，根据协议确定
- (BOOL)isSuccess
{
    return [_code isEqualToString:RESULT_CODE_SUCCESS];
}

- (void)createFailedResult
{
    self.code = RESULT_CODE_NET_ERROR;
    self.message = @"网络错误";
}

@end
