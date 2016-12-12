//
//  HAMoreSegmentControl.m
//  IOSStudy
//
//  Created by haiwang on 15/12/25.
//  Copyright © 2015年 hai. All rights reserved.
//

#import "HAMoreSegmentControl.h"

@interface HAMoreSegmentControl ()
{
    CGFloat _cellWidth;
    CGFloat _cellHeight;
    CGFloat _minScrollViewContentSizeWidth;
}

@property (nonatomic, retain) UIScrollView *mainScrollView;

@end

@implementation HAMoreSegmentControl

- (void)dealloc
{
    [_titleArray release];
    [_mainScrollView release];
    [super dealloc];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cellWidth = 60.0f;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _cellWidth = 60.0f;
        _minScrollViewContentSizeWidth = frame.size.width;
        _cellHeight = frame.size.height;
    }
    return self;
}

- (void)addKVOForFrame
{
    [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"frame"]) {
        _minScrollViewContentSizeWidth = self.bounds.size.width;
        _cellHeight = self.bounds.size.height;
    }
}


- (UIScrollView *)mainScrollView
{
    if (_mainScrollView == nil) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        [_mainScrollView setContentSize:CGSizeMake(_minScrollViewContentSizeWidth, _cellHeight)];
    }
    return _mainScrollView;
}

- (void)setTitleArray:(NSArray *)titleArray
{
    if (_titleArray) {
        [_titleArray release];
    }
    _titleArray = [titleArray retain];
}

- (void)setupTitleSegment
{
    if (_titleArray.count > 0) {
        
        for (int i = 0; i < _titleArray.count; i++) {
            id item = _titleArray[i];
            if ([item isKindOfClass:[NSString class]]) {
                NSString *title = (NSString *) item;
                UILabel *itemLabel = [[UILabel alloc] init];
                itemLabel.frame = CGRectMake(_cellWidth * i, 0, _cellWidth, _cellHeight);
                itemLabel.text = title;
            }
        }
    }
}

- (void)adjustScrollViewContentSize
{
    if (_titleArray.count > 0) {
        CGFloat cellsWidth = _cellWidth * _titleArray.count;
        if (cellsWidth > _minScrollViewContentSizeWidth) {
            [_mainScrollView setContentSize:CGSizeMake(cellsWidth, _cellHeight)];
        }
    }
}

@end
