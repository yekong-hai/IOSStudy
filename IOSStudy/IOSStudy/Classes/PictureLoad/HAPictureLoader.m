//
//  HAPictureLoader.m
//  IOSStudy
//
//  Created by haiwang on 15/12/23.
//  Copyright © 2015年 hai. All rights reserved.
//

#import "HAPictureLoader.h"

//NSURLConnectionDataDelegate,NSURLConnectionDelegate,NSURLConnectionDownloadDelegate
@interface HAPictureLoader ()<NSURLConnectionDataDelegate>
{
    NSMutableData *_tempImageData;
    NSInteger _index;
    NSMutableArray *_imageUrlArray;
    BOOL _isLoading;
    BOOL _isFinishBatchTask;//是否完成了一批任务，目前数组中的所有图片请求
}

@property (nonatomic, retain) NSURLConnection *urlConnection;

@end

@implementation HAPictureLoader

- (void)dealloc
{
    [_imageUrlArray release];
    [_urlConnection cancel];
    [_urlConnection release];
    [_tempImageData release];
    [super dealloc];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _index = 0;
        _imageUrlArray = [[NSMutableArray array] retain];
    }
    return self;
}

- (void)addImageUrls:(NSArray *) imageUrlArray
{
    @synchronized(self) {
        NSLog(@"向队列中添加图片数组:%@",imageUrlArray);
        NSInteger count = _imageUrlArray.count;
        [_imageUrlArray addObjectsFromArray:imageUrlArray];
        NSLog(@"队列中图片数组:%@",_imageUrlArray);
        if (_index >= count) {//如果当前已经全部完成，而又新加入了图片数据
            [self startLoadNextImage];
        }
    }
}

- (void)startLoadNextImage
{
    if (_tempImageData) {
        [_tempImageData release];
    }
    _tempImageData = [[NSMutableData alloc] init];
    
    NSURL *url = [NSURL URLWithString:[_imageUrlArray objectAtIndex:_index]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    if (_urlConnection) {
        [_urlConnection cancel];
        [_urlConnection release];
    }
    _isFinishBatchTask = NO;
    _isLoading = YES;
    _urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [_urlConnection start];
    NSLog(@"加载图片");
}

#pragma mark -- NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_tempImageData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"图片加载成功");
    _isLoading = NO;
    if (_delegate && [_delegate respondsToSelector:@selector(loader:withFinishLoadImage:andImageUrl:andIndex:)]) {
        UIImage *image = [[UIImage alloc] initWithData:_tempImageData];
        [_delegate loader:self withFinishLoadImage:image andImageUrl:[_imageUrlArray objectAtIndex:_index] andIndex:_index];
        [image release];
        _index++;

        if (_index == _imageUrlArray.count) {
            _isFinishBatchTask = YES;
            if (_delegate && [_delegate respondsToSelector:@selector(onFinishBatchTaskWithLoader:)]) {
                [_delegate onFinishBatchTaskWithLoader:self];
            }
        }else if (_index < _imageUrlArray.count) {
            [self startLoadNextImage];
            _isFinishBatchTask = NO;
        }
        
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"图片加载失败");
    _isLoading = NO;
    [self startLoadNextImage];
}

@end
