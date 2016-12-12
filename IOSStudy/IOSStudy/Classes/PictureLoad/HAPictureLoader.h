//
//  HAPictureLoader.h
//  IOSStudy
//
//  Created by haiwang on 15/12/23.
//  Copyright © 2015年 hai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HAPictureLoader;

@protocol HAPictureLoaderDelegate <NSObject>

- (void)loader:(HAPictureLoader *) loader withFinishLoadImage:(UIImage *) image andImageUrl:(NSString *) urlString andIndex:(NSInteger) index;

//当完成了一批次任务
- (void)onFinishBatchTaskWithLoader:(HAPictureLoader *)loader;

@end

@interface HAPictureLoader : NSObject

@property (nonatomic, assign) id<HAPictureLoaderDelegate> delegate;

- (void)addImageUrls:(NSArray *) imageUrlArray;

@end
