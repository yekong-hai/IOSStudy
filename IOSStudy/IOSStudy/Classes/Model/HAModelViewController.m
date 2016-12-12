//
//  HAModelViewController.m
//  IOSStudy
//
//  Created by hai on 14-7-7.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAModelViewController.h"
#import "HAUserModel.h"
#import "HASuperUser.h"

@interface HAModelViewController ()

@end

@implementation HAModelViewController

#pragma mark -- init methos

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)testModel
{
    NSDictionary *userDic = [NSDictionary dictionaryWithObjectsAndKeys:@"hai",@"userName",@"m",@"sex",[NSNumber numberWithInt:27],@"age",[NSDictionary dictionaryWithObjectsAndKeys:@"hai is hai",@"desc",@"2014年",@"descTime", nil],@"descInfo", nil];
    HAUserModel *user = [[HAUserModel alloc] init];
    [user parseWithDic:userDic];
    NSLog(@"%@",[user description]);
    HAUserDescModel *desc = user.descInfo;
    NSLog(@"%@",[desc description]);
    [user release];
}

- (void)testInstanceTypeUser
{
    //instancetype只作为返回值,返回类型是类名
    HASuperUser *user = [[HASuperUser alloc] initWithName:@"hai"];
    [[[HASuperUser alloc] initWithName:@"hai"] setUserName:@"hai"];
    //id还可当做参数传递,返回类型是id
    HASuperUser *user2 = [[HASuperUser alloc] initWithSex:@"m"];
    [[[HASuperUser alloc] initWithSex:@"m"] setUserName:@"m"];
    [[HASuperUser user] setUserName:@"m"];
    //作用：instancetype的作用，就是使那些非关联返回类型的方法返回所在类的类型！
    
    [user release];
    [user2 release];
}

#pragma mark -- lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self testModel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
