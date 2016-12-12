//
//  HAHerizonLoopView.h
//  IOSStudy
//
//  Created by hai on 14-6-27.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 * 水平无缝循环滚动的view
 * 广告样式的，可自动滚动
 * 暂时已经实现，但有小bug
 */

@interface HAHerizonLoopView : UIView

- (id)initWithImages:(NSArray *) imageArray withAuto:(BOOL) isAuto;

//关闭自动循环状态
- (void)closeAutoSlide;

@end
