//
//  HAVShopCart.m
//  IOSStudy
//
//  Created by hai on 14-7-2.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAVShopCart.h"
#import "HAVShopCartStore.h"

@interface HAVShopCart()

//商品清单列表
@property (nonatomic, retain) NSMutableArray *productListArray;

@property (nonatomic, retain) NSMutableArray *storeArray;

@end

@implementation HAVShopCart

static HAVShopCart *defaultShopCart;

#pragma mark -- init methods

- (void)dealloc
{
    [_productListArray release];
    [_storeArray release];
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        _productListArray = [[NSMutableArray array] retain];
    }
    return self;
}

#pragma mark -- private methods

//购物车中是否包含这个sku的商品
- (BOOL)isContainWithProduct:(id<HAProductSKU>) product
{
    if (product != nil) {
        for (HAShopCartItem *item in _productListArray) {
            HASKUProduct *skuProduct = item.skuProduct;
            if ([skuProduct isEqual:item]) {
                return YES;
            }
        }
    }
    return NO;
}

- (void)productItemAdd:(id<HAProductSKU>) product
{
    if (product != nil) {
        BOOL isHave = NO;
        for (HAShopCartItem *item in _productListArray) {
            HASKUProduct *skuProduct = item.skuProduct;
            if ([skuProduct isEqual:product]) {
                isHave = YES;
                item.counts++;
                break;
            }
        }
        if (isHave == NO) {
            HAShopCartItem *item = [[HAShopCartItem alloc] init];
            item.skuProduct = (HASKUProduct*)product;
            item.counts = 1;
            [_productListArray addObject:item];
            [item release];
        }
    }
}

- (void)productItemRemove:(id<HAProductSKU>) product
{
    if (product != nil) {
        BOOL isHave = NO;
        HAShopCartItem *removeItem;
        for (HAShopCartItem *item in _productListArray) {
            HASKUProduct *skuProduct = item.skuProduct;
            if ([skuProduct isEqual:product]) {
                removeItem = [item retain];
                isHave = YES;
                break;
            }
        }
        if (isHave == YES) {
            if (removeItem.counts > 1) {
                removeItem.counts--;
            }else{
                [_productListArray removeObject:removeItem];
                [removeItem release];
            }
        }
    }
}

#pragma mark -- public methods

//当前购物车
+ (id)defaultShopCart
{
    @synchronized(self){
        if (defaultShopCart == nil) {
            defaultShopCart = [[HAVShopCart alloc] init];
        }
        return defaultShopCart;
    }
}

//添加商品
- (void)addProduct:(id<HAProductSKU>) product
{
    @synchronized(self){
        [self productItemAdd:product];
    }
}

//移除商品
- (void)removeProduct:(id<HAProductSKU>) product
{
    @synchronized(self){
        [self productItemRemove:product];
    }
}

//移除一项商品
- (void)removeShopCartItem:(HAShopCartItem *) item
{
    [_productListArray removeObject:item];
}

//购物车内的商品总数
- (int)countsOfProduct
{
    int total = 0;
    for (HAShopCartItem *item in _productListArray) {
        if (item.counts != 0) {
            total += item.counts;
        }else{
            NSLog(@"HAVShopCart Error: some productItem counts = 0.");
        }
    }
    return total;
}

//清空购物车
- (void)clear
{
    [_storeArray removeAllObjects];
    [_productListArray removeAllObjects];
}

//商品清单
- (NSArray *)productItemList
{
    return _productListArray;
}

- (int)countsOfStore
{
    return _storeArray.count;
}

- (NSArray *)storeList
{
    self.storeArray = [NSMutableArray array];
    for (HAShopCartItem *item in _productListArray) {
        BOOL isHave = NO;
        for (HAVShopCartStore *store in _storeArray) {
            if ([store.storeId isEqualToString:item.skuProduct.storeId]) {
                isHave = YES;
                break;
            }
        }
        if (isHave == NO) {
            HAVShopCartStore *store = [[HAVShopCartStore alloc] init];
            store.storeId = item.skuProduct.storeId;
            store.storeName = item.skuProduct.storeName;
            [_storeArray addObject:store];
            [store release];
        }
    }
    for (HAVShopCartStore *store in _storeArray) {
        for (HAShopCartItem *item in _productListArray) {
            if ([store.storeId isEqualToString:item.skuProduct.storeId]) {
                [store.productItemArray addObject:item];
            }
        }
    }
    return _storeArray;
}

@end
