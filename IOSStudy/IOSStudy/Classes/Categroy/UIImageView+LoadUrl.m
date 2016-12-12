//
//  UIImageView+LoadUrl.m
//  IOSStudy
//
//  Created by haiwang on 14-11-18.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "UIImageView+LoadUrl.h"

@implementation UIImageView (LoadUrl)

- (void)setImageUrl:(NSString *) url
{
    [self performSelectorInBackground:@selector(setImageUrl2:) withObject:url];
}

//第一种异步加载图片方式
- (void)setImageUrl2:(NSString *)url
{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    UIImage *image = [UIImage imageWithData:data];
    [self performSelectorOnMainThread:@selector(setupImage:) withObject:image waitUntilDone:NO];
}

//第二种异步加载图片方式
- (void)setImageUrl3:(NSString *)url
{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}

- (void)setupImage:(UIImage *) image
{
    [self setImage:image];
//    [self setNeedsLayout];
}

#pragma mark -- NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    UIImage *image = [UIImage imageWithData:data];
    [self setImage:image];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"加载图片完成");
    [connection release];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"加载图片失败：%@",error);
    [connection release];
}

@end
