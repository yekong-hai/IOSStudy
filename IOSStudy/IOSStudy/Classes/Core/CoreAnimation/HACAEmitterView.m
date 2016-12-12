//
//  HACAEmitterView.m
//  IOSStudy
//
//  Created by hai on 14-7-10.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HACAEmitterView.h"
#import <QuartzCore/QuartzCore.h>

@implementation HACAEmitterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

//粒子效果
- (void)addEmitterAnimation
{
    //为火箭创建发生器图层
    CAEmitterLayer *mortor = [CAEmitterLayer layer];
    mortor.emitterPosition = CGPointMake(100, 300 );
    mortor.renderMode = kCAEmitterLayerAdditive;
    
    //为火箭创建不可见的粒子
    CAEmitterCell *rocket = [CAEmitterCell emitterCell];
    rocket.emissionRange = M_PI/4;
    rocket.emissionLongitude = -M_PI /2;
    rocket.emissionLatitude = 0;
    rocket.lifetime = 1.6;
    rocket.birthRate = 1;
    rocket.velocity = 400;
    rocket.velocityRange = 100;
    rocket.yAcceleration = 250;
    rocket.color = CGColorCreateCopy([UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5].CGColor);
    rocket.redRange = 0.5;
    rocket.greenRange = 0.5;
    rocket.blueRange = 0.5;
    
    [rocket setName:@"rocket"];
    mortor.emitterCells = [NSArray arrayWithObjects:rocket, nil];
    [self.layer addSublayer:mortor];
}

@end
