//
//  HASKUProduct.h
//  IOSStudy
//
//  Created by hai on 14-7-2.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HAProduct.h"

//sku商品协议，确立实际性以及唯一性
@protocol HAProductSKU <NSObject>

@end
/**
 * 最小商品单位，
 * 实际概念,可操作，唯一性
 * 使用尺码和颜色来区分sku
 */

@interface HASKUProduct : HAProduct<HAProductSKU>

//@interface HASKUProduct : NSObject

//最小计量单位
@property (nonatomic, copy) NSString *sku;

//@property (nonatomic, copy) NSString *productId;
//
//@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) float size;

@property (nonatomic, copy) NSString *color;

//@property (nonatomic, retain) NSArray *imageArray;
//
//@property (nonatomic, assign) float price;
//
////库存
//@property (nonatomic, assign) int storage;
//
//@property (nonatomic, copy) NSString *descript;
//
////品牌
//@property (nonatomic, copy) NSString *branch;
//
////商户id
//@property (nonatomic, copy) NSString *storeId;
//
////商户名称
//@property (nonatomic, copy) NSString *storeName;

@end
