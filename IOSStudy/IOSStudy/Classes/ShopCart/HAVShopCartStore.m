//
//  HAVShopCartStore.m
//  IOSStudy
//
//  Created by hai on 14-7-2.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAVShopCartStore.h"

@implementation HAVShopCartStore

- (void)dealloc
{
    [_storeId release];
    [_storeName release];
    [_productItemArray release];
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        _productItemArray = [[NSMutableArray array] retain];
    }
    return self;
}
@end
