//
//  HAHttpViewController.m
//  IOSStudy
//
//  Created by hai on 14-7-7.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAHttpViewController.h"
#import "HALoginRequest.h"
#import "HAUserLoginRequestParams.h"
#import "HAUserModel.h"
#import "HASuperDataModel.h"
#import "HACMDDictionaryResult.h"

@interface HAHttpViewController ()

@property (nonatomic, retain) IBOutlet UITextView *resultTextView;

@property (nonatomic, retain) HALoginRequest *loginRequest;

@end

@implementation HAHttpViewController

- (void)dealloc
{
    [_loginRequest cancelRequest];
    [_loginRequest release];
    [_resultTextView release];
    [super dealloc];
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginRequest:(HAUserLoginRequestParams *)params {
    [HALoginRequest requestWithParams:[params dictionaryWithParams] onRequestStarted:^(HASuperHttpRequest *request) {
        
    } onRequestFinished:^(HASuperHttpRequest *request, HASuperHttpResult *result) {
        HACMDDictionaryResult *cmdResult = (HACMDDictionaryResult *)result;
        if ([cmdResult isSuccess]) {
            HAUserModel *userModel = [[[HAUserModel alloc] init] autorelease];
            [userModel parseWithDic:[cmdResult dictionaryData]];
            _resultTextView.text = [NSString stringWithFormat:@"结果：%@",[userModel description]];
        }else{
            _resultTextView.text = cmdResult.message;
        }
        
    } onRequestFailed:^(HASuperHttpRequest *request, HASuperHttpResult *result) {
        HACodeMsgDataResult *cmdResult = (HACodeMsgDataResult *)result;
        _resultTextView.text = cmdResult.message;
        
    }];
}

- (IBAction)onRequestBtnClicked:(id)sender {
    HAUserLoginRequestParams *params = [[[HAUserLoginRequestParams alloc] init] autorelease];
    params.userId = @"111";
    params.password = @"111aaa";
    [self loginRequest:params];
//    self.loginRequest = (HALoginRequest *)[HALoginRequest requestInstanceWithParams:[params dictionaryWithParams] onRequestStarted:^(HASuperHttpRequest *request) {
//        
//    } onRequestFinished:^(HASuperHttpRequest *request, HASuperHttpResult *result) {
//        HACMDDictionaryResult *cmdResult = (HACMDDictionaryResult *)result;
//        if ([cmdResult isSuccess]) {
//            HAUserModel *userModel = [[[HAUserModel alloc] init] autorelease];
//            [userModel parseWithDic:[cmdResult dictionaryData]];
//            _resultTextView.text = [NSString stringWithFormat:@"结果：%@",[userModel description]];
//        }else{
//            _resultTextView.text = cmdResult.message;
//        }
//        
//    } onRequestFailed:^(HASuperHttpRequest *request, HASuperHttpResult *result) {
//        HACodeMsgDataResult *cmdResult = (HACodeMsgDataResult *)result;
//        _resultTextView.text = cmdResult.message;
//    }];
}

@end
