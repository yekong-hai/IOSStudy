//
//  HACGView.m
//  IOSStudy
//
//  Created by hai on 14-7-9.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HACGView.h"

@implementation HACGView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [self addRect];
//    [self addImage];
}

- (void)addRect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(20, 40, 50, 50) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
//    CGContextStrokeRectWithWidth(context, re, <#CGFloat width#>)
//    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
//    CGContextSetLineWidth(context, 2.0f);
    [path fill];
}

//一个泪滴形状
- (void)addleidi
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(160.0f, 20.0f)];
    [path addLineToPoint:CGPointMake(260, 340)];
    [path addArcWithCenter:CGPointMake(160, 340) radius:100 startAngle:0 endAngle:M_PI clockwise:YES];
    [path closePath];
    [path fill];
}

- (void)addImage
{
    UIImage *image = [UIImage imageNamed:@"icon.png"];
    [image drawInRect:CGRectMake(10, 20, 200, 50)];//图片填充rect，不管比例，这是与imageview的区别
}

@end
