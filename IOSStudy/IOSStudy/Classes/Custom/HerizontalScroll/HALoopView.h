//
//  HALoopView.h
//  IOSStudy
//
//  Created by haiwang on 14-6-29.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HALoopView;
@protocol HALooViewDelegate <NSObject>

- (void)loopView:(HALoopView *) loopView didSelectAtIndex:(int) index;

@end

/**
 * 水平自动无缝循环滚动scrollview，广告效果
 * 一个scrollview，3个子imageview，一个图片数组images，滑动后更换3个imageview的图片。
 */

@interface HALoopView : UIView

@property (nonatomic, assign) id<HALooViewDelegate> delegate;

- (id)initWithImages:(NSArray *) imageArray withAuto:(BOOL) isAuto;

@end
