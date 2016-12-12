//
//  HASingletonViewController.m
//  IOSStudy
//
//  Created by haiwang on 14-12-2.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HASingletonViewController.h"
#import "HAManager.h"

#define LOOP_COUNT 30

@interface HASingletonViewController ()

@end

@implementation HASingletonViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self checkSingleton1];
    [self checkSingleton2];
    [self checkSingleton3];
}

- (void)createSingletonManagerWithSyn
{
    [HAManager defaultManager];
}

- (void)checkSingleton1
{
    for (int i =0; i< LOOP_COUNT; i++) {
        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(createSingletonManagerWithSyn) object:nil];
        thread.name = [NSString stringWithFormat:@"syn %d",i];
        [thread start];
    }
}

- (void)createSingletonManagerWithNoSyn
{
    [HAManager defaultManagerNoSyn];
}

- (void)checkSingleton2
{
    for (int i =0; i< LOOP_COUNT; i++) {
        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(createSingletonManagerWithNoSyn) object:nil];
        thread.name = [NSString stringWithFormat:@"nosyn %d",i];
        [thread start];
    }
}

- (void)createSingletonManagerWithOnce
{
    [HAManager shareManager];
}

- (void)checkSingleton3
{
    for (int i =0; i< LOOP_COUNT; i++) {
        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(createSingletonManagerWithOnce) object:nil];
        thread.name = [NSString stringWithFormat:@"once %d",i];
        [thread start];
    }
}

@end
