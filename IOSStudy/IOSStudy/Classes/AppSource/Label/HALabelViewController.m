//
//  HASimpleAppViewController.m
//  IOSStudy
//
//  Created by hai on 14-6-19.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HALabelViewController.h"
#import "HACustomRectLabel.h"
#import "HALineLabel.h"

@interface HALabelViewController ()

@property (nonatomic, retain) IBOutlet UILabel *sLabel;
@property (nonatomic, retain) IBOutlet UILabel *hLabel;

@end

@implementation HALabelViewController

- (void)dealloc
{
    [_sLabel release];
    [_hLabel release];
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

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self studyLabel];
    
}

#pragma mark -- UILabel

- (void)studyLabel
{
    _sLabel.textColor = [UIColor blackColor];
    _sLabel.shadowColor = [UIColor redColor];//字体阴影
    _sLabel.shadowOffset = CGSizeMake(1, 1);//阴影偏移
    _sLabel.backgroundColor = [UIColor grayColor];
    
    //label也能设置高亮模式，
    _hLabel.highlighted = YES;
    _hLabel.highlightedTextColor = [UIColor greenColor];
    
    _sLabel.userInteractionEnabled = YES;
    
    //TODO:竖排label，显示文字；霓虹灯闪烁效果
    
    
    [self addCustomRectLabel];
    
    [self addCustomLineLabel];
    
    [self addCustomLineLabel2];
    
    [self addCustomLineLabel3];
}

- (void)addCustomRectLabel
{
    HACustomRectLabel *label = [[HACustomRectLabel alloc] initWithFrame:CGRectMake(50, 160, 220, 30)];
    label.text = @"这是一个自定义rect的label。";
    label.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:label];
    [label release];
}

- (void)addCustomLineLabel
{
    HALineLabel *label = [[HALineLabel alloc] initWithFrame:CGRectMake(30, 200, 260, 21)];
    label.text = @"这是一个自定义的可画横线的label";
    label.lineWith = 2.0f;
    label.lineColor = [UIColor redColor];
    label.lineType = HALineHorizontalBottomType;
    [self.view addSubview:label];
    [label  release];
}

- (void)addCustomLineLabel2
{
    HALineLabel *label = [[HALineLabel alloc] initWithFrame:CGRectMake(30, 240, 260, 21)];
    label.text = @"这是一个水平居中的画横线的label";
    label.lineWith = 2.0f;
    label.lineColor = [UIColor greenColor];
    label.lineType = HALineHorizontalCenterType;
    [self.view addSubview:label];
    [label  release];
}

- (void)addCustomLineLabel3
{
    HALineLabel *label = [[HALineLabel alloc] initWithFrame:CGRectMake(30, 280, 180, 21)];
    label.text = @"这是一个对角线的label";
    label.lineWith = 2.0f;
    label.lineColor = [UIColor grayColor];
    label.lineType = HALineDiagonalType;
    [self.view addSubview:label];
    [label  release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
