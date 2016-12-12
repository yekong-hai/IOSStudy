//
//  HASuperDataModel.h
//  IOSStudy
//
//  Created by hai on 14-7-7.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HASuperDataModel : NSObject

- (void)parseWithDic:(NSDictionary *)dicModel;

//对象属性名称替换字典，key--原字典的属性名称，value---新字典的属性名称
- (NSDictionary *)dicWithTargetKeyAndSourceKey;

@end

@interface HASuperDataModel (HttpResultParse)

//- (void)gennerationWithHttpResultData:(NSObject *) resultData;

@end