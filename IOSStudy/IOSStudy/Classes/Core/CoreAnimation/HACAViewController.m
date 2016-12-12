//
//  HACAViewController.m
//  IOSStudy
//
//  Created by haiwang on 14-7-9.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HACAViewController.h"
#import "HACAView.h"
#import "HACA3DView.h"
#import "HACAEmitterView.h"

@interface HACAViewController ()

@end

@implementation HACAViewController

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
//    [self testUIKitAnimation];
//    [self testUIKitAnimationWithBlock];
//    [self testCAAnimation];
//    [self testCAKeyFrameAnimation];
//    [self testCAPathAnimation];
//    [self testCA3DAnimation];
//    [self testCA3DPerspectiveAnimation];
    [self testCA3DEmitterAnimation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testUIKitAnimation
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, 30, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    [view release];
    //UIViewAnimation
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationRepeatAutoreverses:YES];//自动反转动画
    [UIView setAnimationRepeatCount:5];//重复次数
    view.frame = CGRectMake(20, 30, 50, 50);
    view.alpha = 0.5;
    view.backgroundColor = [UIColor orangeColor];
    [UIView commitAnimations];
}

- (void)testUIKitAnimationWithBlock
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(150, 30, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    [view release];
    //UIViewAnimation
//    [UIView animateWithDuration:1 animations:^{
//        view.frame = CGRectMake(150, 30, 50, 50);
//        view.alpha = 0.5;
//        view.backgroundColor = [UIColor orangeColor];
//    } completion:^(BOOL finished) {
//        NSLog(@"animation finished.");
//    }];
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionRepeat animations:^{
        view.frame = CGRectMake(150, 30, 50, 50);
        view.alpha = 0.5;
        view.backgroundColor = [UIColor orangeColor];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)testCAAnimation
{
    HACAView *view = [[HACAView alloc] initWithFrame:CGRectMake(20, 150, 100, 100)];
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
    [view changeLayerColor];
    [view release];
}

- (void)testCAKeyFrameAnimation
{
    HACAView *view = [[HACAView alloc] initWithFrame:CGRectMake(150, 150, 100, 100)];
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
    [view setKeyFrameAnimation];
    [view release];
}

- (void)testCAPathAnimation
{
    HACAView *view = [[HACAView alloc] initWithFrame:CGRectMake(20, 270, 100, 100)];
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
    [view addPathAnimation];
    [view release];
}

- (void)testCA3DAnimation
{
    HACA3DView *view = [[HACA3DView alloc] initWithFrame:CGRectMake(150, 270, 100, 100)];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    [view add3DCAAnimation];
    [view release];
}

- (void)testCA3DPerspectiveAnimation
{
    HACA3DView *view = [[HACA3DView alloc] initWithFrame:CGRectMake(80, 390, 100, 100)];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    [view add3dPerspectiveAnimation];
    [view release];
}

- (void)testCA3DEmitterAnimation
{
    HACAEmitterView *eView = [[HACAEmitterView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
    [self.view addSubview:eView];
    eView.backgroundColor = [UIColor greenColor];
    [eView addEmitterAnimation];
    [eView release];
}

@end
