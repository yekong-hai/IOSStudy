//
//  HAPDFViewController.m
//  IOSStudy
//
//  Created by haiwang on 16/5/18.
//  Copyright © 2016年 hai. All rights reserved.
//

#import "HAPDFViewController.h"
#import "HAPDFView.h"

@interface HAPDFViewController ()

@property (nonatomic, copy) NSString *pdfUrl;

@end

@implementation HAPDFViewController

- (void)setUrl
{
    self.pdfUrl = @"http://ei.51fapiao.cn:9080/51ptProxy/fpxz?p=TJHTFP20160512122794";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUrl];
    
    HAPDFView *pdfView = [[HAPDFView alloc] initWithPDFUrl:self.pdfUrl];
    pdfView.frame = CGRectMake(0, 0, 320, 300);
    [self.view addSubview:pdfView];
    [pdfView release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
