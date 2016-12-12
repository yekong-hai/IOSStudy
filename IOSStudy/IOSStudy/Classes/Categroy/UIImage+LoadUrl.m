//
//  UIImage+LoadUrl.m
//  IOSStudy
//
//  Created by haiwang on 14-11-18.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "UIImage+LoadUrl.h"

@implementation UIImage (LoadUrl)

- (instancetype)initWithUrl:(NSString *) url
{
    self = [super init];
    if (self) {
        [self requestImageWithUrl:url];
    }
    return self;
}

- (void)requestImageWithUrl:(NSString *) url
{
    if (url) {
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        [connection start];
    }
}

#pragma mark -- NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    UIImage *image = [UIImage imageWithData:data];
    self = image;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [connection release];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [connection release];
}

@end
