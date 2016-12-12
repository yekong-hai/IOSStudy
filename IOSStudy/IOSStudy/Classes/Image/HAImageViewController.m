//
//  HAImageViewController.m
//  IOSStudy
//
//  Created by haiwang on 14-11-12.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAImageViewController.h"
#import "ASIHTTPRequest.h"

@interface HAImageViewController ()<ASIHTTPRequestDelegate>

@property (nonatomic, retain) IBOutlet UIImageView *imageView;

@property (nonatomic, retain) ASIHTTPRequest *asiRequest;

@end

@implementation HAImageViewController

- (void)dealloc
{
    [_imageView release];
    [_asiRequest release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *imagePath;
    imagePath = @"http://mimages.vancl.com/splashscreen/2014_11_11_23_42_28_869.jpg";
//    imagePath = @"http://b.hiphotos.baidu.com/image/pic/item/79f0f736afc3793143731d06e9c4b74543a91181.jpg";
    self.asiRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:imagePath]];
    self.asiRequest.delegate = self;
    self.asiRequest.timeOutSeconds = 20;
    [self.asiRequest startAsynchronous];

}

#pragma mark -- ASIHttpRequest

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *imageData = request.responseData;
    [self.imageView setImage:[UIImage imageWithData:imageData]];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
