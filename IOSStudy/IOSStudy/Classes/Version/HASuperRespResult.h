//
//  HASuperRespResult.h
//  IOSStudy
//
//  Created by haiwang on 14-9-18.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HASuperDataModel.h"
#import "HASuperHttpResult.h"

@interface HASuperRespResult : HASuperDataModel<HAHttpResponseResult>

- (Class)classForPropertyName:(NSString *) propertyName;

@end
