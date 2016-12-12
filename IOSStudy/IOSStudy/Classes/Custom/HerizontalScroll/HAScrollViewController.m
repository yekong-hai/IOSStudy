//
//  HAScrollViewController.m
//  IOSStudy
//
//  Created by hai on 14-6-26.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAScrollViewController.h"
#import "HAHerizontalScrollView.h"
#import "HAHerizonLoopScrollView.h"
#import "HAHerizonLoopView.h"
#import "HALoopView.h"
#import "UIImage+LoadUrl.h"
#import "HALoopURLView.h"

@interface HAScrollViewController ()<HALooViewDelegate,HALoopURLViewDelegate>
{

}
@property (nonatomic, retain) HAHerizontalScrollView *herizontalScrollView;

@property (nonatomic, retain) HAHerizonLoopScrollView *loopScrollView;

@property (nonatomic, retain) HAHerizonLoopView *loopView;

@property (nonatomic, retain) HALoopView *hLoopView;

@end

@implementation HAScrollViewController

- (void)dealloc
{
    [_herizontalScrollView release];
    [_loopScrollView release];
    [_loopView closeAutoSlide];
    [_loopView release];
    [_hLoopView release];
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

- (void)initHerizontalScrollView
{
    _herizontalScrollView = [[HAHerizontalScrollView alloc] initWithImages:[NSArray arrayWithObjects:[UIImage imageNamed:@"btn_sina.png"],[UIImage imageNamed:@"btn_tecent.png"],[UIImage imageNamed:@"btn_wexin.png"], nil]];
    _herizontalScrollView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_herizontalScrollView];
}

- (void)initLoopScrollView
{
    _loopScrollView = [[HAHerizonLoopScrollView alloc] initWithImages:[NSArray arrayWithObjects:[UIImage imageNamed:@"btn_sina.png"],[UIImage imageNamed:@"btn_tecent.png"],[UIImage imageNamed:@"btn_wexin.png"], nil]];
    _loopScrollView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_loopScrollView];
}


- (void)initLoopView
{
//    NSArray *strArray = [NSArray arrayWithObjects:@"aa",@"ww",@"gg",@"cc", nil];
//    for (int i = 0; i < strArray.count; i++) {
//        NSString *image = strArray[i];
//        NSLog(@"%@",[image description]);
//    }
    NSArray *imageArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"btn_wexin.png"],[UIImage imageNamed:@"btn_sina.png"],[UIImage imageNamed:@"btn_tecent.png"],[UIImage imageNamed:@"btn_icon.png"], nil];
    _loopView = [[HAHerizonLoopView alloc] initWithImages:imageArray withAuto:YES];
    _loopScrollView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_loopView];
}

- (void)initHALoopView
{
    NSArray *imageArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"btn_wexin.png"],[UIImage imageNamed:@"btn_sina.png"],[UIImage imageNamed:@"btn_tecent.png"],[UIImage imageNamed:@"btn_icon.png"], nil];
    _hLoopView = [[HALoopView alloc] initWithImages:imageArray withAuto:YES];
    _hLoopView.delegate = self;
    _loopScrollView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_hLoopView];
}

- (void)initLoopURLView
{
//    UIImage *image = [[UIImage alloc] initWithUrl:@"http://localhost:8086/HelloSpring/res/image/sprites.jpg"];
    
    NSArray *imageUrlArray = [NSArray arrayWithObjects:@"http://i5.m.vancl.com/topic/2014_11_11_0_0_3_5287.jpg",@"http://i1.m.vancl.com/topic/2014_10_21_14_59_23_1030.jpg",@"http://i4.m.vancl.com/topic/2014_10_14_15_0_18_4892.jpg",@"http://i2.m.vancl.com/topic/2014_10_21_15_21_12_2213.jpg",@"http://i4.m.vancl.com/topic/2014_11_4_15_37_59_4244.jpg", nil];
//    imageUrlArray = [NSArray arrayWithObjects:@"http://localhost:8086/HelloSpring/res/image/sprites.jpg",@"http://localhost:8086/HelloSpring/res/image/nv_girl.jpg",@"http://localhost:8086/HelloSpring/res/image/QQ20141107.png",@"http://localhost:8086/HelloSpring/res/image/QQ20141118.png", nil];
    HALoopURLView *loopUrlView = [[HALoopURLView alloc] initWithImageUrls:imageUrlArray withAuto:YES];
    loopUrlView.delegate = self;
    _loopScrollView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:loopUrlView];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

//    [self initHerizontalScrollView];
    
//    [self initLoopView];
    
//    [self initHALoopView];
    
    [self initLoopURLView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- HALoopViewDelegate

- (void)loopView:(HALoopView *)loopView didSelectAtIndex:(int)index
{
    NSLog(@"clicked image array index %d",index);
}

#pragma mark -- HALoopUrlViewDelegate

- (void)loopUrlView:(HALoopURLView *)loopView didSelectAtIndex:(int)index
{
    NSLog(@"clicked image array index %d",index);
}

@end
