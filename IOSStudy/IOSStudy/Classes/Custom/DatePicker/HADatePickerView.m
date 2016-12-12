//
//  HADatePickerView.m
//  IOSStudy
//
//  Created by haiwang on 14-8-31.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HADatePickerView.h"

#define NAV_VIEW_HEIGHT 50.0f


@implementation HADatePickerView

#pragma mark -- init methods

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

#pragma mark -- private methods

- (void)setupViews
{
    
}

- (void)setupNavView
{
    UIImageView *navBgImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, NAV_VIEW_HEIGHT)] autorelease];
    navBgImageView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:navBgImageView];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftButton.frame = 
}

@end
