//
//  HACheckButton.m
//  IOSStudy
//
//  Created by haiwang on 14-8-31.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HACheckButton.h"

#define PADDING 0.0f

@interface HACheckButton ()
{

}

@property (nonatomic, assign) HACheckButtonState checkState;

@property (nonatomic, retain) UIImageView *checkImageView;

@property (nonatomic, retain) UILabel *contentLabel;

@property (nonatomic, retain) UIImage *normalImage;

@property (nonatomic, retain) UIImage *checkedImage;

@property (nonatomic, copy) NSString *content;

@end

@implementation HACheckButton

#pragma mark -- init methods

- (void)dealloc
{
    [_checkImageView release];
    [_contentLabel release];
    [_normalImage release];
    [_checkedImage release];
    [_content release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _checkState = HACheckButtonStateNormal;
        [self setupViews];
        [self loadDefaultImages];
    }
    return self;
}

#pragma mark -- private methods

- (void)setupViews
{
    [self setupCheckImageView];
    [self setupContentLabel];
}

- (void)setupCheckImageView
{
    _checkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(PADDING, PADDING, self.frame.size.height - PADDING * 2, self.frame.size.height - PADDING * 2)];
    _checkImageView.backgroundColor = [UIColor clearColor];
    [_checkImageView setUserInteractionEnabled:YES];
    [self addSubview:_checkImageView];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onCheckImageViewClicked:)];
    [_checkImageView addGestureRecognizer:tapRecognizer];
    [tapRecognizer release];
}

- (void)loadDefaultImages
{
    self.normalImage = [UIImage imageNamed:@"btn_sina"];
    self.checkedImage = [UIImage imageNamed:@"btn_wexin"];
    [self resetCheckImage];
}

- (void)setupContentLabel
{
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.height, PADDING, self.frame.size.width - self.frame.size.height, self.frame.size.height - PADDING * 2)];
    _contentLabel.backgroundColor = [UIColor clearColor];
    _contentLabel.textColor = [UIColor blackColor];
    [self addSubview:_contentLabel];
}

- (void)onCheckImageViewClicked:(id) sender
{
    self.isChecked = !self.isChecked;
    [self resetCheckImage];
}

- (void)resetCheckImage
{
    if (self.isChecked) {
        [_checkImageView setImage:_checkedImage];
    }else{
        [_checkImageView setImage:_normalImage];
    }
}

#pragma mark -- public methods

- (void)setCheckImage:(UIImage *) image forState:(HACheckButtonState) checkState
{
    if (checkState == HACheckButtonStateNormal) {
        self.normalImage = image;
    }else if (checkState == HACheckButtonStateChecked){
        self.checkedImage = image;
    }else{
        self.normalImage = image;
    }
}

- (void)setCheckContent:(NSString *)content
{
    self.content = content;
    _contentLabel.text = content;
}



@end
