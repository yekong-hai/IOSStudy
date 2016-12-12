//
//  HAAutoLayoutViewController.m
//  IOSStudy
//
//  Created by haiwang on 14-10-27.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAAutoLayoutViewController.h"
#import "HAALTableViewController.h"

@interface HAAutoLayoutViewController ()

@end

@implementation HAAutoLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //调整ios7会使得视图上移到navBar下面的情况
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        //    self.edgesForExtendedLayout = UIRectEdgeAll;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        //    self.edgesForExtendedLayout = UIRectEdgeBottom|UIRectEdgeLeft|UIRectEdgeRight;
    }
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)onLayoutBtn1Clicked:(id)sender
{
    HAALTableViewController *tableViewController = [[HAALTableViewController alloc] initWithTitile:@"tableview测试"];
    [self.navigationController pushViewController:tableViewController animated:YES];
    [tableViewController release];
}

@end
