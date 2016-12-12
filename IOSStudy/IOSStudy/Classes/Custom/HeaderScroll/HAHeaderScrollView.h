//
//  HAHeaderScrollView.h
//  IOSStudy
//
//  Created by hai on 14-6-24.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 类似网上的，微信的下拉scrollview，上面有个背景，在拉的过程中不断长度变大，顶部的往下来，下面的接着往下去
 * 这个原本是照这个思想来做的，后来发现白色的contentview没有拉动背景的效果
 */

@interface HAHeaderScrollView : UIScrollView

- (id)initWithHeaderTop:(float) top;

- (void)setBackgroundImage:(UIImage *) backgroundImage;

- (void)setCustomView:(UIView *) customView;

@end
