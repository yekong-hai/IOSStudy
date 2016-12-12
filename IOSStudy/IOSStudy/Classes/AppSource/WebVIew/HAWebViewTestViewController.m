//
//  HAWebViewTestViewController.m
//  IOSStudy
//
//  Created by haiwang on 15-3-20.
//  Copyright (c) 2015年 hai. All rights reserved.
//

#import "HAWebViewTestViewController.h"

@interface HAWebViewTestViewController ()

@property (nonatomic, retain) IBOutlet UIWebView *webView;

@end

@implementation HAWebViewTestViewController

- (void)dealloc
{
    [_webView release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.vancl.com/channel/index/466?ref=H5focus_3"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
