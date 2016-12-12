//
//  HAViewShowController.m
//  IOSStudy
//
//  Created by haiwang on 14-7-25.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAViewShowController.h"

@interface HAViewShowController ()

@property (nonatomic, strong) IBOutlet UIView *thirdView;

@end

@implementation HAViewShowController

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
//    _thirdView.layer.opaque = NO;
    _thirdView.opaque = NO;
    _thirdView.layer.opacity = 0.4;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
