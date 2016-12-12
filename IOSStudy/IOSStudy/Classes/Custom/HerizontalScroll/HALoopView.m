//
//  HALoopView.m
//  IOSStudy
//
//  Created by haiwang on 14-6-29.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HALoopView.h"

//scrollview上的imageview的个数
#define COUNT_OF_VIEW 3

#define SECONDS_OF_SCROLL_INTERVAL 5

const float hLooWidth = 320.0f;

const float hLoopHeight = 200.0f;

const float hPageControlPointH = 20.0f;

@interface HALoopView ()<UIScrollViewDelegate>
{
    CGPoint _startOffSet;
    CGPoint _endOffSet;
    BOOL _isAuto;
}
@property (nonatomic, retain) UIScrollView *herizonScrollView;

@property (nonatomic, retain) UIImageView *leftImageView;
@property (nonatomic, retain) UIImageView *centerImageView;
@property (nonatomic, retain) UIImageView *rightImageView;

@property (nonatomic, retain) UIPageControl *pageControll;

@property (nonatomic, retain) NSArray *imageArray;

@property (nonatomic, assign) int countsOfPage;

@property (nonatomic, assign) int currentIndex;

@property (nonatomic, assign) int currentPage;

@property (nonatomic, retain) NSTimer *autoSlideTimer;

@end


@implementation HALoopView

#pragma mark -- init methods

- (void)dealloc
{
    [_herizonScrollView release];
    [_pageControll release];
    [_imageArray release];
    [_leftImageView release];
    [_centerImageView release];
    [_rightImageView release];
    _delegate = nil;
    if (_autoSlideTimer) {
        [_autoSlideTimer invalidate];
        [_autoSlideTimer release];
    }
    [super dealloc];
}

- (id)initWithImages:(NSArray *) imageArray withAuto:(BOOL) isAuto
{
    self = [super initWithFrame:CGRectMake(0, 0, hLooWidth, hLoopHeight)];
    if (self) {
        _imageArray = [imageArray retain];
        _countsOfPage = _imageArray.count;
        if (_countsOfPage < 3) {
            NSLog(@"HALoopView error: images count must than 3.");
        }
        [self initScrollView];
        [self initPageControl];
        [self resetImagesOrder];
        [self initImageViewForScrollViewContent];
        _currentPage = 0;
        _currentIndex = 1;
        if (isAuto) {
            _isAuto = isAuto;
            [self delayInitTimer];
        }

    }
    return self;
}

//性能考虑，创建一个scrollview，内带3个位置的大小
- (void)initScrollView
{
    _herizonScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, hLooWidth, hLoopHeight)];
    _herizonScrollView.backgroundColor = [UIColor orangeColor];
    _herizonScrollView.contentSize = CGSizeMake(hLooWidth * COUNT_OF_VIEW, hLoopHeight);
    _herizonScrollView.bounces = NO;
    _herizonScrollView.showsHorizontalScrollIndicator = NO;
    _herizonScrollView.showsVerticalScrollIndicator = NO;
    _herizonScrollView.delegate = self;
    _herizonScrollView.canCancelContentTouches = YES;
    _herizonScrollView.pagingEnabled = YES;//此属性决定scrollview是否能够自动响应分页式的滑动，自动滑动到每一块的起点
    [self addSubview:_herizonScrollView];
}

- (void)initPageControl
{
    _pageControll = [[UIPageControl alloc] init];
    _pageControll.bounds = CGRectMake(0, 0, 20.0f * _countsOfPage, 30.0f);
    _pageControll.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height - hPageControlPointH);
    _pageControll.backgroundColor = [UIColor clearColor];
    _pageControll.numberOfPages = _countsOfPage;
    _pageControll.currentPage = 0;
    [self addSubview:_pageControll];
}

//scrollview上创建3个固定的imageview
- (void)initImageViewForScrollViewContent
{
    for (int i = 0 ; i < COUNT_OF_VIEW; i ++) {
        UIImage *image = _imageArray[i];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(hLooWidth * i, 0, hLooWidth, hLoopHeight);
        if (i == 0) {
            self.leftImageView = imageView;
//            imageView.backgroundColor = [UIColor redColor];
        }else if (i == 1){
            self.centerImageView = imageView;
//            imageView.backgroundColor = [UIColor greenColor];
        }else{
            self.rightImageView = imageView;
//            imageView.backgroundColor = [UIColor blueColor];
        }
        [_herizonScrollView addSubview:imageView];
        [imageView release];
    }
    [self addEventForCenterImageView];
    [self locationToCenter];
}

