//
//  HAVersionViewController.m
//  IOSStudy
//
//  Created by haiwang on 14-9-18.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAVersionViewController.h"
#import "HAAppstoreVersionRequest.h"
#import "HAAppstoreVersionRequestParams.h"
#import "HAAppstoreVersionResult.h"
#import "HAAPPUser.h"

//#define VANCL_ITUNES_APP_ID @"901397384" //测试
//#define VANCL_ITUNES_APP_ID @"350962117" //新浪微博appid--测试
#define VANCL_ITUNES_APP_ID @"412580729" //凡客客户端appid


@interface HAVersionViewController ()



@end

@implementation HAVersionViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- action methods

- (IBAction)onAppstoreCheckBtnClicked:(id)sender
{
    HAAppstoreVersionRequestParams *params = [[[HAAppstoreVersionRequestParams alloc] init] autorelease];
    params.appId = @"442666468";
    [HAAppstoreVersionRequest requestInstanceWithParams:[params dictionaryWithParams] onRequestStarted:^(HAAppstoreSuperHttpRequest *request) {
        
    } onRequestFinished:^(HAAppstoreSuperHttpRequest *request) {
//        HAAPPUser *user = [[HAAPPUser alloc] init];
//        [user parserWithResult:request.responseContent];
//        [user isParse];
        HAAppstoreVersionResult *versionResult = [[HAAppstoreVersionResult alloc] init];
        [versionResult parserWithResult:request.responseContent];
        if ([versionResult isParse]) {
            HALog(versionResult.description);
            HASoftwareInfo *softwareInfo = versionResult.results[0];
            HALog(@"应用名称：%@.\n应用地址：%@",softwareInfo.trackName,softwareInfo.trackViewUrl);
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:softwareInfo.trackViewUrl]];
        }else{
            HALog(@"解析失败");
        }
        [versionResult release];
    } onRequestFailed:^(HAAppstoreSuperHttpRequest *request) {
        HALog(@"请求失败");
    }];
}

-(IBAction)onServiceCheckBtnClicked:(id)sender
{
    //向自己的服务器发送版本检测请求和上面类似，都是请求的来数据，然后比较软件和新的版本信息，然后提示升级。
}

- (IBAction)onGotoAppstoreAndEvaluateApp:(id)sender
{
    NSString *rateUrlString=[NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",VANCL_ITUNES_APP_ID];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:rateUrlString]];

}

@end
