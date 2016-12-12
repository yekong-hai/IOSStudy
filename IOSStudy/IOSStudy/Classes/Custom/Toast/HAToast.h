//
//  HAToast.h
//  IOSStudy
//
//  Created by hai on 14-7-3.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <Foundation/Foundation.h>

//位置
typedef enum HAToastPosition{
    HAToastPositionUp,
    HAToastPositionCenter,
    HAToastPositionDown
}HAToastPosition;

/**
 * 提示toast
 * android的toast实现效果
 */

@interface HAToast : NSObject

+ (void)showToast:(NSString *) message;

+ (void)showToast:(NSString *) message center:(CGPoint) centerPoint;

+ (void)showToast:(NSString *) message position:(HAToastPosition) position;

@end
