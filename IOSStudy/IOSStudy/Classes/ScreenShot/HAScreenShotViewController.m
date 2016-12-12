//
//  HAScreenShotViewController.m
//  IOSStudy
//
//  Created by haiwang on 15-4-22.
//  Copyright (c) 2015年 hai. All rights reserved.
//

#import "HAScreenShotViewController.h"

@interface HAScreenShotViewController ()

@property (nonatomic, retain) IBOutlet UIScrollView *screenShotContentView;

@end

@implementation HAScreenShotViewController

- (void)dealloc
{
    [_screenShotContentView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _screenShotContentView.contentSize = CGSizeMake(320.0f, 800.0f);
}

- (IBAction)onScreenShotBtnClicked:(id)sender
{
    UIGraphicsBeginImageContext(_screenShotContentView.contentSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(_screenShotContentView.frame);
    [_screenShotContentView.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}

@end
