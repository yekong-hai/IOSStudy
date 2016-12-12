//
//  HAVShopCartStore.h
//  IOSStudy
//
//  Created by hai on 14-7-2.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 商户
 */

@interface HAVShopCartStore : NSObject

@property (nonatomic, copy) NSString *storeId;

@property (nonatomic, copy) NSString *storeName;

@property (nonatomic, retain) NSMutableArray *productItemArray;

@end
