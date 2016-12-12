//
//  HALoadingViewController.m
//  IOSStudy
//
//  Created by haiwang on 14-7-7.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HALoadingViewController.h"
#import "HALoadingView.h"

@interface HALoadingViewController ()<HALoadingViewDelegate>

@end

@implementation HALoadingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)initLoadingView
{
    HALoadingView *loadingView = [[[HALoadingView alloc] initWithTitle:nil] autorelease];
    loadingView.delegate = self;
    loadingView.isCancelOnTouch = YES;
    [loadingView showLoadingView];
}

- (void)initLoadingView2
{
    HALoadingView *loadingView = [[[HALoadingView alloc] initWithOnTap:^(HALoadingView *loadingView) {
        NSLog(@"test tap");
    }] autorelease];
    [loadingView showLoadingView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self initLoadingView];
    [self initLoadingView2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- HALoadingViewDelegate

- (void)onTapForLoadingView:(HALoadingView *)loadingView
{
    NSLog(@"cancel request");
}

@end
