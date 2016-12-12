//
//  HACA3DView.m
//  IOSStudy
//
//  Created by hai on 14-7-10.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HACA3DView.h"

@implementation HACA3DView

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

-  (void)add3DCAAnimation
{
    //创建基本的y轴旋转动画
    CABasicAnimation *flip = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    flip.toValue = [NSNumber numberWithDouble:M_PI];
    
    //创建基本的缩放动画
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.toValue = [NSNumber numberWithDouble:0.9f];
    scale.duration = 0.5;
    scale.autoreverses = YES;
    
    CABasicAnimation *color = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    color.toValue = (id)[UIColor redColor].CGColor;
    color.duration = 1;
    color.autoreverses = YES;
    
    //将旋转和缩放合并到一个动画组
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObjects:flip,scale,color, nil];
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.duration = 1;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    
    group.repeatCount = 50;
    //添加动画到层中
    [self.layer addAnimation:group forKey:@"flip"];
}

//3d透视效果
- (void)add3dPerspectiveAnimation
{
    //重新设置描点
    self.layer.anchorPoint = CGPointMake(1, 0.5);
    //创建基本的y轴旋转动画
    CABasicAnimation *flip = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    flip.toValue = [NSNumber numberWithDouble:M_PI];
    flip.duration = 1.5;
    flip.repeatCount = 40;
    
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0f/1000.0f;
    perspective = CATransform3DRotate(perspective, 0, 0, 1, 0);
    self.layer.transform = perspective;
    
    [self.layer addAnimation:flip forKey:@"flip"];
}

@end
