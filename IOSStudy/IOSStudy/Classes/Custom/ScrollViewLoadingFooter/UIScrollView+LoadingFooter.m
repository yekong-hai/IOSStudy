//
//  UIScrollView+LoadingFooter.m
//  VANCL
//
//  Created by haiwang on 14-12-17.
//  Copyright (c) 2014年 vancl.com. All rights reserved.
//

#import "UIScrollView+LoadingFooter.h"
#import <objc/runtime.h>

#define VC_SCROLLVIEW_FOOTER_HEIGHT 60.0f

@interface UIScrollView (loading)

@property (nonatomic, retain) UIView *footerView;

@property (nonatomic, retain) UIActivityIndicatorView *indicatorView;

@property (nonatomic, retain) UILabel *loadLabel;

@end

@implementation UIScrollView (LoadingFooter)

#pragma mark -- private methods

static void* UIScrollViewLoadingFooterIndicatorKey = (void *)@"UIScrollViewLoadingFooterIndicatorKey";

- (void)setIndicatorView:(UIActivityIndicatorView *)indicatorView
{
    objc_setAssociatedObject(self, UIScrollViewLoadingFooterIndicatorKey, indicatorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIActivityIndicatorView *)indicatorView
{
    return objc_getAssociatedObject(self, UIScrollViewLoadingFooterIndicatorKey);
}

static void* UIScrollViewLoadingFooterLabelKey = (void*)@"UIScrollViewLoadingFooterLabelKey";

- (void)setLoadLabel:(UILabel *)loadLabel
{
    objc_setAssociatedObject(self, UIScrollViewLoadingFooterLabelKey, loadLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)loadLabel
{
    return objc_getAssociatedObject(self, UIScrollViewLoadingFooterLabelKey);
}

static void* UIScrollViewLoadingFooterKey = (void *)@"UIScrollViewLoadingFooterKey";
- (void)setFooterView:(UIView *)footerView
{
    objc_setAssociatedObject(self, UIScrollViewLoadingFooterKey, footerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)footerView
{
    return objc_getAssociatedObject(self, UIScrollViewLoadingFooterKey);
}

- (void)initLoadingFooterView
{
    self.footerView = [[[UIView alloc] initWithFrame:CGRectMake(0, self.contentSize.height, self.bounds.size.width, VC_SCROLLVIEW_FOOTER_HEIGHT)] autorelease];
    self.indicatorView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
    CGRect indicatorFrame = self.indicatorView.frame;
    indicatorFrame.origin = CGPointMake(self.bounds.size.width / 2 - 40.0f, 20.0f);
    self.indicatorView.frame = indicatorFrame;
    [self.footerView addSubview:self.indicatorView];
    [self.indicatorView startAnimating];

    self.loadLabel = [[[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width / 2 - 20.0f,20.0f, 60.0f, 20.0f)] autorelease];
    self.loadLabel.text = @"加载中...";
    self.loadLabel.font = [UIFont systemFontOfSize:14.0f];
    self.loadLabel.textColor = [UIColor darkGrayColor];
    [self.footerView addSubview:self.loadLabel];
    [self addSubview:self.footerView];
}

#pragma mark -- public methods

- (void)addLoadingFooter
{
    [self removeLoadingFooter];
    [self initLoadingFooterView];
}

- (void)removeLoadingFooter
{
    [self.indicatorView stopAnimating];
    [self.indicatorView removeFromSuperview];
    self.indicatorView = nil;
    [self.loadLabel removeFromSuperview];
    self.loadLabel = nil;
    [self.footerView removeFromSuperview];
    self.footerView = nil;
}

- (void)updateLoadingFooter
{
    self.footerView.frame = CGRectMake(0, self.contentSize.height, self.bounds.size.width, VC_SCROLLVIEW_FOOTER_HEIGHT);
}

- (float)heightWithFooterView
{
    if (self.footerView) {
        return VC_SCROLLVIEW_FOOTER_HEIGHT;
    }else{
        return 0;
    }

}

@end
