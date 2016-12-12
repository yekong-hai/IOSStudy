//
//  HAHeaderScrollViewController.m
//  IOSStudy
//
//  Created by hai on 14-6-24.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAHeaderScrollViewController.h"
#import "HAHeaderScrollView.h"

@interface HAHeaderScrollViewController ()

@property (nonatomic, retain) HAHeaderScrollView *headerScrollView;

@end

@implementation HAHeaderScrollViewController

- (void)dealloc
{
    [_headerScrollView release];
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

- (void)setupHeaderScrollView
{
    _headerScrollView = [[HAHeaderScrollView alloc] initWithHeaderTop:-120.0f];
    _headerScrollView.backgroundColor = [UIColor clearColor];
    _headerScrollView.scrollEnabled = YES;
    [_headerScrollView setBackgroundImage:[UIImage imageNamed:@"header_scrollview_bg.jpg"]];
    [self.view addSubview:_headerScrollView];
    
    UIView *customView = [[UIView alloc] init];
    customView.frame = CGRectMake(0, 0, 100, 200);
    customView.backgroundColor = [UIColor redColor];
    [_headerScrollView setCustomView:customView];
    [customView release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"HeaderImageScrollView";
    
    [self setupHeaderScrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
