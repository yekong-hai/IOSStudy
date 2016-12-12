//
//  HALineLabel.h
//  IOSStudy
//
//  Created by hai on 14-6-25.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum HALineType
{
    HALineHorizontalBottomType,//底部横线
    HALineHorizontalCenterType,//水平居中
    HALineDiagonalType//对角线
} HALineType ;

@interface HALineLabel : UILabel

//线的颜色
@property (nonatomic, retain) UIColor *lineColor;

//划线的方式
@property (nonatomic, assign) HALineType lineType;

//线的宽度
@property (nonatomic, assign) float lineWith;

@end
