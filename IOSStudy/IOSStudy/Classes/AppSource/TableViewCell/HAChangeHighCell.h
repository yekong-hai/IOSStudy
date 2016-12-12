//
//  HAChangeHighCell.h
//  IOSStudy
//
//  Created by hai on 14-6-25.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HAChangeHighCell : UITableViewCell

- (void)setData:(NSString *) title withDescription:(NSString *) description;

//获取cell的高度
- (CGFloat)heightWithCell;

+ (CGFloat)heightWithCellNormal;

+ (CGFloat)heightWithCellSelect;

//展开
- (void)show:(BOOL) isShow;

@end
