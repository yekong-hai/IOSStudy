//
//  HAGCDViewController.m
//  IOSStudy
//
//  Created by hai on 14-7-9.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAGCDViewController.h"

@interface HAGCDViewController ()

@property (nonatomic, retain) IBOutlet UILabel *messageLabel;

@end

@implementation HAGCDViewController

- (void)dealloc
{
    NSLog(@"label count :%d",[_messageLabel retainCount]);//2
    [_messageLabel release];
    NSLog(@"label count :%d",[_messageLabel retainCount]);//1
    [super dealloc];
    NSLog(@"label count :%d",[_messageLabel retainCount]);//1
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self studyGCD];
    
    NSLog(@"label count :%d",[_messageLabel retainCount]);//3
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    NSLog(@"label count :%d",[_messageLabel retainCount]);//没走
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)studyGCD
{
    //1.dispatch_get_global_queue 并行队列
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"并行队列，可以做后台任务");
        NSString *message = @"并行队列，可以做后台任务";
        _messageLabel.text = message;
        //这个队列也可以更改view上的视图
    });
    
    //2.dispatch_get_main_queue 主线程队列
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *message = @"主线程队列，main";
        _messageLabel.text = message;
        NSLog(@"主线程队列，main");
    });
    
    //延迟2秒执行
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //code to be executed on the main queue after delay
        NSLog(@"2秒后，执行这个延迟任务");
    });
    
    //自定义dispatch_queue_t
    //串行队列需要自己创建queue
    dispatch_queue_t url_queue = dispatch_queue_create("www.baidu.com", NULL);
    dispatch_async(url_queue, ^{
        NSLog(@"自定义queue 执行");
    });
    dispatch_release(url_queue);
    
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"并行队列结果1");
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"并行队列结果2");
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"并行队列结果3");
    });
    
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"并行队列汇总结果 ok");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL * url = [NSURL URLWithString:@"http://www.baidu.com"];
        NSError * error;
        NSString * data = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
        if (data != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"call back, the data is: %@", data);
            });
        } else {
            NSLog(@"error when download:%@", error);
        }
    });
}

@end
