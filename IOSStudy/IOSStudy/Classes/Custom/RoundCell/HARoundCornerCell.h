//
//  HARoundCornerCell.h
//  IOSStudy
//
//  Created by haiwang on 15-4-2.
//  Copyright (c) 2015年 hai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HARoundCornerCell : UITableViewCell

@property (nonatomic, retain) UIColor *roundBackgroundColor;

@property (nonatomic, retain) UIColor *borderColor;

@property (nonatomic, assign) CGFloat padding;

@property (nonatomic, assign) CGFloat corner;

- (void)setTopCellStyle;

- (void)setMiddleCellStyle;

- (void)setBottomCellStyle;

- (void)setSingleCellStyle;

//根据数据数量以及位置索引设置cell风格
- (void)setCellStyleWithDataCounts:(NSInteger) count andIndex:(NSInteger) index;

@end
