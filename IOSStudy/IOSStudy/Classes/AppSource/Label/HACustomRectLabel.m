//
//  HACustomRectLabel.m
//  IOSStudy
//
//  Created by hai on 14-6-19.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HACustomRectLabel.h"

@implementation HACustomRectLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    NSLog(@"label bounds : (%f,%f,%f,%f)",bounds.origin.x,bounds.origin.y,bounds.size.width,bounds.size.height);
    NSLog(@"label number of lines : %d",numberOfLines);
    
    CGRect rect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];

    NSLog(@"label rect old : (%f,%f,%f,%f)",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
    //向右下方偏移10平方
    rect.origin.y += 10;
    rect.origin.x += 10;
    
    //字体rect向下10，字体位置再向下移动10
    
    rect.size.width -= 20;
    rect.size.height += 10;
    
    //高度增加20，字体rect显示默认居中，所以会略偏下
    
    NSLog(@"label rect new : (%f,%f,%f,%f)",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
    
    return rect;
}

//必须在这个方法里面调用
- (void)drawTextInRect:(CGRect)rect
{
    NSLog(@"draw text ");
    CGRect newRect = [self textRectForBounds:rect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:newRect];
}

@end
