//
//  UIScrollView+LoadingFooter.h
//  VANCL
//
//  Created by haiwang on 14-12-17.
//  Copyright (c) 2014年 vancl.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (LoadingFooter)

- (void)addLoadingFooter;

- (void)removeLoadingFooter;

- (void)updateLoadingFooter;

- (float)heightWithFooterView;

@end