- (void)delayInitTimer
{
    [self performSelector:@selector(initAutoSlideTimer) withObject:nil afterDelay:3];
}

- (void)initAutoSlideTimer
{
    if (_autoSlideTimer) {
        [_autoSlideTimer invalidate];
        [_autoSlideTimer release];
        _autoSlideTimer = nil;
    }
    _autoSlideTimer = [[NSTimer scheduledTimerWithTimeInterval:SECONDS_OF_SCROLL_INTERVAL target:self selector:@selector(nextPage) userInfo:nil repeats:YES] retain];
    [_autoSlideTimer fire];
}

#pragma mark -- private methods

- (void)nextPage
{
    [_herizonScrollView setContentOffset:CGPointMake(_herizonScrollView.contentOffset.x + hLooWidth, 0) animated:YES];
}

//重置图片数组的图片的顺序，为中间显示做准备
- (void)resetImagesOrder
{
    //最后一张放在数组第一个，第一张图片放在数组第二个，以此类推
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
    [_herizonScrollView setContentOffset:CGPointMake(hLooWidth, 0) animated:NO];
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
    _currentPage = [self modelValueWithIndex:(_currentIndex - 1)];
    _pageControll.currentPage = _currentPage;
}

- (int)modelValueWithIndex:(int) index
{
    int newIndex = ABS((index + _countsOfPage)) % _countsOfPage;
    return newIndex;
}

- (void)resetImage
{
    UIImage *lImage = _imageArray[[self modelValueWithIndex:_currentIndex - 1]];
    _leftImageView.image = lImage;
    UIImage *cImage = _imageArray[[self modelValueWithIndex:_currentIndex]];
    _centerImageView.image = cImage;
    UIImage *rImage = _imageArray[[self modelValueWithIndex:_currentIndex + 1]];
    _rightImageView.image = rImage;
    _currentIndex = [self modelValueWithIndex:_currentIndex];//重置index
}

- (void)moveImagesToRight
{
    _currentIndex--;
    [self resetImage];
}

- (void)moveImagesToLeft
{
    _currentIndex++;
    [self resetImage];
}


- (BOOL)isCloseToBoundary
{
    if (_endOffSet.x <= 0 || _endOffSet.x >= (COUNT_OF_VIEW - 1) * hLooWidth) {
        return YES;
    }
    return NO;
}

- (void)addEventForCenterImageView
{
    _centerImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onImageViewClicked)];
    [_centerImageView addGestureRecognizer:tapGesture];
    [tapGesture release];
}

- (void)onImageViewClicked
{
    NSLog(@"clicked image ");
    if (_delegate && [_delegate respondsToSelector:@selector(loopView:didSelectAtIndex:)]) {
        [_delegate loopView:self didSelectAtIndex:_currentPage];
    }
}

#pragma mark -- UIScrollViewDelegate

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
    _startOffSet = scrollView.contentOffset;
    //原本想，在用户主动滑动的时候停止timer来滚动scrollview，但不好控制，先去掉了
//    if (_autoSlideTimer) {
//        [_autoSlideTimer invalidate];
//        [_autoSlideTimer release];
//        _autoSlideTimer = nil;
//    }
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
    NSLog(@"scroll did end drag---- %d",decelerate);
//    [self delayInitTimer];
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
    if ([self isCloseToBoundary]) {
        [self locationToCenter];
        [self changeImages];
    }
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
        if (_herizonScrollView.contentOffset.x >= hLooWidth * (COUNT_OF_VIEW - 1)) {
            [_herizonScrollView setContentOffset:CGPointMake(hLooWidth, 0) animated:NO];
            [self moveImagesToLeft];
        }
        _currentPage = [self modelValueWithIndex:(_currentIndex - 1)];
        _pageControll.currentPage = _currentPage;
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
