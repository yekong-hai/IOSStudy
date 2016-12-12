//
//  HASegmentControlViewController.m
//  IOSStudy
//
//  Created by hai on 14-6-23.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HASegmentControlViewController.h"

@interface HASegmentControlViewController ()

@property (nonatomic, retain) IBOutlet UISegmentedControl *sSegmentControl;

@end

@implementation HASegmentControlViewController

- (void)dealloc
{
    [_sSegmentControl release];
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

#pragma mark -- private methods

- (void)setupSegmentControl
{
    //设置segment按钮点击后的展现，是否是瞬时变换，而后立即还原
    _sSegmentControl.momentary = NO;
    
    _sSegmentControl.tintColor = [UIColor redColor];
}

- (void)addNewSegmentControl
{
    //image盖在上面
    UISegmentedControl *sControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:[UIImage imageNamed:@"icon.png"],[UIImage imageNamed:@"icon.png"], nil]];
    sControl.frame = CGRectMake(20, 150, 200, 40);
    [sControl setBackgroundColor:[UIColor grayColor]];
    //可以改变背景，底色的蓝背景
    [sControl setBackgroundImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [sControl setDividerImage:nil forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [sControl setDividerImage:nil forLeftSegmentState:UIControlStateHighlighted rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.view addSubview:sControl];
    [sControl release];
}

- (void)testSegmentControlLength
{
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"才艺",@"工期",@"暖气",@"卫生",@"垃圾",@"空气",@"雾霾",@"北京",@"工期",@"暖气",@"卫生",@"垃圾",@"空气",@"雾霾",@"北京"]];
    segmentControl.frame = CGRectMake(0, 200, 200, 40);
    [self.view addSubview:segmentControl];
    [segmentControl release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self setupSegmentControl];
    
    [self addNewSegmentControl];
    
    [self testSegmentControlLength];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
