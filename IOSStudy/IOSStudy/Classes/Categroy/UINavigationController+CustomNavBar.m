//
//  UINavigationController+CustomNavBar.m
//  VANCL
//
//  Created by haiwang on 14-11-20.
//  Copyright (c) 2014年 vancl.com. All rights reserved.
//

#import "UINavigationController+CustomNavBar.h"

//TODO:不能定制修改导航条啊
@implementation UINavigationController (CustomNavBar)

- (instancetype)initCustomBarWithRootViewController:(UIViewController *)rootViewController
{
    self = [self initWithRootViewController:rootViewController];
    if (self) {
//        [self setupBar];
        [self setupCustomBar];
    }
    return self;
}

- (void)setupBar
{
    self.navigationItem.title = nil;
    self.navigationItem.titleView = nil;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor redColor];
    titleLabel.text = @"2314123";
//    self.navigationItem.titleView = titleLabel;
    [self.navigationBar addSubview:titleLabel];
    [titleLabel release];
    
}

- (void)setupCustomBar
{
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_bg.png"] forBarMetrics:UIBarMetricsDefault];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor, nil];
    [self.navigationBar setTitleTextAttributes:dic];
    //对于返回按钮，item都是针对与每一个viewcontroller的，而不是navigationcontroller
//    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
//    [backButton setImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
//    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//    [backButton release];
//    self.navigationItem.hidesBackButton = YES;
////    self.navigationItem.leftBarButtonItem = item;
//    [self.navigationBar addSubview:backButton];
//    [item release];
}

//- (void)back
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}

@end
