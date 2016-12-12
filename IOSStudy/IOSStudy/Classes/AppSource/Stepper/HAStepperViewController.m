//
//  HAStepperViewController.m
//  IOSStudy
//
//  Created by hai on 14-6-24.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAStepperViewController.h"

@interface HAStepperViewController ()

@property (nonatomic, retain) IBOutlet UIStepper *sStepper;

@property (nonatomic, retain) IBOutlet UILabel *valueLabel;

@end

@implementation HAStepperViewController

- (void)dealloc
{
    [_sStepper release];
    [_valueLabel release];
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

- (void)setupStepper
{
    //按住加减的时候一直自动加减
    _sStepper.autorepeat = YES;
    //每次变化的值大小
    _sStepper.stepValue = 10;
    _sStepper.minimumValue = 0;
    _sStepper.maximumValue = 100;
    //初始化值
    _sStepper.value = 10;
    
    _valueLabel.text = [NSString stringWithFormat:@"%.0f",_sStepper.value];
    [_sStepper addTarget:self action:@selector(onStepperValueChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupStepper];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- private methods

- (void)onStepperValueChanged:(id)sender
{
    _valueLabel.text = [NSString stringWithFormat:@"%.0f",_sStepper.value];
}

@end
