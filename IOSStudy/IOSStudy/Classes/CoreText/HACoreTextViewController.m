//
//  HACoreTextViewController.m
//  IOSStudy
//
//  Created by haiwang on 14-12-26.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HACoreTextViewController.h"
#import "HACoreTextView.h"
#import "HAMutableColorTextView.h"
#import <CoreText/CoreText.h>

@interface HACoreTextViewController ()

@property (nonatomic, retain) IBOutlet UILabel *colorLabel;

@end

@implementation HACoreTextViewController

- (void)dealloc
{
    [_colorLabel release];
    [super dealloc];
}

- (void)initCoreTextView
{
    HACoreTextView *coreTextView = [[HACoreTextView alloc] initWithFrame:CGRectMake(50, 100, 200, 50)];
    [self.view addSubview:coreTextView];
    [coreTextView release];
}

- (void)initMutableColorTextView
{
    HAMutableColorTextView *mColorTextView = [[HAMutableColorTextView alloc] initWithFrame:CGRectMake(10, 200, 300, 70)];
    [self.view addSubview:mColorTextView];
    [mColorTextView release];
}

- (void)initAttributeLabel
{
    NSString *text = @"经济技术开发区工业区东区经海一路科创三街三号院,凡客诚品技术测试,请忽略次订单";
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
    [attString beginEditing];
    [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11.0f] range:NSMakeRange(0, text.length)];
    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0, 10)];
    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(10, 10)];
    [attString endEditing];
    
    _colorLabel.attributedText = attString;
    [attString release];
    [_colorLabel setNeedsDisplay];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initAttributeLabel];
    [self initCoreTextView];
    [self initMutableColorTextView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
