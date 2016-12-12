//
//  HASKUProduct.m
//  IOSStudy
//
//  Created by hai on 14-7-2.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HASKUProduct.h"

@implementation HASKUProduct

- (void)dealloc
{
    [_sku release];
//    [_productId release];
//    [_name release];
    [_color release];
//    [_imageArray release];
//    [_descript release];
//    [_branch release];
//    [_storeId release];
//    [_storeName release];
    [super dealloc];
}

//重写判断2个商品是否是品项相同的商品
- (BOOL)isEqual:(id)object
{
    if (object == nil) {
        return NO;
    }else{
        if (self == object) {
            return YES;
        }else{
            if ([object isKindOfClass:[HASKUProduct class]]) {
                HASKUProduct *tSkuProduct = (HASKUProduct *)object;
                if ([tSkuProduct.sku isEqualToString:self.sku]) {
                    return YES;
                }else{
                    return NO;
                }
            }else{
                return NO;
            }
        }
    }
}

@end
