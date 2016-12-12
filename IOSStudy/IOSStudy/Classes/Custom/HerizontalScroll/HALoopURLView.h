//
//  HALoopURLView.h
//  IOSStudy
//
//  Created by haiwang on 14-11-18.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HALoopURLView;
@protocol HALoopURLViewDelegate <NSObject>

- (void)loopUrlView:(HALoopURLView *) loopView didSelectAtIndex:(int) index;

@end

/**
 * 水平自动无缝循环滚动scrollview，广告效果
 * 一个scrollview，3个子imageview，一个图片数组images，滑动后更换3个imageview的图片。
 */
@interface HALoopURLView : UIView

@property (nonatomic, assign) id<HALoopURLViewDelegate> delegate;

- (id)initWithImageUrls:(NSArray *) imageUrlArray withAuto:(BOOL) isAuto;

- (id)initWithImageUrls:(NSArray *) imageUrlArray defaultImage:(UIImage *) image withAuto:(BOOL) isAuto;

@end
