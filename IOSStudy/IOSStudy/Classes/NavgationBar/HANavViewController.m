//
//  HANavViewController.m
//  IOSStudy
//
//  Created by haiwang on 14-11-20.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HANavViewController.h"

@interface HANavViewController ()

@end

@implementation HANavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    self.navigationController.navigationItem.titleView.backgroundColor = [UIColor greenColor];
////    self.navigationItem.titleView.backgroundColor = [UIColor greenColor];
//    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
//    self.navigationController.navigationBar.backgroundColor = [UIColor greenColor];
//    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"nav_back.png"];
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_bg.png"] forBarMetrics:UIBarMetricsDefault];
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor, nil];
//    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    //白色的图片，但是还是显示蓝色渲染
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back.png"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [backButton setImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [backButton release];
//    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"nav_back.png"]];
//    self.navigationController.navigationItem.leftBarButtonItem = item;
//    self.navigationController.navigationItem.hidesBackButton = YES;
//    self.navigationItem.backBarButtonItem = nil;
//    self.navigationItem.hidesBackButton = YES;
//    self.navigationItem.backBarButtonItem = item;
    self.navigationItem.leftBarButtonItem = item;
//    self.navigationItem.leftItemsSupplementBackButton = NO;
    [item release];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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
