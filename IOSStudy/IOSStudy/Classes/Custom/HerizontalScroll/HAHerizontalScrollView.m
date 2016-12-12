//
//  HAHerizontalScrollView.m
//  IOSStudy
//
//  Created by hai on 14-6-26.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAHerizontalScrollView.h"

const float screenWith = 320.0f;

const float screenHeight = 300.0f;

const float pageControlBottom = 50.0f;

@interface HAHerizontalScrollView ()
{
    int _numOfImages;
}
@property (nonatomic, retain) NSArray *imageArray;

@property (nonatomic, retain) UIPageControl *pageControl;

@end

@implementation HAHerizontalScrollView

#pragma mark -- init methods

- (void)dealloc
{
    [_imageArray release];
    [_pageControl release];
    [super dealloc];
}

- (id)initWithImages:(NSArray *) imageArray
{
    self = [super initWithFrame:CGRectMake(0, 0, screenWith, screenHeight)];
    if (self) {
        _imageArray = [imageArray retain];
        _numOfImages = _imageArray.count;
        [self initScrollView];
        [self initPageControl];
    }
    return self;
}

- (void)initScrollView
{
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    //    self.scrollsToTop = NO;
    if (_imageArray && _imageArray.count > 0) {
        self.contentSize = CGSizeMake(screenWith * _numOfImages, screenHeight);
    }
}

- (void)initPageControl
{
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.bounds.size.width / 2, self.bounds.size.height - pageControlBottom, 100.0f, 30.0f)];
    _pageControl.backgroundColor = [UIColor redColor];
    _pageControl.numberOfPages = _numOfImages;
    [self addSubview:_pageControl];
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
