//
//  HANotificationViewController.m
//  IOSStudy
//
//  Created by haiwang on 14-12-3.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HANotificationViewController.h"
#import "HANotificationCenter.h"

#define TEST_NOTIFICATION @"TestNotification"

@interface HANotificationViewController ()
{
    int _times;
}
@property (nonatomic, retain) IBOutlet UILabel *showLabel;

@end

@implementation HANotificationViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[HANotificationCenter defaultCenter] removeObserver:self];
    [_showLabel release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getTestNotification:) name:TEST_NOTIFICATION object:nil];
    [[HANotificationCenter defaultCenter] addObserver:self selector:@selector(getTestNotification:) name:TEST_NOTIFICATION object:nil];
}

- (void)getTestNotification:(NSNotification *) notification
{
    NSLog(@"当前线程%@",[NSThread currentThread].name);
    _times++;
    _showLabel.text = [NSString stringWithFormat:@"测试通知 %d",_times];
    //如何UI更新不是在main线程发出的，则会更新延迟
    
}

- (IBAction)onTestBtnClicked:(id)sender
{
    //通知一般在发出通知的线程中转发
    dispatch_queue_t notifiQueue = dispatch_queue_create("notification", NULL);
    dispatch_async(notifiQueue, ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:TEST_NOTIFICATION object:nil];
    });
    dispatch_release(notifiQueue);
    //后台线程发出通知，则系统不能知道视图变化，不会立即刷新视图
}

- (IBAction)onTestBtn2Clicked:(id)sender
{
    //通知一般在发出通知的线程中转发
    [[NSNotificationCenter defaultCenter] postNotificationName:TEST_NOTIFICATION object:nil];
    //UI线程中发通知，则系统会知道视图有变化，会立即刷新视图
}

- (IBAction)onTestBtn3Clicked:(id)sender
{
    //使用新建线程，仍能够正常刷新UI
    NSThread *th = [[NSThread alloc] initWithTarget:self selector:@selector(postNotification) object:nil];
    th.name = @" th线程1";
    [th start];
}

- (IBAction)onHANotifiBtnClciked:(id)sender
{
    [[HANotificationCenter defaultCenter] postNotificationName:TEST_NOTIFICATION object:nil];
}

- (void)postNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:TEST_NOTIFICATION object:nil];
}



@end
