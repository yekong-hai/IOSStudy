//
//  HAPictureLoadViewController.m
//  IOSStudy
//
//  Created by haiwang on 15/12/23.
//  Copyright © 2015年 hai. All rights reserved.
//

#import "HAPictureLoadViewController.h"
#import "HAPictureLoader.h"

@interface HAPictureLoadViewController ()<UIScrollViewDelegate,HAPictureLoaderDelegate>
{
    CGFloat _screenWidth;
    CGFloat _imagesHeight;
    NSInteger _countForLoad;
}

@property (nonatomic, retain) IBOutlet UIScrollView *imagesScrollView;

@property (nonatomic, retain) NSArray *imageArray;

@property (nonatomic, retain) HAPictureLoader *pictureLoader;

@end

@implementation HAPictureLoadViewController

- (void)dealloc
{
    [_imageArray release];
    [_imagesScrollView release];
    [super dealloc];
}

- (instancetype)initWithTitile:(NSString *)title
{
    self = [super initWithTitile:title];
    if (self) {
        _imageArray = [[NSArray arrayWithObjects:@"http://imgsrc.baidu.com/forum/pic/item/3ac79f3df8dcd1004e9102b8728b4710b9122f1e.jpg",@"http://pic3.nipic.com/20090512/2146843_144337074_2.jpg",@"http://pic17.nipic.com/20111104/8391691_182258288183_2.jpg",@"http://pic15.nipic.com/20110616/7177713_105538509375_2.jpg",@"http://pic3.nipic.com/20090527/2488154_225613074_2.jpg", nil] retain];
        _screenWidth = [UIScreen mainScreen].bounds.size.width;
    }
    return self;
}

- (HAPictureLoader *)pictureLoader
{
    if (_pictureLoader == nil) {
        _pictureLoader = [[HAPictureLoader alloc] init];
        _pictureLoader.delegate = self;
    }
    return _pictureLoader;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _countForLoad = 1;
    NSArray *tempArray = [_imageArray subarrayWithRange:NSMakeRange(0, _countForLoad)];
    [self.pictureLoader addImageUrls:tempArray];
}

#pragma mark -- private methods

- (void)createNextImageViewWithImage:(UIImage *) image
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    float imageViewHeight = image.size.height * _screenWidth / image.size.width;
    imageView.frame = CGRectMake(0, _imagesHeight, _screenWidth, imageViewHeight);
    [_imagesScrollView addSubview:imageView];
    [imageView release];
    _imagesHeight += imageViewHeight;
    if (_imagesHeight < _imagesScrollView.frame.size.height) {
        [_imagesScrollView setContentSize:CGSizeMake(_screenWidth, _imagesScrollView.frame.size.height + 100.0f)];
    }else{
        [_imagesScrollView setContentSize:CGSizeMake(_screenWidth, _imagesHeight + 100.0f)];
    }
}

#pragma mark -- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating");
    NSLog(@"_imagesScrollView.contentOffset.y = %f",_imagesScrollView.contentOffset.y);
    if (_imagesScrollView.contentOffset.y + _imagesScrollView.frame.size.height > _imagesHeight) {
        if (_countForLoad < _imageArray.count) {
            NSInteger tempCount = 1;
            NSArray *tempArray = [_imageArray subarrayWithRange:NSMakeRange(_countForLoad, tempCount)];
            _countForLoad += tempCount;
            [self.pictureLoader addImageUrls:tempArray];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"scrollViewDidEndDragging");
}

#pragma mark -- HAPictureLoaderDelegate

- (void)loader:(HAPictureLoader *)loader withFinishLoadImage:(UIImage *)image andImageUrl:(NSString *)urlString andIndex:(NSInteger)index
{
    [self createNextImageViewWithImage:image];
}

- (void)onFinishBatchTaskWithLoader:(HAPictureLoader *)loader
{
    //计算图片和scrollview的frame的高度
    if (_imagesHeight < _imagesScrollView.frame.size.height) {
        if (_countForLoad < _imageArray.count) {
            NSInteger tempCount = 1;
            NSArray *tempArray = [_imageArray subarrayWithRange:NSMakeRange(_countForLoad, tempCount)];
            _countForLoad += tempCount;
            [self.pictureLoader addImageUrls:tempArray];
        }
    }
}

@end
