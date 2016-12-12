//
//  HAVShopCart.h
//  IOSStudy
//
//  Created by hai on 14-7-2.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HASKUProduct.h"
#import "HAShopCartItem.h"

/**
 * 虚拟购物车--与HASopCart不同在于支持商户分类概念
 */

@interface HAVShopCart : NSObject

//当前购物车
+ (id)defaultShopCart;

//- (void)add:(HASKUProduct *) skuProduct;//更好点

//添加商品
- (void)addProduct:(id<HAProductSKU>) product;

//移除商品
- (void)removeProduct:(id<HAProductSKU>) product;

//移除一项商品
- (void)removeShopCartItem:(HAShopCartItem *) item;

//清空购物车
- (void)clear;

//购物车内的商品总数
- (int)countsOfProduct;

//商品清单--返回HAShopCartItem对象数组
- (NSArray *)productItemList;

//商户数量
- (int)countsOfStore;

//商户数组--返回HAVShopCartStore对象数组
- (NSArray *)storeList;

@end
