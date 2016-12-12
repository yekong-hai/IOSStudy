//
//  HAHerizonLoopView.m
//  IOSStudy
//
//  Created by hai on 14-6-27.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAHerizonLoopView.h"

const float lWidth = 320.0f;

const float lHeight = 200.0f;

const float pageControlOriH = 20.0f;

@interface HAHerizonLoopView ()<UIScrollViewDelegate>
{
    CGPoint _startOffSet;
    CGPoint _endOffSet;
    NSArray *_sourceImageArray;
    NSDate *_startTime;
    NSDate *_endTime;
    BOOL _isAuto;
}

@property (nonatomic, retain) UIScrollView *herizonScrollView;

@property (nonatomic, retain) UIPageControl *pageControll;

@property (nonatomic, retain) NSMutableArray *imageArray;

@property (nonatomic, assign) int countsOfPage;

@property (nonatomic, assign) int currentIndex;

@property (nonatomic, retain) NSTimer *autoSlideTimer;

@end

@implementation HAHerizonLoopView

#pragma mark -- init methods

- (void)dealloc
{
    [_herizonScrollView release];
    [_pageControll release];
    [_imageArray release];
    [_sourceImageArray release];
    [_startTime release];
    [_endTime release];
    if ([_autoSlideTimer isValid]) {
        [_autoSlideTimer invalidate];
    }
    [_autoSlideTimer release];
    [super dealloc];
}

- (id)initWithImages:(NSArray *) imageArray withAuto:(BOOL) isAuto
{
    self = [super initWithFrame:CGRectMake(0, 0, lWidth, lHeight)];
    if (self) {
        [self initSourceImageArray:imageArray];
        _imageArray = [[NSMutableArray arrayWithArray:imageArray] retain];
        _countsOfPage = _imageArray.count;
        [self initScrollView];
        [self initPageControl];
        [self resetImagesOrder];
        [self initImageViewForScrollViewContent];
        if (isAuto) {
            _isAuto = isAuto;
            [self delayInitTimer];
        }
    }
    return self;
}

- (void)initSourceImageArray:(NSArray *) imageArray
{
    NSMutableArray *tArray = [NSMutableArray array];
    for (int i = 0; i < imageArray.count ; i++) {
        UIImage *image = imageArray[i];
        NSLog(@"%@",[image description]);
        [tArray addObject:image];
    }
    _sourceImageArray = [tArray retain];
}

- (void)initScrollView
{
    _herizonScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, lWidth, lHeight)];
    _herizonScrollView.backgroundColor = [UIColor orangeColor];
    _herizonScrollView.contentSize = CGSizeMake(lWidth * _countsOfPage, lHeight);
    _herizonScrollView.bounces = NO;
    _herizonScrollView.showsHorizontalScrollIndicator = NO;
    _herizonScrollView.showsVerticalScrollIndicator = NO;
    _herizonScrollView.delegate = self;
//    _herizonScrollView.canCancelContentTouches = NO;
    _herizonScrollView.pagingEnabled = YES;//此属性决定scrollview是否能够自动响应分页式的滑动，自动滑动到每一块的起点
    [self addSubview:_herizonScrollView];
}

- (void)initPageControl
{
    _pageControll = [[UIPageControl alloc] init];
    _pageControll.bounds = CGRectMake(0, 0, 10.0f * _countsOfPage, 30.0f);
    _pageControll.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height - pageControlOriH);
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
                imageView.frame = CGRectMake(lWidth * i, 0, lWidth, lHeight);
                [_herizonScrollView addSubview:imageView];
                [imageView release];
            }
        }
    }
    [_herizonScrollView setContentOffset:CGPointMake(lWidth, 0) animated:NO];
}

- (void)delayInitTimer
{
    [self performSelector:@selector(initAutoSlideTimer) withObject:nil afterDelay:3];
}

- (void)initAutoSlideTimer
{
    _autoSlideTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [_autoSlideTimer fire];
}

#pragma mark -- public methods

- (void)closeAutoSlide
{
    if (_autoSlideTimer) {
        [_autoSlideTimer invalidate];
    }
}

#pragma mark -- private methods

- (void)nextPage
{
    [_herizonScrollView setContentOffset:CGPointMake(_herizonScrollView.contentOffset.x + lWidth, 0) animated:YES];
}

//重置图片数组的图片的顺序，为中间显示做准备
- (void)resetImagesOrder
{
    if (_imageArray.count > 0) {
        NSMutableArray *newImageArray = [NSMutableArray arrayWithCapacity:_imageArray.count];
        for (int i = 0; i < _imageArray.count; i++) {
            [newImageArray addObject:@""];
        }
        for (int i = 0; i < _imageArray.count - 1; i ++) {
            id image = _imageArray[i];
            [newImageArray replaceObjectAtIndex:i+1 withObject:image];
        }
        [newImageArray replaceObjectAtIndex:0 withObject:_imageArray[_imageArray.count-1]];
        self.imageArray = newImageArray;
    }
}

