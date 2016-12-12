//
//  HAChangeHighCell.m
//  IOSStudy
//
//  Created by hai on 14-6-25.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAChangeHighCell.h"

@interface HAChangeHighCell ()

@property (nonatomic, retain) UILabel *titleLabel;

@property (nonatomic, retain) UILabel *descriptionLabel;

@property (nonatomic, retain) UIButton *arrowButton;

@end

@implementation HAChangeHighCell

#pragma mark -- init methods

- (void)dealloc
{
    [_titleLabel release];
    [_descriptionLabel release];
    [_arrowButton release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)initViews
{
    //title
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 21)];
    [self addSubview:_titleLabel];
    
    //description
    _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 35, 280, 21)];
    _descriptionLabel.backgroundColor = [UIColor orangeColor];
    _descriptionLabel.numberOfLines = 0;
    _descriptionLabel.font = [UIFont systemFontOfSize:13.0f];
    [self addSubview:_descriptionLabel];
    
    //arrow
    
    _arrowButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    _arrowButton.center = CGPointMake(300, 40);
    [self addSubview:_arrowButton];
    
}

#pragma mark -- private methods

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
//    NSLog(@"cell select %d",selected);
}

#pragma mark -- public methods

- (void)setData:(NSString *) title withDescription:(NSString *) description
{
    _titleLabel.text = title;
    _descriptionLabel.text = description;
}

//获取cell的高度
- (CGFloat)heightWithCell
{
    return _arrowButton.frame.origin.y + _arrowButton.frame.size.height + 10.0f;
}

+ (CGFloat)heightWithCellNormal
{
    return 60.0f;
}

+ (CGFloat)heightWithCellSelect
{
    return 120.0f;
}

//展开
- (void)show:(BOOL) isShow
{
    CGRect cellFrame = self.frame;
    CGRect frame = _descriptionLabel.frame;
    if (isShow) {
        cellFrame.size.height = [HAChangeHighCell heightWithCellSelect];
        frame.size.height = 100.0f;
        _descriptionLabel.numberOfLines = 0;
    }else{
        frame.size.height = 21.0f;
        cellFrame.size.height = [HAChangeHighCell heightWithCellNormal];
        _descriptionLabel.numberOfLines = 1;
    }
    _descriptionLabel.frame = frame;
    self.frame = cellFrame;
//    [self setNeedsDisplay];
    [self setNeedsLayout];
}

@end
