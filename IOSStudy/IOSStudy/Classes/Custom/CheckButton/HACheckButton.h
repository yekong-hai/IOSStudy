//
//  HACheckButton.h
//  IOSStudy
//
//  Created by haiwang on 14-8-31.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum HACheckButtonState{
    HACheckButtonStateNormal,
    HACheckButtonStateChecked
}HACheckButtonState;


@interface HACheckButton : UIView

@property (nonatomic, assign) BOOL isChecked;

- (void)setCheckImage:(UIImage *) image forState:(HACheckButtonState) checkState;

- (void)setCheckContent:(NSString *)content;

@end
