//
//  HAShopCartItem.m
//  IOSStudy
//
//  Created by hai on 14-7-2.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAShopCartItem.h"

@implementation HAShopCartItem

- (void)dealloc
{
    [_skuProduct release];
    [super dealloc];
}

- (NSString *)productName
{
    return _skuProduct.name;
}

@end
