//
//  HABlockViewController.m
//  IOSStudy
//
//  Created by hai on 14-7-10.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HABlockViewController.h"

@interface HABlockViewController ()
{
    //block声明格式
    //返回值  (^ 变量名)(参数类型 参数名)
    int (^_onTapWindow)(int);
    
}

@end

@implementation HABlockViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self studyBlock];
    [self studyBlock2];
    [self testBlockAsParams];
    [self testBlockCallBack];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)studyBlock
{
    _onTapWindow = ^(int a){
        int b = 3;
        return a * b;
    };
    int num = _onTapWindow(1);
    NSLog(@"num:%d",num);
}

- (void)studyBlock2
{
    //block实现格式
    // ^(参数列表 参数名){函数实体}
    
    //有返回值类型
    int (^addCounts)(int,int) = ^(int a, int b){
        if (a > 0 && b > 0) {
            return a + b;
        }
        return 0;
    };
    int count;
    count = addCounts(3,5);
    NSLog(@" count : %d",count);
    count = addCounts(3,-5);
    NSLog(@" count : %d",count);
    
    //无返回值类型
    void (^showCount)(int a, int b) = ^(int a, int b){
        int count ;
        count = a + b;
        NSLog(@"counts:%d",count);
    };
    showCount(1,9);
    
    //增加__block修饰符的变量可再block内修改
    __block int sum = 0;
    NSLog(@"chage before sum= %d",sum);
    void (^changeSum)(int a) = ^(int a){
        sum = sum + a;
    };
    changeSum(5);
    NSLog(@"change after sum= %d",sum);
}

//block参数格式
//(int (^)(int a)) paramsName
//(返回值类型 (^)(形参参数列表 参数名)) 参数名

//block用作参数
- (void)blockWithValue:(int) value params:(int (^)(int params)) getResult
{
    int newValue;
    if (value > 10) {
        newValue = getResult(value);
    }else{
        newValue = getResult(10);
    }
    NSLog(@"回调之后的返回值是%d",newValue);
}

- (void)testBlockAsParams
{
    [self blockWithValue:4 params:^int(int params) {
        if (params == 10) {
            NSLog(@"block 测试，小于10的都变成10 了");
            return params;
        }else{
            NSLog(@"block 测试，大于10的还是原来的数字。");
            return params;
        }
    }];
}

- (void)blockAsCallBack:(void (^)(int responseCode)) response
{
    if (true) {
        response(200);
    }
}

- (void)testBlockCallBack
{
    [self blockAsCallBack:^(int responseCode) {
        if (responseCode == 200) {
            NSLog(@"result is ok。");
        }
    }];
}

@end
