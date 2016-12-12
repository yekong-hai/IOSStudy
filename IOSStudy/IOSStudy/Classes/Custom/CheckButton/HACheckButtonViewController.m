//
//  HACheckButtonViewController.m
//  IOSStudy
//
//  Created by haiwang on 14-8-31.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HACheckButtonViewController.h"
#import "HACheckButton.h"

@interface HACheckButtonViewController ()

@end

@implementation HACheckButtonViewController

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
    // Do any additional setup after loading the view.
    
    HACheckButton *checkButton = [[HACheckButton alloc] initWithFrame:CGRectMake(50, 100, 200, 30)];
    [checkButton setCheckContent:@"鸡腿"];
    [self.view addSubview:checkButton];
    [checkButton release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
