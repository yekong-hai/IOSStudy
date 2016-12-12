//
//  HARootHttpRequest.m
//  IOSStudy
//
//  Created by hai on 14-7-4.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HARootHttpRequest.h"
#import "ASIFormDataRequest.h"
#import "HAHttpRequestManager.h"
#import "Reachability.h"

@interface HARootHttpRequest ()<ASIHTTPRequestDelegate>
{
    ASIFormDataRequest *_request;
}


@end

@implementation HARootHttpRequest

#pragma mark -- init methods

- (void)dealloc
{
    NSLog(@"%@ dealloc.",self.class);
    [_request clearDelegatesAndCancel];
    [_request cancel];
    _request.delegate = nil;
    _request = nil;
    [_responseContent release];
    [_requestParams release];
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        [self handleRequest];
        [self configRequest];
    }
    return self;
}

- (id)initWithParams:(NSDictionary *)paramsDic
{
    self = [super init];
    if (self) {
        _requestParams = [paramsDic retain];
        [self handleRequest];
        [self configRequest];
    }
    return self;
}

#pragma mark -- private methods

- (void)handleRequest
{
    HAHttpRequestMethod method = [self getRequestMethod];
    switch (method) {
        case HAHttpRequestMethodGet:
            [self handleRequestForGetMethod];
            [_request setRequestMethod:@"GET"];
            break;
        case HAHttpRequestMethodPost:
            [self handleRequestForPostMethod];
            [_request setRequestMethod:@"POST"];
            break;
        default:
            break;
    }
}

- (void)handleRequestForGetMethod
{
    if (self.requestParams.count != 0) {
        NSMutableString *urlParams = [[[NSMutableString alloc] init] autorelease];
        [urlParams appendString:@"?"];
        for (NSString *key in self.requestParams) {
            NSString *value = [self.requestParams objectForKey:key];
            NSLog(@"key:%@,value:%@",key,value);
            [urlParams appendFormat:@"%@=%@&",key,value];
        }
        NSRange lastChar;
        lastChar.length = 1;
        lastChar.location = urlParams.length - 1;
        [urlParams deleteCharactersInRange:lastChar];
        self.requestUrl = [NSString stringWithFormat:@"%@%@",self.requestUrl,urlParams];
    }
    _request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:self.requestUrl]];
}

- (void)handleRequestForPostMethod
{
    _request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:self.requestUrl]];
    if (self.requestParams.count != 0) {
        for (NSString *key in self.requestParams) {
            NSString *value = [self.requestParams objectForKey:key];
            [_request addPostValue:value forKey:key];
        }
    }
}

- (void)configRequest
{
    _request.delegate = self;
    _request.timeOutSeconds = 5;
    _request.allowCompressedResponse = YES;
    _request.shouldCompressRequestBody = YES;
    //TODO:-hai-https证书设置
    [_request setValidatesSecureCertificate:NO];
}

#pragma mark -- public methods

- (void)request
{
    [_request startAsynchronous];
    [[HAHttpRequestManager shareManager] addHttpRequest:self];
}

- (BOOL)isSuccess
{
    if (_request.responseString) {
        return YES;
    }
    return NO;
}

- (void)cancelRequest
{
    [_request clearDelegatesAndCancel];
    [_request cancel];
    [[HAHttpRequestManager shareManager] removeHttpRequest:self];
}

- (void)cancelASIRequest
{
    [_request clearDelegatesAndCancel];
    [_request cancel];
}

- (void)requestOnStarted:(HARootHttpRequest *)request
{
    HALog(@"need subclass implement");
}

- (void)requestOnFinished:(HARootHttpRequest *)request
{
    HALog(@"need subclass implement");
}

- (void)requestOnFailed:(HARootHttpRequest *)request
{
    HALog(@"need subclass implement");
}

#pragma mark -- ASIHttpRequestDelegate

- (void)requestStarted:(ASIHTTPRequest *)request
{
    //检测网络状态
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    if (reachability.currentReachabilityStatus == NotReachable) {//如果网络不可用
        NSLog(@"当前网络不可用。");
        [self cancelRequest];
    }else if (reachability.currentReachabilityStatus == ReachableViaWiFi){
        NSLog(@"当前网络为WIFI环境。");
    }else if (reachability.currentReachabilityStatus == ReachableViaWWAN){
        NSLog(@"当前网络为WAN环境。");
    }
    NSLog(@"%@ started.------ %@",self.class,request.url.description);
    [self requestOnStarted:self];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"%@ finished.------ response:%@",self.class,request.responseString);
    self.responseContent = request.responseString;
    [self requestOnFinished:self];
    [[HAHttpRequestManager shareManager] removeHttpRequest:self];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"%@ failed.------ response:%@",self.class,request.responseString);
    self.responseContent = request.responseString;
    if (request.error.domain == NetworkRequestErrorDomain) {
		NSString *errorMsg = nil;
		switch ([request.error code]) {
			case ASIConnectionFailureErrorType:
				errorMsg = @"无法连接到网络";
				break;
			case ASIRequestTimedOutErrorType:
				errorMsg = @"访问超时";
				break;
			case ASIAuthenticationErrorType:
				errorMsg = @"服务器身份验证失败";
				break;
			case ASIRequestCancelledErrorType:
				//errorMsg = @"request is cancelled";
				errorMsg = @"服务器请求已取消";
				break;
			case ASIUnableToCreateRequestErrorType:
				//errorMsg = @"ASIUnableToCreateRequestErrorType";
				errorMsg = @"无法创建服务器请求";
				break;
			case ASIInternalErrorWhileBuildingRequestType:
				//errorMsg = @"ASIInternalErrorWhileBuildingRequestType";
				errorMsg = @"服务器请求创建异常";
				break;
			case ASIInternalErrorWhileApplyingCredentialsType:
				//errorMsg = @"ASIInternalErrorWhileApplyingCredentialsType";
				errorMsg = @"服务器请求异常";
				break;
			case ASIFileManagementError:
				//errorMsg = @"ASIFileManagementError";
				errorMsg = @"服务器请求异常";
				break;
			case ASIUnhandledExceptionError:
				//errorMsg = @"ASIUnhandledExceptionError";
				errorMsg = @"未知请求异常异常";
				break;
			default:
				errorMsg = @"服务器故障或网络链接失败！";
				break;
		}
        NSLog(@"%@ failed.------ reason:%@",self.class,errorMsg);
    }
    [self requestOnFailed:self];
    [[HAHttpRequestManager shareManager] removeHttpRequest:self];
}

@end
