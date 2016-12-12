//
//  HAHeaderScrollView.m
//  IOSStudy
//
//  Created by hai on 14-6-24.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAHeaderScrollView.h"

@interface HAHeaderScrollView ()
{
    
    float _top;
    
}

@property (nonatomic, retain) UIImageView *backgroundImageView;

@property (nonatomic, retain) UIView *contentView;

@end

@implementation HAHeaderScrollView

- (void)dealloc
{
    [_backgroundImageView release];
    [_contentView release];
    [super dealloc];
}

- (id)initWithHeaderTop:(float) top
{
    self = [super init];
    if (self) {
        _top = top;
        CGRect frame = CGRectMake(0, top, [self screenSize].width, [self screenSize].height + ABS(top));
        self.frame = frame;
        NSLog(@"frame orgin y %f",frame.origin.y);
        self.contentSize = CGSizeMake([self screenSize].width, [self screenSize].height + ABS(top) + 1);
//        self.showsVerticalScrollIndicator = NO;
//        self.scrollsToTop = NO;
        [self setupContentView];
    }
    return self;
}

#pragma mark -- private methods

- (CGSize)screenSize
{
    return [UIScreen mainScreen].bounds.size;
}

- (void)setupContentView
{
    if (_contentView == nil) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, ABS(_top) * 2, [self screenSize].width, self.frame.size.height - ABS(_top))];
        _contentView.backgroundColor = [UIColor greenColor];
        [self insertSubview:_contentView atIndex:1];
    }
}

#pragma mark -- public methods

- (void)setBackgroundImage:(UIImage *) backgroundImage
{
    if (_backgroundImageView == nil) {
        NSLog(@"%f",self.bounds.size.height);
        _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    }
    if (_backgroundImageView != nil) {
        _backgroundImageView.image = backgroundImage;
        [self insertSubview:_backgroundImageView atIndex:0];
    }
}

- (void)setCustomView:(UIView *) customView
{
    [_contentView addSubview:customView];
}

#pragma mark -- UIScrollViewDelegate


@end
