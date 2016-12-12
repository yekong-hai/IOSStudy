//
//  HAShopCartItem.h
//  IOSStudy
//
//  Created by hai on 14-7-2.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HASKUProduct.h"

/**
 * 商品清单项
 * 购物车物品概念
 * 实际性，可操作,唯一性
 */

@interface HAShopCartItem : NSObject

//商品名称
@property (nonatomic, copy,readonly) NSString *productName;

//此商品的个数，单位不限
@property (nonatomic, assign) unsigned int counts;

//一个品项的商品，唯一性商品
@property (nonatomic, retain) HASKUProduct *skuProduct;//没和购物车接口吻合，购物车使用的是协议


@end
