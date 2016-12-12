//
//  HAAppstoreVersionResult.h
//  IOSStudy
//
//  Created by haiwang on 14-9-18.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HASuperRespResult.h"
#import "HASoftwareInfo.h"

@interface HAAppstoreVersionResult : HASuperRespResult

@property (nonatomic, assign) int resultCount;

@property (nonatomic, retain) NSArray *results;

@end