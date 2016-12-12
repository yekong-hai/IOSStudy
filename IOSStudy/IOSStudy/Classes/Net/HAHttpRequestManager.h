//
//  HAHttpRequestManager.h
//  IOSStudy
//
//  Created by hai on 14-7-3.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HARootHttpRequest.h"

/**
 * 助手类，
 * 当request没有被retain的时候，会自己dealloc，但又不想controller来retain这个request，所以做个容器来add这个request，以达到retain的目的
 */
@interface HAHttpRequestManager : NSObject

+(HAHttpRequestManager *)shareManager;

- (void)addHttpRequest:(HARootHttpRequest *) request;

- (void)removeHttpRequest:(HARootHttpRequest *) request;

- (void)cancelAllRequest;

@end
