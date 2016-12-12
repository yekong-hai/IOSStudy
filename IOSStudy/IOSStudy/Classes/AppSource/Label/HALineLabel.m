//
//  HALineLabel.m
//  IOSStudy
//
//  Created by hai on 14-6-25.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HALineLabel.h"

@implementation HALineLabel

#pragma mark -- init methods

- (void)dealloc
{
    [_lineColor release];
    [super dealloc];
}

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
    [super drawRect:rect];
    switch (_lineType) {
        case HALineDiagonalType:
            [self drawDiagonalLine];
            break;
        case HALineHorizontalBottomType:
            [self drawHorizontalBottomLine];
            break;
        case HALineHorizontalCenterType:
        default:
            [self drawHorizontalCenterLine];
            break;
    }
}

#pragma mark -- lifecycle methods

//画底部横线
- (void)drawHorizontalBottomLine
{
    CGContextRef currentContextRef = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(currentContextRef, _lineWith);
    CGContextSetStrokeColorWithColor(currentContextRef, _lineColor.CGColor);
    CGContextMoveToPoint(currentContextRef, 0, self.bounds.size.height - _lineWith);
    CGContextAddLineToPoint(currentContextRef, self.bounds.size.width, self.bounds.size.height - _lineWith);
    CGContextStrokePath(currentContextRef);
}

//画水平居中的横线
- (void)drawHorizontalCenterLine
{
    CGContextRef currentContextRef = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(currentContextRef, _lineWith);
    CGContextSetStrokeColorWithColor(currentContextRef, _lineColor.CGColor);
    CGContextMoveToPoint(currentContextRef, 0, self.bounds.size.height/2);
    CGContextAddLineToPoint(currentContextRef, self.bounds.size.width, self.bounds.size.height/2);
    CGContextStrokePath(currentContextRef);
}

//画斜对角线
- (void)drawDiagonalLine
{
    CGContextRef currentContextRef = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(currentContextRef, _lineWith);
    CGContextSetStrokeColorWithColor(currentContextRef, _lineColor.CGColor);
    CGContextMoveToPoint(currentContextRef, 0, 3);
    CGContextAddLineToPoint(currentContextRef, self.bounds.size.width, self.bounds.size.height - 3);
    CGContextStrokePath(currentContextRef);
}

#pragma mark -- public methods

- (void)setLineWith:(float)lineWith
{
    if (lineWith == 0) {
        lineWith = 1.0f;
    }
    _lineWith = lineWith;
}

@end
