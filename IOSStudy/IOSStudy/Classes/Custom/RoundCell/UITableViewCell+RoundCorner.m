//
//  UITableViewCell+RoundCorner.m
//  IOSStudy
//
//  Created by haiwang on 15-4-2.
//  Copyright (c) 2015年 hai. All rights reserved.
//

#import "UITableViewCell+RoundCorner.h"
#import <objc/runtime.h>

@interface UITableViewCell (RoundBoard)

@property (nonatomic, retain) UIView *topLine;

@property (nonatomic, retain) UIView *BottomLine;

@property (nonatomic, retain) UIView *leftLine;

@property (nonatomic, retain) UIView *rightLine;

@property (nonatomic, retain) UIView *topRoundView;

@property (nonatomic, retain) UIView *bottomRoundView;

@end

@implementation UITableViewCell (RoundCorner)

static const void* UITableViewCellRoundCornerTopLineIndicatorKey = (void *)@"UITableViewCellRoundCornerTopLineIndicatorKey";

- (void)setTopLine:(UIView *)topLine
{
    objc_setAssociatedObject(self, UITableViewCellRoundCornerTopLineIndicatorKey, topLine, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)topLine
{
    return objc_getAssociatedObject(self, UITableViewCellRoundCornerTopLineIndicatorKey);
}

#pragma mark -- private methods

- (void)initTopLine
{
    self.topLine = [[UIView alloc] initWithFrame:CGRectMake(10, 0, self.bounds.size.width - 20, 1)];
}

#pragma mark -- public methods

- (void)addTopCellStyle
{
    
}

@end
