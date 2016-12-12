//
//  HAProductItemCell.h
//  IOSStudy
//
//  Created by hai on 14-7-2.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HAShopCartItem.h"

@interface HAProductItemCell : UITableViewCell

- (void)updateData:(HAShopCartItem *) productItem;

@end
