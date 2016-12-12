//
//  HAProduct.h
//  IOSStudy
//
//  Created by hai on 14-7-2.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 商品协议
 */

@protocol HAProduct <NSObject>


@end
/**
 * 商品---产品
 * 抽象概念
 */

@interface HAProduct : NSObject<HAProduct>

@property (nonatomic, copy) NSString *productId;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) float price;

//库存
@property (nonatomic, assign) int storage;

@property (nonatomic, copy) NSString *descript;

//评分
@property (nonatomic, assign) float score;

//所有尺码
@property (nonatomic, retain) NSArray *sizeArray;

//所有图片
@property (nonatomic, retain) NSArray *imageArray;

//所有颜色
@property (nonatomic, retain) NSArray *colorArray;

//品牌
@property (nonatomic, copy) NSString *branch;

//商户id
@property (nonatomic, copy) NSString *storeId;

//商户名称
@property (nonatomic, copy) NSString *storeName;

//商户是否相同
- (BOOL)isEqualForStore:(HAProduct *) product;

@end
