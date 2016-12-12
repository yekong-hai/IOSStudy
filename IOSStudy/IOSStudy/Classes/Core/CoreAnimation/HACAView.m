//
//  HACAView.m
//  IOSStudy
//
//  Created by haiwang on 14-7-9.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HACAView.h"
#import <QuartzCore/QuartzCore.h>

@implementation HACAView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)changeLayerColor
{
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.toValue = (id)[UIColor redColor].CGColor;
    animation.duration = 1;
    animation.autoreverses = YES;//自动反转动画
    [self.layer addAnimation:animation forKey:@"backgroundColor"];//这个key非常重要，应当与要设置用来进行动画的属性名称一致。
    //key-value编码
}

//关键帧动画
- (void)setKeyFrameAnimation
{
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animation];
    keyFrameAnimation.values = [NSArray arrayWithObjects:
                                (id)self.backgroundColor.CGColor,
                                (id)[UIColor redColor].CGColor,
                                (id)[UIColor greenColor].CGColor,
                                (id)[UIColor orangeColor].CGColor, nil];
    keyFrameAnimation.duration = 3;
    keyFrameAnimation.autoreverses = YES;
    [self.layer addAnimation:keyFrameAnimation forKey:@"backgroundColor"];
}

//path路径
- (void)addPathAnimation
{
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
    CGMutablePathRef mPath = CGPathCreateMutable();
    CGPathMoveToPoint(mPath, nil, 20, 20);
    CGPathAddCurveToPoint(mPath, nil, 160, 30, 220, 220, 240, 380);
    keyAnimation.path = mPath;
    keyAnimation.duration = 1;
    keyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    keyAnimation.rotationMode = @"auto";
    [self.layer addAnimation:keyAnimation forKey:@"position"];
    CFRelease(mPath);
}

@end
