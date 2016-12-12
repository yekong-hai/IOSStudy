//
//  HAToast.m
//  IOSStudy
//
//  Created by hai on 14-7-3.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAToast.h"

//label距离容器的
#define LABEL_PADDING 5.0f

//字体大小
#define MESSAGE_FONT_SIZE 14.0f

//容器最大宽度
#define CONTAINER_MAX_WIDTH 300.0f

//容器最小宽度
#define CONTAINER_MIN_WIDTH 50.0f

//隐藏toast需要的时间间隔
#define TOAST_HIDDEN_DELAY_SECONDS 3.0f

@interface HAToast ()
{
    CGRect _containerFrame;
    //容器最大宽度
    float _containerMaxWidth;
    //容器最小宽度
    float _containerMinWidth;
    
    CGSize _labelSize;
}

@property (nonatomic, retain) UIView *containerView;

@property (nonatomic, retain) UILabel *messageLabel;

@property (nonatomic, retain) UIColor *messageColor;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, assign) float during;

@property (nonatomic, assign) HAToastPosition position;

@end

@implementation HAToast

#pragma mark -- init methods

- (void)dealloc
{
    [_message release];
    [_containerView release];
    [_messageLabel release];
    [_messageColor release];
    [super dealloc];
}

- (id)initWithMessage:(NSString *) message
{
    self = [super init];
    if (self) {
        _message = [message copy];
        _messageColor = [UIColor whiteColor];
        _position = HAToastPositionDown;
        [self calculateMaxAndMinWidth];
        [self calculateMessageLabelFrameWithContent];
        [self calculateContainerBoundsWithLabelFrame];
        [self initContainerView];
        [self initMessageLabel];
        [self showToAppWindow];
    }
    return self;
}

- (void)initContainerView
{
    self.containerView = [[[UIView alloc] initWithFrame:_containerFrame] autorelease];
    _containerView.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.8f];
    _containerView.layer.cornerRadius = 5.0f;
    _containerView.layer.masksToBounds = YES;
    _containerView.userInteractionEnabled = NO;
}

- (void)initMessageLabel
{
    self.messageLabel = [[[UILabel alloc] initWithFrame:CGRectMake(LABEL_PADDING, LABEL_PADDING, _labelSize.width, _labelSize.height)] autorelease];
    _messageLabel.font = [UIFont systemFontOfSize:MESSAGE_FONT_SIZE];
    _messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _messageLabel.numberOfLines = 0;
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    _messageLabel.textColor = _messageColor;
    _messageLabel.text = _message;
    _messageLabel.backgroundColor = [UIColor clearColor];
    [_containerView addSubview:_messageLabel];
}

#pragma mark -- private methods

//根据屏幕计算容器的最大最小宽度
- (void)calculateMaxAndMinWidth
{
    float screenWidth = [UIScreen mainScreen].bounds.size.width;
    _containerMaxWidth = screenWidth * 0.8f;
    _containerMinWidth = CONTAINER_MIN_WIDTH;
}

//计算label的frame---根据内容
- (void)calculateMessageLabelFrameWithContent
{
    if (_message && _message.length > 0) {
        float stringWidth = _message.length * MESSAGE_FONT_SIZE;
        if (stringWidth < _containerMaxWidth) {//如果小于容器宽度的最大值----一行
            if (stringWidth < _containerMinWidth) {
                stringWidth = _containerMinWidth;
            }
            _labelSize = CGSizeMake(stringWidth, 21.0f);
        }else{//如果大于容器最大值----多行
            CGSize labelSize;// = CGSizeMake(_containerMaxWidth, 1000);
//            labelSize = [_message sizeWithFont:[UIFont systemFontOfSize:MESSAGE_FONT_SIZE] forWidth:_containerMaxWidth lineBreakMode:NSLineBreakByWordWrapping];
            labelSize = [_message sizeWithFont:[UIFont systemFontOfSize:MESSAGE_FONT_SIZE] constrainedToSize:CGSizeMake(_containerMaxWidth, 1000) lineBreakMode:NSLineBreakByWordWrapping];
            _labelSize = CGSizeMake(_containerMaxWidth, labelSize.height);
        }
    }
}

//计算容器的大小
- (void)calculateContainerBoundsWithLabelFrame
{
    CGSize containerSize = CGSizeMake(LABEL_PADDING * 2 + _labelSize.width, LABEL_PADDING * 2 + _labelSize.height);
    _containerFrame.size = containerSize;
}

- (void)showAtPosition:(HAToastPosition) position
{
    _position = position;
    float pointX = [UIScreen mainScreen].bounds.size.width / 2;
    float pointY;
    switch (_position) {
        case HAToastPositionDown:
            pointY = [UIScreen mainScreen].bounds.size.height * 0.8;
            break;
        case HAToastPositionCenter:
            pointY = [UIScreen mainScreen].bounds.size.height / 2;
            break;
        case HAToastPositionUp:
            pointY = [UIScreen mainScreen].bounds.size.height * 0.2;
            break;
        default:
            pointY = [UIScreen mainScreen].bounds.size.height * 0.8;
            break;
    }
    _containerView.center = CGPointMake(pointX, pointY);
}

- (void)showToAppWindow
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:_containerView];
    [self startHiddenToast];
}

- (void)startHiddenToast
{
    [self performSelector:@selector(hiddenToast) withObject:nil afterDelay:TOAST_HIDDEN_DELAY_SECONDS];
}

- (void)hiddenToast
{
    [UIView beginAnimations:@"hidden toast" context:nil];
    [UIView setAnimationDuration:0.5f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeToast)];
    _containerView.alpha = 0.0f;
    [UIView commitAnimations];
}

- (void)removeToast
{
    [_containerView removeFromSuperview];
}

#pragma mark -- public methods

+ (void)showToast:(NSString *) message
{
    [self showToast:message position:HAToastPositionDown];
}

+ (void)showToast:(NSString *) message center:(CGPoint) centerPoint
{
    HAToast *toast = [[HAToast alloc] initWithMessage:message];
    toast.containerView.center = centerPoint;
    [toast autorelease];
}

+ (void)showToast:(NSString *) message position:(HAToastPosition) position
{
    HAToast *toast = [[HAToast alloc] initWithMessage:message];
    [toast showAtPosition:position];
    [toast autorelease];
}

@end
