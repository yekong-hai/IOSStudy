//
//  HAIconView.m
//  IOSStudy
//
//  Created by hai on 14-7-9.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAIconView.h"
#import <Foundation/Foundation.h>

@implementation HAIconView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//每一步操作都是针对当前context，
- (void)drawRect:(CGRect)rect
{
    //绘制有阴影的圆角矩形
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect myRect = CGRectMake(40, 80, 200, 200);
    UIBezierPath *bPath = [UIBezierPath bezierPathWithRoundedRect:myRect cornerRadius:30.0f];
    CGContextSetShadow(context, CGSizeMake(0, 5), 10);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    [bPath fill];
    
    //在裁剪之前保存这个状态到栈中
//    CGContextSaveGState(context);
    
    //按照path进行裁剪
    [bPath addClip];//改动了当前上下文，变成了path之内的区域
    
//    CGContextDrawLinearGradient(context, <#CGGradientRef gradient#>, <#CGPoint startPoint#>, <#CGPoint endPoint#>, <#CGGradientDrawingOptions options#>)
    
    //恢复上下文状态----回复成裁剪之前的样子
//    CGContextRestoreGState(context);
    
    CGContextSetRGBFillColor(context, 0, 0, 1, 1);
    NSString *a = @"裁剪前后的图片，注意context状态";
    [a drawInRect:CGRectMake(0,120,320,200) withFont:[UIFont systemFontOfSize:14.0f] lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //如果没有对context进行保存和恢复，就会发现视图效果为只有根据path裁剪后的区域，字体显示不全
    
}


@end
