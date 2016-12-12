//
//  StockData.m
//  IOSStudy
//
//  Created by haiwang on 14-8-19.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "StockData.h"

@implementation StockData

- (void)dealloc
{
    [_stockName release];
    [super dealloc];
}

@end
