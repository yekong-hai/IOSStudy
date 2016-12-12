//
//  HAProduct.m
//  IOSStudy
//
//  Created by hai on 14-7-2.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAProduct.h"

@implementation HAProduct

- (void)dealloc
{
    [_productId release];
    [_name release];
    [_imageArray release];
    [_colorArray release];
    [_descript release];
    [_sizeArray release];
    [_branch release];
    [_storeId release];
    [_storeName release];
    [super dealloc];
}

//商户是否相同
- (BOOL)isEqualForStore:(HAProduct *) product
{
    if (product != nil) {
        if (self == product) {
            return YES;
        }else{
            if ([self.storeId isEqualToString:product.storeId]) {
                return YES;
            }else{
                return NO;
            }
        }
    }
    return NO;
}

@end
