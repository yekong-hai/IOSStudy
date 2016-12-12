//
//  HANativeAndJsViewController.m
//  IOSStudy
//
//  Created by haiwang on 16/3/18.
//  Copyright © 2016年 hai. All rights reserved.
//

#import "HANativeAndJsViewController.h"

@interface HANativeAndJsViewController ()<UIWebViewDelegate>

@property (nonatomic, retain) IBOutlet UIWebView *webView;

@property (nonatomic, retain) IBOutlet UIButton *testButton;

@end

@implementation HANativeAndJsViewController

- (void)dealloc
{
    [_testButton release];
    [_webView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"native_js_test" withExtension:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:fileUrl];
    self.webView.delegate = self;
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTestButtonClicked:(id)sender
{
    NSString *function = @"calculateAndReturn()";
//    function = @"alert123()";
    NSString *js = [_webView stringByEvaluatingJavaScriptFromString:function];
    NSLog(@"result %@",js);
    
}

#pragma mark -- UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"host %@",request.URL.host);
    NSLog(@"path %@",request.URL.path);
    if ([request.URL.path isEqualToString:@""]) {
        
    }
    NSLog(@"request %@",request);
    NSLog(@"shouldStartLoadWithRequest");
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
     NSLog(@"didFailLoadWithError");
}


@end
