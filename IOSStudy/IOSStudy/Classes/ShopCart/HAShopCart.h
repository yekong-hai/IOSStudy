//
//  HAShopCart.h
//  IOSStudy
//
//  Created by hai on 14-7-1.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HASKUProduct.h"
#import "HAShopCartItem.h"

/**
 * 购物车
 * 更像是现实中的购物车
 */

@interface HAShopCart : NSObject

//当前购物车
+ (id)defaultShopCart;

//- (void)add:(HASKUProduct *) skuProduct;//更好点

//添加商品
- (void)addProduct:(id<HAProductSKU>) product;

//移除商品
- (void)removeProduct:(id<HAProductSKU>) product;

//购物车内的商品总数
- (int)countsOfProduct;

//商品清单--返回HAShopCartItem对象数组
- (NSArray *)productItemList;

//清空购物车
- (void)clear;

//移除一项商品
- (void)removeShopCartItem:(HAShopCartItem *) item;

@end
