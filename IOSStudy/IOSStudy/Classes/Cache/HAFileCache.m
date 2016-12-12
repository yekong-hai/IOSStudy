//
//  HAFileCache.m
//  IOSStudy
//
//  Created by haiwang on 14-12-2.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAFileCache.h"

#define CACHE_DIR_NAME @"cache"

#define CACHE_IMAGE_DIR @"images"

@implementation HAFileCache

//获取缓存目录
- (NSString *)cacheDir
{
    NSArray *fileDirArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *dirPath = [fileDirArray objectAtIndex:0];
    NSString *cacheDir = [NSString stringWithFormat:@"%@",dirPath];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:cacheDir] == NO) {
        [manager createDirectoryAtPath:cacheDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return cacheDir;
}

//获取缓存目录下的图片地址
- (NSString *)imageCacheDir
{
    NSString *cacheDir = [self cacheDir];
    NSString *imageCacheDir = [NSString stringWithFormat:@"%@/%@",cacheDir,CACHE_IMAGE_DIR];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:imageCacheDir] == NO) {
        [manager createDirectoryAtPath:imageCacheDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSLog(@"%@",imageCacheDir);
    return imageCacheDir;
}

//获取图片地址url的图片名称
- (NSString *)imageCacheNameWithUrl:(NSString *) url
{
    NSArray *array = [url componentsSeparatedByString:@"/"];
    if (array.count > 2) {
        
    }
    return [array lastObject];
}

- (NSData *)imageWithUrl:(NSString *) imageUrl
{
    if (imageUrl == nil || imageUrl.length == 0) {
        return nil;
    }
    NSString *imageName = [self imageCacheNameWithUrl:imageUrl];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",[self imageCacheDir],imageName];
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isfileExist = [manager fileExistsAtPath:filePath];
    if (isfileExist) {
        return [NSData dataWithContentsOfFile:filePath];
    }else{
        //TODO:hai 缓存--如果图片只是换了内容，而名字还是原来的，需要确定如何再获取
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        //TODO:hai 需要网络元数据是否改变的etag
        [self saveImageInCache:imageName withData:imageData];
        return imageData;
    }
    return nil;
}

//异步加载
- (void)loadImageWithUrlForAsy:(NSString *) imageUrl onComplete:(void (^)(NSData *imageData)) onComplete
{
    [self loadImageWithUrlForAsy:imageUrl onComplete:onComplete isForceRefresh:NO];
}

- (void)loadImageWithUrlForAsy:(NSString *) imageUrl onComplete:(void (^)(NSData *imageData)) onComplete isForceRefresh:(BOOL) isForceRefresh
{
    dispatch_queue_t getImageQueue = dispatch_queue_create("加载图片", NULL);
    dispatch_async(getImageQueue, ^{
        if (imageUrl == nil || imageUrl.length == 0) {
            return;
        }
        NSString *imageName = [self imageCacheNameWithUrl:imageUrl];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@",[self imageCacheDir],imageName];
        NSFileManager *manager = [NSFileManager defaultManager];
        BOOL isfileExist = [manager fileExistsAtPath:filePath];
        NSData *imageData = nil;
        if (isfileExist && isForceRefresh == NO) {
            imageData = [NSData dataWithContentsOfFile:filePath];
        }else{
            //TODO:hai 缓存--如果图片只是换了内容，而名字还是原来的，需要确定如何再获取
            imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
            if (imageData == nil) {
                NSLog(@"下载图片%@失败,下载地址%@",imageName,imageUrl);
            }
            //TODO:hai 需要网络元数据是否改变的etag
            BOOL isSave = [self saveImageInCache:imageName withData:imageData];
            if (isSave) {
                NSLog(@"保存图片%@成功",imageName);
            }else{
                NSLog(@"保存图片%@失败",imageName);
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            onComplete(imageData);
        });
    });
    dispatch_release(getImageQueue);
}

- (BOOL)saveImageInCache:(NSString *)imageName withData:(NSData *) data
{
   return [data writeToFile:[NSString stringWithFormat:@"%@/%@",[self imageCacheDir],imageName] atomically:YES];
}

@end
