//
//  UIImage+LoadUrl.h
//  IOSStudy
//
//  Created by haiwang on 14-11-18.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LoadUrl)<NSURLConnectionDataDelegate>

- (instancetype)initWithUrl:(NSString *) url;

@end
