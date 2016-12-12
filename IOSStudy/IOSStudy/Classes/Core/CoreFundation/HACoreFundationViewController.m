//
//  HACoreFundationViewController.m
//  IOSStudy
//
//  Created by haiwang on 14-7-15.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HACoreFundationViewController.h"
#import <CoreFoundation/CoreFoundation.h>
#import "HAObjectStudy.h"

@interface HACoreFundationViewController ()

@end

@implementation HACoreFundationViewController

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
    [self studyDate];
    [self study];
    [self studyNSObject];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- fundation objects

- (void)studyNSObject
{
    HAObjectStudy *objSt = nil;//[[HAObjectStudy alloc] init];
    objSt = [HAObjectStudy getInitializeInstance];
    objSt = [HAObjectStudy getInstance];
    [objSt studyObject];
    [objSt studyString];
//    [objSt release];
}

#pragma mark -- core fundation

- (void)studyDate
{
    //NSCalendar
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSLog(@"%@",[calendar description]);
    
//    NSDateComponents *dateC = [[NSDateComponents alloc] init];
    
    NSDate *date = [NSDate date];
    NSLog(@"date产生的时间为格林时间，8小时时差----%@",date);
    
    NSDateComponents *dateCom = [[NSDateComponents alloc] init];
    [dateCom setYear:2014];
    [dateCom setMonth:7];
    [dateCom setDay:16];
    [dateCom setHour:11];
    [dateCom setMinute:44];
    [dateCom setSecond:44];
    NSLog(@"%d年%d月%d日 %d时%d分%d秒",dateCom.year,dateCom.month,dateCom.day,dateCom.hour,dateCom.minute,dateCom.second);
    [dateCom release];
    
    NSDate *localDate = [NSDate localDate];
    NSLog(@"date产生的时间为北京时间，无时差----%@",localDate);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    dateFormatter.locale = [NSLocale currentLocale];
//    dateFormatter.dateStyle = NSDateFormatterFullStyle;
    dateFormatter.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    NSString *dateStr = [dateFormatter stringFromDate:date];
    NSLog(@"进行时间格式转化后的时间为中国时间--date:%@",dateStr);
    
//    dateFormatter.timeZone = [NSTimeZone localTimeZone];//美国时间
//    dateFormatter.timeZone = [NSTimeZone defaultTimeZone];//美国时间
//    dateFormatter.timeZone = [NSTimeZone systemTimeZone];//美国时间
//    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"GMT+0800"];//还是没用
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    date = [dateFormatter dateFromString:@"2014-07-16"];
    NSLog(@"new date:%@",date);//date类型全部是返回GMT时间
    [dateFormatter release];
    //系统时区
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSLog(@"time zone: %@",timeZone);
//    NSLog(@"system date:%@",timeZone.data);
//    NSString *timeZoneStr = [[NSString alloc] initWithData:timeZone.data encoding:NSUTF8StringEncoding];
//    NSLog(@"time zone: %@",timeZoneStr);
    
}

- (void)study
{
//    NSRunLoop
//    NSUserDefaults
//    NSTimer
    NSBundle *bundle = [NSBundle mainBundle];
    //指向app所在目录了
    NSLog(@"bundle path:%@",bundle.bundleURL.path);
    //搜索文件
    NSString *imagePath = [bundle pathForResource:@"btn_icon" ofType:@"png"];
    NSLog(@"image path %@",imagePath);
    
    NSData *data = [[NSData alloc] initWithContentsOfFile:imagePath];
    
    NSString *plist = [bundle pathForResource:@"aaaa" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:plist];
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:plist];
    
    //bundle负责加载xib文件
    NSArray *viewArray = [bundle loadNibNamed:@"HACoreFundationViewController" owner:self options:nil];
    //在一个xib文件中获取几个view
    UIView *view = viewArray[0];
    NSLog(@"view %@",view);
    
    //文件字节读取的类
//    NSFileHandle
//    文件操作类
//    NSFileManager
//    NSLock
//    NSOperation
//    NSBlockOperation
//    NSInvocationOperation
//    NSOperationQueue
//    NSThread
    
//    NSNotification
//    NSNotificationCenter
//    NSNotificationQueue
    
//    NSCoder
//    NSKeyedArchiver
    
//    NSAutoreleasePool
    
//    NSException
    
    
}

@end
