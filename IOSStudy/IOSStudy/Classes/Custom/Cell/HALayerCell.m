//
//  HALayerCell.m
//  IOSStudy
//
//  Created by hai on 14-6-30.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HALayerCell.h"

@interface HALayerCell ()

@property (nonatomic, retain) UIImage *iconImage;

@property (nonatomic, retain) NSString *content;

@property (nonatomic, retain) CALayer *imageLayer;

@property (nonatomic, retain) CATextLayer *textLayer;

@end

@implementation HALayerCell

- (void)dealloc
{
    [_iconImage release];
    [_content release];
    [_imageLayer release];
    [_textLayer release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addImageLayer];
        [self addTextLayer];
        [self addShapeLayer];
        [self addGrandientLayer];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadLayer
{
    self.layer.masksToBounds = YES;
}

- (void)addImageLayer
{
    //makesofbounds属性设置为yes会影响同一个layer上的阴影显示效果
    CALayer *shadowLayer = [[[CALayer alloc] init] autorelease];
    shadowLayer.frame = CGRectMake(10, 10, 60, 60);
    shadowLayer.backgroundColor = [ UIColor whiteColor].CGColor;//为实现阴影效果，必须设置backgroundcolor属性
    shadowLayer.cornerRadius = 5.0f;
    shadowLayer.shadowOffset = CGSizeMake(2, 2);
    shadowLayer.shadowRadius = 2.0f;
    shadowLayer.shadowOpacity = 0.9;
    shadowLayer.shadowColor = [UIColor blackColor].CGColor;
    [self.layer addSublayer:shadowLayer];
    
    self.imageLayer = [[[CALayer alloc] init] autorelease];
    _imageLayer.frame = CGRectMake(10, 10, 60, 60);
    _imageLayer.backgroundColor = [UIColor redColor].CGColor;
    _imageLayer.cornerRadius = 5.0f;//添加弧度
    _imageLayer.borderColor = [UIColor whiteColor].CGColor;
    _imageLayer.borderWidth = 1.0f;
//    _imageLayer.shadowOffset = CGSizeMake(2, 2);
//    _imageLayer.shadowRadius = 2.0f;
//    _imageLayer.shadowColor = [UIColor blackColor].CGColor;
//    _imageLayer.shadowOpacity = 0.9;
    _imageLayer.masksToBounds = YES;//裁剪---会影响layer的shadow效果
    [self.layer addSublayer:_imageLayer];
    
}

- (void)addTextLayer
{
    self.textLayer = [[[CATextLayer alloc] init] autorelease];
    _textLayer.frame = CGRectMake(80, 10, 100, 21);
    _textLayer.fontSize = 14.0f;
    _textLayer.backgroundColor = [UIColor greenColor].CGColor;
    _textLayer.foregroundColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:_textLayer];
}

- (void)addGrandientLayer
{
    CAGradientLayer *gradientLayer = [[[CAGradientLayer alloc] init] autorelease];
    gradientLayer.frame = CGRectMake(200, 10, 100, 70);
    gradientLayer.backgroundColor = [UIColor orangeColor].CGColor;
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[UIColor greenColor].CGColor,(id)[UIColor redColor].CGColor,(id)[UIColor blueColor].CGColor, nil];
    gradientLayer.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.1f],[NSNumber numberWithFloat:0.6f],[NSNumber numberWithFloat:1.0f], nil];
    gradientLayer.startPoint = CGPointMake(0.1, 1.0);
    gradientLayer.endPoint = CGPointMake(0.8, 0.8);
    [self.layer addSublayer:gradientLayer];
}

- (void)addShapeLayer
{
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 20, 20)];
    CAShapeLayer *shapLayer = [[[CAShapeLayer alloc] init] autorelease];
    shapLayer.frame = CGRectMake(80, 40, 30, 30);
    shapLayer.path = path.CGPath;
    shapLayer.fillColor = [UIColor greenColor].CGColor;//改变path的颜色
    shapLayer.strokeColor = [UIColor orangeColor].CGColor;//边框的颜色
//    shapLayer.lineWidth = 4.0f;
//    shapLayer.borderColor = [UIColor redColor].CGColor;
//    shapLayer.borderWidth = 2.0f;
    shapLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.layer addSublayer:shapLayer];
}

- (void)addScrollerLayer
{
    CAScrollLayer *scrolLayer = [[[CAScrollLayer alloc] init] autorelease];
    scrolLayer.frame = CGRectMake(10, 70, 100, 60);
}

#pragma mark -- public methods

- (void)updateData:(UIImage *) icon andContent:(NSString *) content
{
    self.iconImage = icon;
    self.content = content;
    _imageLayer.contents = (id)self.iconImage.CGImage;
    _textLayer.string = self.content;
}

@end
