//
//  HAAutoLayoutViewController.h
//  IOSStudy
//
//  Created by haiwang on 14-10-27.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HASuperViewController.h"

/*
 * 由于使用xcode6来进行自适应布局的操作，在xib文件中布局约束是和view相对的，所以不能使用HASuperConroller来增加底层的scrollview，否则布局就失效了，因为各种view又加到了scrollview上
 */
@interface HAAutoLayoutViewController : UIViewController

@end
