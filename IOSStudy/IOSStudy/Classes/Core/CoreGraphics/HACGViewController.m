//
//  HACGViewController.m
//  IOSStudy
//
//  Created by hai on 14-7-9.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HACGViewController.h"
#import "HAIconView.h"
#import "HACGView.h"
#import <CoreImage/CoreImage.h>

@interface HACGViewController ()

@property (nonatomic, retain) IBOutlet UIImageView *imageView;

@end

@implementation HACGViewController

- (void)dealloc
{
    [_imageView release];
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
    [self addIconView];
    [self addCGView];
    [self addCIImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addIconView
{
    HAIconView *iconView = [[HAIconView alloc] initWithFrame:CGRectMake(20, 10, 280, 250)];
    iconView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:iconView];
    [iconView release];
}

- (void)addCGView
{
    HACGView *cgView = [[HACGView alloc] initWithFrame:CGRectMake(20, 280, 280, 100)];
    [self.view addSubview:cgView];
    [cgView release];
}

- (void)addCIImage
{
    UIImage *image = [UIImage imageNamed:@"btn_sina.png"];
    CIFilter *sFilter = [CIFilter filterWithName:@"CISepiaTone"];
    [sFilter setValue:image.CIImage forKey:@"inputImage"];
    NSNumber *intensity = [NSNumber numberWithFloat:0.5];
    [sFilter setValue:intensity forKey:@"inputIntensity"];
    CIImage *ciImage = [sFilter outputImage];
    UIImage *newImage = [UIImage imageWithCIImage:ciImage];
    _imageView.image = newImage;
}

@end
