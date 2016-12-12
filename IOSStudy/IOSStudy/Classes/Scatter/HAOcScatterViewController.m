//
//  HAOcScatterViewController.m
//  IOSStudy
//
//  Created by haiwang on 14-12-4.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAOcScatterViewController.h"

#define OBJ_COUNT 10000

@interface HAOcScatterViewController ()

@end

@implementation HAOcScatterViewController

//空指针
- (void)scatterNil
{
    //nil,Nil,NULL
    //nil是一个对象指针为空，Nil是一个类指针为空，NULL是基本数据类型或c类型为空。
    NSString *a = nil;
    NSLog(@"%@",a);
    NSString *str = Nil;
    NSLog(@"%@",str);
    NSString *str2 = NULL;
    NSLog(@"%@",str2);
    int b = NULL;
    int *bb = NULL;
//    *bb = nil;//报错
//    *bb = Nil;//和上面一样报错
    Class class = Nil;
    class = nil;
    class = NULL;
    NSLog(@"%@",class);
    //[NSNull null]通常作为占位符作用,
    NSNull *null = nil;
    NSLog(@"%@",null);
    //遇到解析字符串"aaa":null，是会被解析成NSNull的
    NSArray *array = [NSArray arrayWithObjects:[NSNull null],@"123",[NSNull null],@"456", nil];
    for (NSString *content in array) {
        NSLog(@"%@",content);
    }
}

//自动释放池
- (void)scatterAutoReleasePool
{
    for (int i = 0; i < OBJ_COUNT; i++) {
        NSObject *obj = [[NSObject alloc] init];
    }
    
    for (int i = 0; i < OBJ_COUNT; i++) {
        NSObject *obj = [[NSObject alloc] init];
        [obj release];
    }

    for (int i = 0; i < OBJ_COUNT; i++) {
        NSObject *obj = [[[NSObject alloc] init] autorelease];
    }

    NSAutoreleasePool *pool1 = [[NSAutoreleasePool alloc] init];
    for (int i = 0; i < OBJ_COUNT; i++) {
        NSObject *obj = [[NSObject alloc] init];
        [obj release];
    }
    [pool1 drain];
    
    NSAutoreleasePool *pool2 = [[NSAutoreleasePool alloc] init];
    for (int i = 0; i < OBJ_COUNT; i++) {
        NSObject *obj = [[[NSObject alloc] init] autorelease];
    }
    [pool2 drain];
    
    
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSObject *aObj = [[[NSObject alloc] init] autorelease];
    NSObject *bObj = [[NSObject alloc] init];
    
    NSLog(@"%lo",[aObj retainCount]);
    NSLog(@"%lo",[bObj retainCount]);
    
    [bObj retain];
    NSLog(@"%lo",[aObj retainCount]);
    NSLog(@"%lo",[bObj retainCount]);
    
    [bObj release];
    
    [aObj retain];
    NSLog(@"%lo",[aObj retainCount]);
    NSLog(@"%lo",[bObj retainCount]);
    
    //数组，临时产生大量内存，放在新建的pool内，已达到最快速释放内存
    for (int i = 0; i < OBJ_COUNT; i ++) {
        NSObject *obj = [[[NSObject alloc] init] autorelease];
//        NSLog(@"%@",obj);
    }
    
    [pool drain];
    
    NSLog(@"%lo",[aObj retainCount]);//由于aObj被放在自动释放池中，所以在释放池销毁后，，此对象已经release，不能在使用该对象
    NSLog(@"%lo",[bObj retainCount]);
    
    [aObj release];
    [bObj release];
    
}

- (void)studyNSStringRC
{
    //下面这种方式stringWithFormat 是RC的
    NSMutableArray* ary = [[NSMutableArray array] retain];
    NSString *str = [NSString stringWithFormat:@"test"];
    NSLog(@"%@ refcount %lu",str,[str retainCount]);
    //count = 1
    [str retain];
    [ary addObject:str];
    NSLog(@"%@ refcount %lu",str,[str retainCount]);
    //count = 3
    [str retain];
    [str release];
    [str release];
    NSLog(@"%@ refcount %lu",str,[str retainCount]);
    //count = 2
    [ary removeAllObjects];
    NSLog(@"%@ refcount %lu",str,[str retainCount]);
    //count = 1
    
    //下面这种方式@"bStr"，引用计数是个巨大的数字，且保持不变 非RC的
    NSString *bStr = @"bStr";
    NSLog(@"%@ refcount %lu",bStr,[bStr retainCount]);
    //count = 18446744073709551615
    [bStr retain];
    NSLog(@"%@ refcount %lu",bStr,[bStr retainCount]);
    //count = 18446744073709551615
    [bStr release];
    NSLog(@"%@ refcount %lu",bStr,[bStr retainCount]);
    [bStr release];
    NSLog(@"%@ refcount %lu",bStr,[bStr retainCount]);
    //不支持RC 所以无限release也没问题
    
    
    NSString *cStr = [[NSString alloc] initWithFormat:@"test"];
    NSLog(@"%@ refcount %lu",cStr,[cStr retainCount]);
    //count = 1
    [cStr retain];
    [ary addObject:cStr];
    NSLog(@"%@ refcount %lu",cStr,[cStr retainCount]);
    //count = 3
    [cStr retain];
    [cStr release];
    [cStr release];
    NSLog(@"%@ refcount %lu",cStr,[cStr retainCount]);
    //count = 2
    [ary removeAllObjects];
    NSLog(@"%@ refcount %lu",cStr,[cStr retainCount]);
    //count = 1
}

- (void)loadView
{
    [super loadView];
    
    [self studyNSStringRC];
    
    [self scatterNil];
    
    [self scatterAutoReleasePool];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
