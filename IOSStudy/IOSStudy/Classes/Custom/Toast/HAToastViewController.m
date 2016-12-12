//
//  HAToastViewController.m
//  IOSStudy
//
//  Created by hai on 14-7-3.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAToastViewController.h"
#import "HAToast.h"

@interface HAToastViewController ()

@end

@implementation HAToastViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onUpToastBtnClicked:(id)sender {
    [HAToast showToast:@"up toast" position:HAToastPositionUp];
}
- (IBAction)onCustomToastBtnClicked:(id)sender {
    [HAToast showToast:@"这是一个自定义位置的toast提示视图" center:CGPointMake(100, 100)];
}
- (IBAction)onDownToastBtnClicked:(id)sender {
    [HAToast showToast:@"这是一个很长的底部显示的toast，一般都使用这个位置的提示，与android类似" position:HAToastPositionDown];
}
- (IBAction)onCenterToastBtnClicked:(id)sender {
    [HAToast showToast:@"up toast" position:HAToastPositionCenter];
}

@end
