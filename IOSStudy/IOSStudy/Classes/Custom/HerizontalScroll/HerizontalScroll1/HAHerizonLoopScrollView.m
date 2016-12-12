//
//  HAHerizonLoopScrollView.m
//  IOSStudy
//
//  Created by hai on 14-6-26.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAHerizonLoopScrollView.h"

const float loopWith = 320.0f;

const float loopHeight = 200.0f;

const float pageControlPointH = 20.0f;

@interface HAHerizonLoopScrollView ()<UIScrollViewDelegate>

@property (nonatomic, retain) UIScrollView *herizonScrollView;

@property (nonatomic, retain) UIPageControl *pageControll;

@property (nonatomic, retain) NSArray *imageArray;

@property (nonatomic, assign) int countsOfPage;

@property (nonatomic, assign) int currentIndex;

@end


@implementation HAHerizonLoopScrollView

#pragma mark -- init methods

- (void)dealloc
{
    [_herizonScrollView release];
    [_pageControll release];
    [_imageArray release];
    [super dealloc];
}

- (id)initWithImages:(NSArray *) imageArray
{
    self = [super initWithFrame:CGRectMake(0, 0, loopWith, loopHeight)];
    if (self) {
        _imageArray = [imageArray retain];
        _countsOfPage = _imageArray.count;
        [self initScrollView];
        [self initPageControl];
        [self initImageViewForScrollViewContent];
    }
    return self;
}

- (void)initScrollView
{
    _herizonScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, loopWith, loopHeight)];
    _herizonScrollView.backgroundColor = [UIColor orangeColor];
    _herizonScrollView.contentSize = CGSizeMake(loopWith * (_countsOfPage + 2), loopHeight);
    _herizonScrollView.bounces = NO;
    _herizonScrollView.showsHorizontalScrollIndicator = NO;
    _herizonScrollView.showsVerticalScrollIndicator = NO;
    _herizonScrollView.delegate = self;
//    _herizonScrollView.pagingEnabled = YES;//此属性决定scrollview是否能够自动响应分页式的滑动，自动滑动到每一块的起点
    [self addSubview:_herizonScrollView];
}

- (void)initPageControl
{
    _pageControll = [[UIPageControl alloc] init];
    _pageControll.bounds = CGRectMake(0, 0, 10.0f * _countsOfPage, 30.0f);
    _pageControll.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height - pageControlPointH);
    _pageControll.backgroundColor = [UIColor clearColor];
    _pageControll.numberOfPages = _countsOfPage;
    _pageControll.currentPage = 0;
    [self addSubview:_pageControll];
}

- (void)initImageViewForScrollViewContent
{
    if (_countsOfPage > 0) {
        for (int i = 0 ; i < _countsOfPage; i ++) {
            id object = _imageArray[i];
            if ([object isKindOfClass:[UIImage class]]) {
                UIImage *image = object;
                UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                imageView.frame = CGRectMake(loopWith * (i + 1), 0, loopWith, loopHeight);
                [_herizonScrollView addSubview:imageView];
                [imageView release];
            }
        }
        id object1 = _imageArray[_imageArray.count - 1];
        if ([object1 isKindOfClass:[UIImage class]]) {
            UIImage *firstImage = object1;
            UIImageView *imageView = [[UIImageView alloc] initWithImage:firstImage];
            imageView.frame = CGRectMake(0, 0, loopWith, loopHeight);
            [_herizonScrollView addSubview:imageView];
            [imageView release];
        }
        id object2 = _imageArray[0];
        if ([object2 isKindOfClass:[UIImage class]]) {
            UIImage *lastImage = object2;
            UIImageView *imageView = [[UIImageView alloc] initWithImage:lastImage];
            imageView.frame = CGRectMake(loopWith * (_countsOfPage + 1), 0, loopWith, loopHeight);
            [_herizonScrollView addSubview:imageView];
            [imageView release];
        }
    }
    [_herizonScrollView setContentOffset:CGPointMake(loopWith, 0) animated:YES];
}

#pragma mark -- private methods

- (void)nextPageWithCurrentOffSet:(CGPoint) offsetPoint
{
    //    NSLog(@"offsetPoint:(%f,%f)",offsetPoint.x,offsetPoint.y);
    //    _currentIndex = offsetPoint.x / loopWith;
    if (offsetPoint.x <= loopWith) {
        [_herizonScrollView setContentOffset:CGPointMake(loopWith * _countsOfPage, 0) animated:NO];
    }else if (offsetPoint.x >= loopWith * _countsOfPage){
        [_herizonScrollView setContentOffset:CGPointMake(loopWith, 0) animated:NO];
    }else{
    }
//    _pageControll.currentPage = _currentIndex;
}

#pragma mark -- UIScrollViewDelegate

float startP,endP;

//scrollView滚动时，就调用该方法。任何offset值改变都调用该方法。即滚动过程中，调用多次
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGPoint offSet = scrollView.contentOffset;
//    NSLog(@"scroll done : (%f,%f)",offSet.x,offSet.y);
}

// 当开始滚动视图时，执行该方法。一次有效滑动（开始滑动，滑动一小段距离，只要手指不松开，只算一次滑动），只执行一次。
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"scroll begin drag");
    startP = scrollView.contentOffset.x;
}

// 滑动scrollView，并且手指离开时执行。一次有效滑动，只执行一次。
// 当pagingEnabled属性为YES时，不调用，该方法
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    NSLog(@"scroll will end drag");
}

// 滑动视图，当手指离开屏幕那一霎那，调用该方法。一次有效滑动，只执行一次。
// decelerate,指代，当我们手指离开那一瞬后，视图是否还将继续向前滚动（一段距离），经过测试，decelerate=YES
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"scroll did end drag");
    endP = scrollView.contentOffset.x;
    bool isRight = endP - startP > 0;
    if (isRight) {
        [_herizonScrollView setContentOffset:CGPointMake(loopWith * (endP / loopWith + 1), 0) animated:YES];
    }else{
        [_herizonScrollView setContentOffset:CGPointMake(loopWith * (endP / loopWith), 0) animated:YES];
    }
    
}

// 滑动减速时调用该方法。
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDecelerating");
    // 该方法在scrollViewDidEndDragging方法之后。
}

// 滚动视图减速完成，滚动将停止时，调用该方法。一次有效滑动，只执行一次。
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating");
    [self nextPageWithCurrentOffSet:scrollView.contentOffset];
}



// 当scrollView缩放时，调用该方法。在缩放过程中，回多次调用
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidScroll");
    float value=scrollView.zoomScale;
    NSLog(@"%f",value);
}

// 当滚动视图动画完成后，调用该方法，如果没有动画，那么该方法将不被调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndScrollingAnimation");
    // 有效的动画方法为：
    // - (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated 方法
    // - (void)scrollRectToVisible:(CGRect)rect animated:(BOOL)animated 方法
}

// 返回将要缩放的UIView对象。要执行多次
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    NSLog(@"viewForZoomingInScrollView");
    return nil;
}

// 当将要开始缩放时，执行该方法。一次有效缩放，就只执行一次。
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    NSLog(@"scrollViewWillBeginZooming");
}

// 当缩放结束后，并且缩放大小回到minimumZoomScale与maximumZoomScale之间后（我们也许会超出缩放范围），调用该方法。
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    NSLog(@"scrollViewDidEndZooming");
}

// 指示当用户点击状态栏后，滚动视图是否能够滚动到顶部。需要设置滚动视图的属性：_scrollView.scrollsToTop=YES;
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    return YES;
}

// 当滚动视图滚动到最顶端后，执行该方法
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidScrollToTop");
}

@end
