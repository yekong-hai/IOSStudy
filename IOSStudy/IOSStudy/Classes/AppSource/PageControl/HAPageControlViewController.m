//
//  HAPageControlViewController.m
//  IOSStudy
//
//  Created by hai on 14-6-24.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAPageControlViewController.h"

@interface HAPageControlViewController ()

@property (nonatomic, retain) IBOutlet UIPageControl *pPageControl;

@end

@implementation HAPageControlViewController

#pragma mark -- init methods

- (void)dealloc
{
    [_pPageControl release];
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

- (void)setupPageControl
{
    _pPageControl.numberOfPages = 5;
    
    _pPageControl.pageIndicatorTintColor = [UIColor blueColor];
    
    _pPageControl.currentPageIndicatorTintColor = [UIColor greenColor];
    
    _pPageControl.currentPage = 2;
    
}

#pragma mark -- lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupPageControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- private methods

#pragma mark -- public methods

#pragma mark -- action methods

#pragma mark -- delegate methods


@end
