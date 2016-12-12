//
//  HASwitchViewController.m
//  IOSStudy
//
//  Created by hai on 14-6-23.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HASwitchViewController.h"

@interface HASwitchViewController ()

@property (nonatomic, retain) IBOutlet UISwitch *uSwitch;

@property (nonatomic, retain) IBOutlet UILabel *desLabel;

@end


@implementation HASwitchViewController

- (void)dealloc
{
    [_uSwitch release];
    [_desLabel release];
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

- (void)setupSwitch
{
    _uSwitch.tintColor = [UIColor redColor];
    
    _uSwitch.onTintColor = [UIColor greenColor];
    
    _uSwitch.thumbTintColor = [UIColor blueColor];
    
    //直接设置开关的图片
//    _uSwitch.onImage
//    _uSwitch.offImage

    [_uSwitch addTarget:self action:@selector(onValueChangedForSwitch:) forControlEvents:UIControlEventValueChanged];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupSwitch];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- private methods

- (void)onValueChangedForSwitch:(id)sender
{
//    NSLog(@"sender:%@",sender);
    NSString *desc = _uSwitch.on?@"switch开启":@"switch关闭";
    _desLabel.text = desc;
}

@end
