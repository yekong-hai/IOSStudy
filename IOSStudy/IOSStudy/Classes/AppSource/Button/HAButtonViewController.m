//
//  HAButtonViewController.m
//  IOSStudy
//
//  Created by hai on 14-6-24.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAButtonViewController.h"

@interface HAButtonViewController ()

@property (nonatomic, retain) IBOutlet UIButton *bButton;

@end

@implementation HAButtonViewController

#pragma mark -- init methods

- (void)dealloc
{
    [_bButton release];
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

- (void)setupButton
{
    //默认为蓝色底色的点击效果，
//    _bButton.tintColor = [UIColor redColor];
    
    [_bButton setTitle:@"Normal" forState:UIControlStateNormal];
    [_bButton setTitle:@"Select" forState:UIControlStateSelected];
    [_bButton setTitle:@"Highlight" forState:UIControlStateHighlighted];
    
    [_bButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_bButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [_bButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    
    [_bButton setTitleShadowColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_bButton setTitleShadowColor:[UIColor yellowColor] forState:UIControlStateSelected];
    [_bButton setTitleShadowColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
}

#pragma mark -- lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- private methods


#pragma mark -- public methods


#pragma mark -- action methods

- (IBAction)onBtnClicked:(id)sender
{
    
}

#pragma mark -- delegate methods


@end
