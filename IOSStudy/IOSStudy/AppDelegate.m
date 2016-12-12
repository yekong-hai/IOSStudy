//
//  AppDelegate.m
//  IOSStudy
//
//  Created by hai on 14-6-18.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "AppDelegate.h"
#import "HAListViewController.h"

@interface AppDelegate ()

@property (nonatomic, assign) UIBackgroundTaskIdentifier backTaskIdentifier;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    HAListViewController *haListController = [[HAListViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initCustomBarWithRootViewController:haListController];
    [haListController release];
    self.window.rootViewController = navController;
    [navController release];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    NSLog(@"app started.");
    NSLog(@"%@",NSStringFromCGSize([UIScreen mainScreen].bounds.size));
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
//    [self beginBackGroundTask];
    //加上需要后台长久运行的代码
//    for (int i = 0; i < 990000; i ++) {
//        NSLog(@"i = %d",i);
//    }
//    [self endBackGroundTask];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//开始后台任务运行
- (void)beginBackGroundTask
{
    self.backTaskIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [self endBackGroundTask];
    }];
}

//结束后台任务
- (void)endBackGroundTask
{
    [[UIApplication sharedApplication] endBackgroundTask:self.backTaskIdentifier];
    self.backTaskIdentifier = UIBackgroundTaskInvalid;
}

@end
