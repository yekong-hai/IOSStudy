//
//  HACacheViewController.m
//  IOSStudy
//
//  Created by haiwang on 14-12-2.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HACacheViewController.h"
#import "HAFileCache.h"

@interface HACacheViewController ()

@property (nonatomic, retain) IBOutlet UIImageView *imageView;

@property (nonatomic, retain) HAFileCache *cache;

@end

@implementation HACacheViewController

- (void)dealloc
{
    [_imageView release];
    [_cache release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *imageUrl = @"http://mimages.vancl.com/oms/2014_6_12_18_7_49_631.jpg";
    imageUrl = @"http://b.zol-img.com.cn/desk/bizhi/image/5/144x90/1417403299240.jpg";
    _cache = [[HAFileCache alloc] init];
    [_cache loadImageWithUrlForAsy:imageUrl onComplete:^(NSData *imageData) {
        //TODO:hai 图片下载之后，需要main线程进行更新UI，否则不会有效果
        [_imageView setImage:[UIImage imageWithData:imageData]];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
