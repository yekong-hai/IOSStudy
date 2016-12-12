//
//  HALoadingView.m
//  IOSStudy
//
//  Created by haiwang on 14-7-7.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HALoadingView.h"

@interface HALoadingView ()
{
    void(^_onTapedForLoadingView)(HALoadingView *);
}
@property (nonatomic, retain) UIActivityIndicatorView *indicatorView;

@property (nonatomic, retain) UILabel *contentLabel;

@property (nonatomic, copy) NSString *content;

@end

@implementation HALoadingView

#pragma mark -- init methods

- (void)dealloc
{
    [_indicatorView release];
    [_contentLabel release];
    [_content release];
    [_onTapedForLoadingView release];
    _delegate = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initIndicatorView];
        [self initContentView];
        [self addTapGesture];
        self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.7f];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (id)initWithTitle:(NSString *) title
{
    self = [self initWithFrame:CGRectMake(0, 0, [self sizeOfScreen].width, [self sizeOfScreen].height)];
    if (self) {
        _content = [title copy];
    }
    return self;
}

- (id)initWithOnTap:(void(^)(HALoadingView * loadingView)) onTapBlock
{
    self = [self initWithTitle:nil];
    if (self) {
        _isCancelOnTouch = YES;
        _onTapedForLoadingView = [onTapBlock copy];
    }
    return self;
}

#pragma mark -- private methods

- (CGSize)sizeOfScreen
{
    return [UIScreen mainScreen].bounds.size;
}

- (void)initIndicatorView
{
    _indicatorView = [[UIActivityIndicatorView alloc] init];
    _indicatorView.center = CGPointMake([self sizeOfScreen].width / 2, [self sizeOfScreen].height / 2);
    _indicatorView.bounds = CGRectMake(0, 0, 37.0f, 37.0f);
    _indicatorView.backgroundColor = [UIColor clearColor];
    [self addSubview:_indicatorView];
}

- (void)initContentView
{
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.center = CGPointMake([self sizeOfScreen].width / 2, [self sizeOfScreen].height / 2 + 30.0f);
    _contentLabel.font = [UIFont systemFontOfSize:13.0f];
    _contentLabel.textColor = [UIColor whiteColor];
    _contentLabel.bounds = CGRectMake(0, 0, 200.0f, 21.0f);
    _contentLabel.textAlignment = UITextAlignmentCenter;
    _contentLabel.backgroundColor = [UIColor clearColor];
    if (_content) {
        _contentLabel.text = _content;
    }else{
        _contentLabel.text = @"加载中...";
    }
    [self addSubview:_contentLabel];
}

- (void)addTapGesture
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapLoadingView)];
    [self addGestureRecognizer:tapGesture];
    [tapGesture release];
}

- (void)onTapLoadingView
{
    NSLog(@"tap loading view");
    if (_isCancelOnTouch) {
        [self hiddenLoadingView];
        if (_delegate && [_delegate respondsToSelector:@selector(onTapForLoadingView:)]) {
            [_delegate onTapForLoadingView:self];
        }
        if (_onTapedForLoadingView) {
            _onTapedForLoadingView(self);
        }
    }
}

- (void)removeLoadingView
{
    [_indicatorView stopAnimating];
    [self removeFromSuperview];
}

#pragma mark -- public methods

//隐藏loadingview
- (void)hiddenLoadingView
{
    [UIView beginAnimations:@"hiddenLoadingView" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5f];
    [UIView setAnimationDidStopSelector:@selector(removeLoadingView)];
    self.alpha = 0.0f;
    [UIView commitAnimations];
}

//显示loadingview
- (void)showLoadingView
{
    [_indicatorView startAnimating];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

@end
