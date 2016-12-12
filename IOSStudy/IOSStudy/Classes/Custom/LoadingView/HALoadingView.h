//
//  HALoadingView.h
//  IOSStudy
//
//  Created by haiwang on 14-7-7.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HALoadingView;

@protocol HALoadingViewDelegate <NSObject>

- (void)onTapForLoadingView:(HALoadingView *) loadingView;

@end

/**
 * 简单的loadingview，加载视图
 */
@interface HALoadingView : UIView

@property (nonatomic, assign) BOOL isCancelOnTouch;

@property (nonatomic, assign) id<HALoadingViewDelegate> delegate;

- (id)initWithTitle:(NSString *) title;

- (id)initWithOnTap:(void(^)(HALoadingView * loadingView)) onTapBlock;

//显示loadingview
- (void)showLoadingView;

//隐藏loadingview
- (void)hiddenLoadingView;


@end
