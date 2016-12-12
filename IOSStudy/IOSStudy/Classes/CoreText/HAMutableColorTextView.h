//
//  HAMutableColorTextView.h
//  IOSStudy
//
//  Created by haiwang on 14-12-26.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface HAMutableColorTextView : UIView

@property (nonatomic, copy) NSString *text;

@property (nonatomic, assign) float fontSize;


- (void)setFontColor:(UIColor *) color forRange:(NSRange) range;


@end
