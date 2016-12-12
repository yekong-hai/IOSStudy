//
//  HAFileCache.h
//  IOSStudy
//
//  Created by haiwang on 14-12-2.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HAFileCache : NSObject

- (NSData *)imageWithUrl:(NSString *) imageUrl;

//异步加载
- (void)loadImageWithUrlForAsy:(NSString *) imageUrl onComplete:(void (^)(NSData *imageData)) onComplete;

//异步加载并且看是否强制刷新网络数据
- (void)loadImageWithUrlForAsy:(NSString *) imageUrl onComplete:(void (^)(NSData *imageData)) onComplete isForceRefresh:(BOOL) isForceRefresh;

@end
