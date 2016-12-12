//
//  UIViewController+NavBarTitle.m
//  IOSStudy
//
//  Created by haiwang on 14-10-29.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "UIViewController+NavBarTitle.h"

@implementation UIViewController (NavBarTitle)

- (id)initWithTitile:(NSString *) title
{
    self = [super init];
    if (self) {
        self.title = title;
        [self initBackButtonForNavigationBar];
    }
    return self;
}

- (void)initBackButtonForNavigationBar
{
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [backButton setImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [backButton release];
    self.navigationItem.leftBarButtonItem = item;
    [item release];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