- (void)locationToCenter
{
    //暂时3个
    BOOL isLeftSlideToRight = _endOffSet.x - _startOffSet.x > 0?YES:NO;//左滑右去
    if (isLeftSlideToRight == NO) {
        [_herizonScrollView setContentOffset:CGPointMake(lWidth, 0) animated:NO];
    }else{
        [_herizonScrollView setContentOffset:CGPointMake(lWidth * (_imageArray.count - 2), 0) animated:NO];
    }
}

//改变图片
- (void)changeImages
{
    BOOL isLeftSlideToRight = _endOffSet.x - _startOffSet.x > 0?YES:NO;//左滑右去
    if (isLeftSlideToRight) {
        [self moveImagesToLeft];
    }else{
        [self moveImagesToRight];
    }
}

- (void)moveImagesToRight
{
    for (UIImageView *imageView in _herizonScrollView.subviews) {
        CGRect originFrame = imageView.frame;
        originFrame.origin.x += lWidth;
        if (originFrame.origin.x >= _herizonScrollView.contentSize.width) {
            originFrame.origin.x = 0;
        }
        imageView.frame = originFrame;
    }
}

- (void)moveImagesToLeft
{
    for (UIImageView *imageView in _herizonScrollView.subviews) {
        CGRect originFrame = imageView.frame;
        originFrame.origin.x -= lWidth;
        if (originFrame.origin.x < 0) {
            originFrame.origin.x = _herizonScrollView.contentSize.width - lWidth;
        }
        imageView.frame = originFrame;
    }
}

- (void)nextPageWithCurrentVisiableImageView
{
//    for (UIImageView *imageView in _herizonScrollView.subviews) {
//        CGPoint viewPoint = [self convertPoint:imageView.frame.origin toView:self];
//        if (viewPoint.x == 0) {
//            UIImage *image = imageView.image;
//            NSLog(@"%@",[image description]);
//            _currentIndex = [_sourceImageArray indexOfObject:image];
//            break;
//        }
//    }
    if (_endOffSet.x - _startOffSet.x == lWidth) {
        _currentIndex++;
    }else if (_startOffSet.x - _endOffSet.x == lWidth){
        _currentIndex--;
    }else{
        
    }
//    BOOL isLeftSlideToRight = _endOffSet.x - _startOffSet.x > 0?YES:NO;//左滑右去
//    if (isLeftSlideToRight) {
//        _currentIndex++;
//    }else{
//        _currentIndex--;
//    }
    _currentIndex = _currentIndex%_imageArray.count;
    _pageControll.currentPage = _currentIndex;
}

- (BOOL)isCloseToBoundary
{
    if (_endOffSet.x <= 0 || _endOffSet.x >= (_imageArray.count-1) * lWidth) {
        return YES;
    }
    return NO;
}

//手势滑动松开后是否达到一半
- (BOOL)isEnoughHalfOfWidthForMoving
{
    //其实只存在2种情况在滑动动画结束的时候
    //偏移一个宽度
    //没有偏移---回去了
    if (ABS(_endOffSet.x - _startOffSet.x) > lWidth / 2) {
        return YES;
    }
    return NO;
}

#pragma mark -- UIScrollViewDelegate

//scrollView滚动时，就调用该方法。任何offset值改变都调用该方法。即滚动过程中，调用多次
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offSet = scrollView.contentOffset;
    NSLog(@"scroll done : (%f,%f)",offSet.x,offSet.y);
}

// 当开始滚动视图时，执行该方法。一次有效滑动（开始滑动，滑动一小段距离，只要手指不松开，只算一次滑动），只执行一次。
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"scroll begin drag");
    _startOffSet = scrollView.contentOffset;
//    if (_startTime) {
//        [_startTime release];
//    }
//    _startTime = [[NSDate date] retain];
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
    _endOffSet = scrollView.contentOffset;
//    if (_endTime) {
//        [_endTime release];
//    }
//    _endTime = [[NSDate date] retain];
//    double time = [_endTime timeIntervalSinceDate:_startTime];
//    if (time < 0.1) {
//        return;
//    }
    if ([self isCloseToBoundary]) {
        [self locationToCenter];
        [self changeImages];
    }
    [self nextPageWithCurrentVisiableImageView];
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
    if (_isAuto && _herizonScrollView) {
        if (_herizonScrollView.contentOffset.x >= lWidth *(_imageArray.count - 1)) {
            [_herizonScrollView setContentOffset:CGPointMake(lWidth * (_imageArray.count - 2), 0) animated:NO];
            [self moveImagesToLeft];
        }
        _currentIndex++;
        _currentIndex = _currentIndex%_imageArray.count;
        _pageControll.currentPage = _currentIndex;
    }
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
