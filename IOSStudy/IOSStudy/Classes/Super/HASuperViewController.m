//
//  HASuperViewController.m
//  IOSStudy
//
//  Created by hai on 14-6-20.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HASuperViewController.h"

@interface HASuperViewController ()

@property (nonatomic, retain) UIScrollView *backgroundScrollView;

@end

@implementation HASuperViewController

- (void)dealloc
{
    [_backgroundScrollView release];
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
	// Do any additional setup after loading the view.
    [self addScrollViewToBelow];
    [self adjustScrollViewHeight:[self bottomWithBelowestView] + 50.0f];
    [self moveSubviewsToScrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- private methods

//增加scrollview
- (void)addScrollViewToBelow
{
    _backgroundScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    _backgroundScrollView.backgroundColor = [UIColor redColor];
    [_backgroundScrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
    [self.view insertSubview:_backgroundScrollView atIndex:0];
}

//将每个子类controller的view上的subview都移到scrollview上面
- (void)moveSubviewsToScrollView
{
    for (UIView *subView in self.view.subviews) {
        if (subView == _backgroundScrollView) {
            continue;
        }else{
            if (subView.superview != nil && subView.superview == self.view) {
                [subView removeFromSuperview];
                [_backgroundScrollView addSubview:subView];
            }
            
        }
    }
}

//计算view上面最底下的view的bottom，以便scrollview计算contentsize的高
- (float)bottomWithBelowestView
{
    float bottom = 0.0f;
    for (UIView *subView in self.view.subviews) {
        if (subView == _backgroundScrollView) {
            continue;
        }else{
            float viewBottom = subView.frame.origin.y + subView.frame.size.height;
            if (viewBottom > bottom) {
                bottom = viewBottom;
            }
        }
    }
    NSLog(@"bottom : %f",bottom);
    return bottom;
}

#pragma mark -- public methods

- (void)adjustScrollViewHeight:(float)sHeight
{
    float scrollHeight = self.view.frame.size.height + 50;
    if (sHeight < scrollHeight) {
        sHeight = scrollHeight;
    }
    
    [_backgroundScrollView setContentSize:CGSizeMake(self.view.frame.size.width, sHeight)];

}

@end
