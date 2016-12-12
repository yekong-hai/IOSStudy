//
//  HARoundCornerCell.m
//  IOSStudy
//
//  Created by haiwang on 15-4-2.
//  Copyright (c) 2015年 hai. All rights reserved.
//

#import "HARoundCornerCell.h"

#define HA_ROUNDCORNER_RADIO 3.0f

#define HA_ROUNDCORNER_TOP_BOTTOM_LINE_HEIGHT 0.5f

@interface HARoundCornerCell ()

@property (nonatomic, retain) UIView *topLine;

@property (nonatomic, retain) UIView *bottomLine;

@property (nonatomic, retain) UIView *roundCornerView;

@end

@implementation HARoundCornerCell

- (void)dealloc
{
    [_topLine release];
    [_borderColor release];
    [_bottomLine release];
    [_roundBackgroundColor release];
    [_roundCornerView release];
    [super dealloc];
}

- (void)initTopLine
{
    self.topLine = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    self.topLine.backgroundColor = _borderColor;
    [self.contentView insertSubview:_topLine atIndex:2];
}

- (void)initBottomLine
{
    self.bottomLine = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    self.bottomLine.backgroundColor = _borderColor;
    [self.contentView insertSubview:_bottomLine atIndex:1];
}

- (void)initRoundCornerView
{
    self.roundCornerView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [self.contentView insertSubview:_roundCornerView atIndex:0];
}

- (void)initRoundCornerViews
{
    self.clipsToBounds = YES;
    [self initRoundCornerView];
    [self initTopLine];
    [self initBottomLine];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        _padding = 10.0f;
        _borderColor = [[UIColor darkGrayColor] retain];
        _roundBackgroundColor = [[UIColor whiteColor] retain];
        [self initRoundCornerViews];
    }
    return self;
}

#pragma mark -- public methods

- (void)setTopCellStyle
{
    self.roundCornerView.frame = CGRectMake(_padding, 0, self.bounds.size.width - _padding * 2, self.bounds.size.height + 5);
    self.roundCornerView.backgroundColor = _roundBackgroundColor;
    self.roundCornerView.layer.cornerRadius = HA_ROUNDCORNER_RADIO;
    self.roundCornerView.layer.borderColor = _borderColor.CGColor;
    self.roundCornerView.layer.borderWidth = 1.0f;
    
    self.topLine.frame = CGRectZero;
    self.bottomLine.frame = CGRectMake(_padding, self.bounds.size.height - HA_ROUNDCORNER_TOP_BOTTOM_LINE_HEIGHT, self.bounds.size.width - _padding * 2, HA_ROUNDCORNER_TOP_BOTTOM_LINE_HEIGHT);
}

- (void)setMiddleCellStyle
{
    self.roundCornerView.frame = CGRectMake(_padding, -5.0f, self.bounds.size.width - _padding * 2, self.bounds.size.height + 10.0f);
    self.roundCornerView.backgroundColor = _roundBackgroundColor;
    self.roundCornerView.layer.cornerRadius = 0.0f;
    self.roundCornerView.layer.borderColor = _borderColor.CGColor;
    self.roundCornerView.layer.borderWidth = 1.0f;
    
    self.topLine.frame = CGRectMake(_padding, 0, self.bounds.size.width - _padding * 2, HA_ROUNDCORNER_TOP_BOTTOM_LINE_HEIGHT);
    self.bottomLine.frame = CGRectMake(_padding, self.bounds.size.height - HA_ROUNDCORNER_TOP_BOTTOM_LINE_HEIGHT, self.bounds.size.width - _padding * 2, HA_ROUNDCORNER_TOP_BOTTOM_LINE_HEIGHT);
}

- (void)setBottomCellStyle
{
    self.roundCornerView.frame = CGRectMake(_padding, -5.0f, self.bounds.size.width - _padding * 2, self.bounds.size.height + 5.0f);
    self.roundCornerView.backgroundColor = _roundBackgroundColor;
    self.roundCornerView.layer.cornerRadius = HA_ROUNDCORNER_RADIO;
    self.roundCornerView.layer.borderColor = _borderColor.CGColor;
    self.roundCornerView.layer.borderWidth = 1.0f;
    
    self.topLine.frame = CGRectMake(_padding, 0, self.bounds.size.width - _padding * 2, HA_ROUNDCORNER_TOP_BOTTOM_LINE_HEIGHT);
    self.bottomLine.frame = CGRectZero;
}

- (void)setSingleCellStyle
{
    self.roundCornerView.frame = CGRectMake(_padding, 0, self.bounds.size.width - _padding * 2, self.bounds.size.height);
    self.roundCornerView.backgroundColor = _roundBackgroundColor;
    self.roundCornerView.layer.cornerRadius = HA_ROUNDCORNER_RADIO;
    self.roundCornerView.layer.borderColor = _borderColor.CGColor;
    self.roundCornerView.layer.borderWidth = 1.0f;
    
    self.topLine.frame = CGRectZero;
    self.bottomLine.frame = CGRectZero;
}

- (void)setCellStyleWithDataCounts:(NSInteger) count andIndex:(NSInteger) index
{
    if (count == 1) {
        [self setSingleCellStyle];
    }else{
        if (index == 0) {
            [self setTopCellStyle];
        }else if (index == count - 1){
            [self setBottomCellStyle];
        }else{
            [self setMiddleCellStyle];
        }
    }
}

@end
