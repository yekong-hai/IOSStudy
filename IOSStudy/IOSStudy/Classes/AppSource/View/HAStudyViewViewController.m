//
//  HAStudyViewViewController.m
//  IOSStudy
//
//  Created by haiwang on 16/1/8.
//  Copyright © 2016年 hai. All rights reserved.
//

#import "HAStudyViewViewController.h"

@interface HAStudyViewViewController ()

@property (retain, nonatomic) IBOutlet UIScrollView *mainSCrollView;

@property (nonatomic, retain) UITapGestureRecognizer *tapGesture;

@end

@implementation HAStudyViewViewController

- (UITapGestureRecognizer *)tapGesture
{
    if (_tapGesture == nil) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapView:)];
    }
    return _tapGesture;
}

- (void)onTapView:(id) sender
{
    
}

- (void)testView1
{
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view1.backgroundColor = [UIColor redColor];
//    view1.center = CGPointMake(100, 100);
//    view1.bounds = CGRectMake(0, 0, 100, 100);
    NSLog(@"%@",NSStringFromCGRect(view1.bounds));
    view1.bounds = CGRectMake(0, 0, 50, 50);//中心
    NSLog(@"%@",NSStringFromCGRect(view1.bounds));
//    view1.bounds = CGRectMake(50, 50, 50, 50);//还是中心
//    NSLog(@"%@",NSStringFromCGRect(view1.bounds));
//    view1.bounds = CGRectMake(50, 50, 10, 10);
//    NSLog(@"%@",NSStringFromCGRect(view1.bounds));
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view2.backgroundColor = [UIColor greenColor];
    view2.bounds = CGRectMake(0, 0, 50, 50);
    [view2 addSubview:view1];
    [_mainSCrollView addSubview:view2];
    
    [view2 release];
    [view1 release];
}

//view的frame和bounds，子view的具体位置frame是由父view的bounds决定的，不是父的frame

- (void)testView2
{
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(50, 150, 200, 200)];
    view2.backgroundColor = [UIColor greenColor];
    view2.bounds = CGRectMake(20, 20, 300, 300);
    NSLog(@"222%@",NSStringFromCGRect(view2.bounds));
    NSLog(@"222%@",NSStringFromCGRect(view2.frame));
    
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view1.backgroundColor = [UIColor redColor];
    NSLog(@"222%@",NSStringFromCGRect(view1.bounds));
    NSLog(@"222%@",NSStringFromCGRect(view1.frame));

    //    view1.center = CGPointMake(100, 100);
//    view1.bounds = CGRectMake(100, 100, 100, 100);
//    NSLog(@"222%@",NSStringFromCGRect(view1.bounds));
//    NSLog(@"222%@",NSStringFromCGRect(view1.frame));
////    view1.bounds = CGRectMake(0, 0, 50, 50);//中心
////    NSLog(@"%@",NSStringFromCGRect(view1.bounds));
//    //    view1.bounds = CGRectMake(50, 50, 50, 50);//还是中心
//    //    NSLog(@"%@",NSStringFromCGRect(view1.bounds));
////    view1.bounds = CGRectMake(100, 100, 50, 50);
////    NSLog(@"222%@",NSStringFromCGRect(view1.bounds));
////    NSLog(@"222%@",NSStringFromCGRect(view1.frame));
//
//    [view1 setBounds:CGRectMake(10, 10, 50, 50)];
//    NSLog(@"222%@",NSStringFromCGRect(view1.bounds));
//    NSLog(@"222%@",NSStringFromCGRect(view1.frame));

//    view1.bounds = CGRectMake(50, 50, 50, 50);
//    NSLog(@"222%@",NSStringFromCGRect(view1.bounds));
//    NSLog(@"222%@",NSStringFromCGRect(view1.frame));
    
    [view2 addSubview:view1];
    [_mainSCrollView addSubview:view2];
    
    [view2 release];
    [view1 release];
    
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(50, 150, 100, 100)];
    view3.backgroundColor = [UIColor grayColor];
    [_mainSCrollView addSubview:view3];
    [view3 release];
}


- (void)testView3
{
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(50, 450, 200, 200)];
    view2.backgroundColor = [UIColor greenColor];
    [_mainSCrollView addSubview:view2];
    
    //bounds修改---固定中心点，先改frame，在重置本view的原点（不是保持在父view的原点不变）
    //1修改frame的size，origin，然后就被动间接修改bounds的origin
    //2bounds的size影响frame，bounds的origin影响
    view2.bounds = CGRectMake(20, 20, 200, 200);
    NSLog(@"222%@",NSStringFromCGRect(view2.bounds));
    NSLog(@"222%@",NSStringFromCGRect(view2.frame));

//    view2.bounds = CGRectMake(-20, -20, 200, 200);
//    NSLog(@"222%@",NSStringFromCGRect(view2.bounds));
//    NSLog(@"222%@",NSStringFromCGRect(view2.frame));

//    view2.bounds = CGRectMake(20, 20, 220, 220);
//    NSLog(@"222%@",NSStringFromCGRect(view2.bounds));
//    NSLog(@"222%@",NSStringFromCGRect(view2.frame));

    view2.bounds = CGRectMake(20, 20, 150, 150);
    NSLog(@"222%@",NSStringFromCGRect(view2.bounds));
    NSLog(@"222%@",NSStringFromCGRect(view2.frame));

    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view1.backgroundColor = [UIColor redColor];
    [view2 addSubview:view1];
    
    [view1 release];
    [view2 release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_mainSCrollView setContentSize:CGSizeMake(1000, 1000)];
    [self testView1];
    [self testView2];
    [self testView3];
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

- (void)dealloc {
    [_tapGesture release];
    [_mainSCrollView release];
    [super dealloc];
}

@end
