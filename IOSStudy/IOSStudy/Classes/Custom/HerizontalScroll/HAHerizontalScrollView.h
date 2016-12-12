//
//  HAHerizontalScrollView.h
//  IOSStudy
//
//  Created by hai on 14-6-26.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 * 设计错误，不能使用scrollview当做主view
 * delete
 */

@interface HAHerizontalScrollView : UIScrollView

- (id)initWithImages:(NSArray *) imageArray;

@end
