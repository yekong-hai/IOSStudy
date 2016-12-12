//
//  HAIndicatorViewController.m
//  IOSStudy
//
//  Created by hai on 14-6-23.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAIndicatorViewController.h"

@interface HAIndicatorViewController ()

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *indicatorView;

@property (nonatomic, retain) IBOutlet UIProgressView *progressView;

@end

@implementation HAIndicatorViewController

- (void)dealloc
{
    [_indicatorView release];
    [_progressView release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setupIndicatorView
{
    //设置风格，
    //UIActivityIndicatorViewStyleWhiteLarge
    //UIActivityIndicatorViewStyleWhite
    //UIActivityIndicatorViewStyleGray 

    _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    
    _indicatorView.backgroundColor = [UIColor blueColor];
    
    //改变转动圈的小条颜色
//    _indicatorView.color = [UIColor redColor];
    
    //设置停止的时候是否隐藏---整个view 都隐藏了，background也没有了
    _indicatorView.hidesWhenStopped = YES;
}

- (void)setupProgressView
{
    //设置风格
    //UIProgressViewStyleDefault,     // normal progress bar
    //UIProgressViewStyleBar,         // for use in a toolbar
    _progressView.progressViewStyle = UIProgressViewStyleDefault;
    
    [_progressView setProgress:0.3f animated:YES];
    
    //自定义进度颜色
    _progressView.progressTintColor = [UIColor greenColor];
//    _progressView.progressImage
    
    //设置progress的下面的底图
    _progressView.trackTintColor = [UIColor redColor];
//    _progressView.trackImage
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupIndicatorView];
    
    [self setupProgressView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- action methods

- (IBAction)onStartBtnClicked:(id)sender
{
    if ([_indicatorView isAnimating]) {
        return;
    }
    [_indicatorView startAnimating];
}

- (IBAction)onEndBtnClicked:(id)sender
{
    if ([_indicatorView isAnimating]) {
        [_indicatorView stopAnimating];
    }
}

@end
