//
//  HAXibView.m
//  IOSStudy
//
//  Created by hai on 14-7-14.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAXibView.h"

@interface HAXibView ()

@property (nonatomic, retain) UIView *containerView;

@end

@implementation HAXibView

- (void)dealloc
{
    [_containerView release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //直接add这个containerview是不行的，因为xib文件还没有加载
//        [self addSubview:_containerView];

        [self loadXibView];
    }
    return self;
}

- (void)loadXibView
{
    //view文件与xib配置造view，只能先加载xib然后再赋值了
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"HAXibView" owner:self options:nil];
    UIView *firstView = views[0];
    _containerView = [firstView retain];
    [self addSubview:_containerView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
