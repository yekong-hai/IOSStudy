//
//  HAXibViewController.m
//  IOSStudy
//
//  Created by hai on 14-7-14.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAXibViewController.h"
#import "HAXibView.h"

@interface HAXibViewController ()

@end

@implementation HAXibViewController

//由于这个controller的名字和HAXibView相同，在controller自己init的时候先照HAXibView的xib文件作为controller的xib文件了，HAXibView文件中有个containerView，xibViewController没有找不到，故报错，所以这里需要制定nib文件的名称，使得加载的时候不去找HAXibView.xib文件，而是HAXibViewController.xib文件,这样就没事了-----以后命名注意不要前面相同
- (id)initWithTitile:(NSString *)title
{
    self = [super initWithNibName:@"HAXibViewController" bundle:nil];
    if (self) {
        self.title = title;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addXibView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addXibView
{
    HAXibView *view = [[HAXibView alloc] initWithFrame:CGRectMake(0, 50, 320, 300)];
    [self.view addSubview:view];
//    view.backgroundColor = [UIColor redColor];
    [view release];
}
@end
