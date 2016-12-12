//
//  HANetViewController.m
//  IOSStudy
//
//  Created by hai on 14-6-20.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HANetViewController.h"
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "ASIFormDataRequest.h"

@interface HANetViewController ()<ASIHTTPRequestDelegate>
{
    IBOutlet UIImageView *imageView1;
    IBOutlet UIImageView *imageView2;
	IBOutlet UIImageView *imageView3;
	IBOutlet UIProgressView *progressIndicator;
	IBOutlet UISwitch *accurateProgress;
	IBOutlet UIProgressView *imageProgressIndicator1;
	IBOutlet UIProgressView *imageProgressIndicator2;
	IBOutlet UIProgressView *imageProgressIndicator3;
	IBOutlet UILabel *imageLabel1;
	IBOutlet UILabel *imageLabel2;
	IBOutlet UILabel *imageLabel3;
	BOOL failed;
}

@property (nonatomic, retain) IBOutlet UILabel *sysncResultLabel;

@property (nonatomic, retain) IBOutlet UILabel *aSysncResultLabel;

@property (nonatomic, retain) ASINetworkQueue *networkQueue;

@property (nonatomic, retain) IBOutlet UIProgressView *uploadProgressIndicator;

@property (nonatomic, retain) IBOutlet UILabel *uploadStateLabel;

@end

@implementation HANetViewController

- (void)dealloc
{
    [_sysncResultLabel release];
    [_aSysncResultLabel release];
    
	[progressIndicator release];
	[_networkQueue reset];
    [_networkQueue release];
    [_uploadProgressIndicator release];
    [_uploadStateLabel release];
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
    
    self.sysncResultLabel.numberOfLines = 0;
    self.sysncResultLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    self.aSysncResultLabel.numberOfLines = 0;
    self.aSysncResultLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    [self resetIndicator];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)resetIndicator
{
    [imageProgressIndicator1 setProgress:0.0f animated:NO];
    [imageProgressIndicator2 setProgress:0.0f animated:NO];
    [imageProgressIndicator3 setProgress:0.0f animated:NO];
    [progressIndicator setProgress:0.0f animated:NO];
    
    [_uploadProgressIndicator setProgress:0.0f animated:NO];
}

#pragma mark -- asi

// 简单的同步请求示例---同步请求不能取消
- (IBAction)onSysncRequestBtnClicked:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://www.weather.com.cn/data/sk/101010100.html"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        NSLog(@"Response :%@", response);
        self.sysncResultLabel.text = response;
    } else {
        self.sysncResultLabel.text = @"error";
    }
}

//异步请求----可以取消
-(IBAction)onAsysncRequestBtnClicked:(id)sender
{
    //是否有网络请求
    [ASIHTTPRequest isNetworkInUse];
    
    //是否显示网络请求在status bar上
    [ASIHTTPRequest setShouldUpdateNetworkActivityIndicator:YES];
    
    NSURL *url = [NSURL URLWithString:@"http://www.weather.com.cn/data/sk/101010100.html"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    
    //设置请求超时时候重试的次数
    [request setNumberOfTimesToRetryOnTimeout:2];
    
    request.delegate = self;
    [request startAsynchronous];
}

//队列请求
- (IBAction)fetchThreeImages:(id)sender
{
	[imageView1 setImage:nil];
	[imageView2 setImage:nil];
	[imageView3 setImage:nil];
    [self resetIndicator];
	if (!_networkQueue) {
		_networkQueue = [[ASINetworkQueue alloc] init];
	}
	failed = NO;
	[_networkQueue reset];
	[_networkQueue setDownloadProgressDelegate:progressIndicator];
    //1.queue可以给所有asirequest设置delegate方法
	[_networkQueue setRequestDidFinishSelector:@selector(imageFetchComplete:)];
	[_networkQueue setRequestDidFailSelector:@selector(imageFetchFailed:)];
	[_networkQueue setShowAccurateProgress:[accurateProgress isOn]];
	[_networkQueue setDelegate:self];
	
	ASIHTTPRequest *request;
	request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"http://allseeing-i.com/ASIHTTPRequest/tests/images/small-image.jpg"]];
	[request setDownloadDestinationPath:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"1.png"]];
	[request setDownloadProgressDelegate:imageProgressIndicator1];
    [request setUserInfo:[NSDictionary dictionaryWithObject:@"request1" forKey:@"name"]];
    //2.也可以每个request设置自己的delegate方法
//    [request setDelegate:self];
//    [request setDidFinishSelector:@selector(imageFetchComplete:)];
//    [request setDidFailSelector:@selector(imageFetchFailed:)];
	[_networkQueue addOperation:request];
	
	request = [[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:@"http://allseeing-i.com/ASIHTTPRequest/tests/images/medium-image.jpg"]] autorelease];
	[request setDownloadDestinationPath:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"2.png"]];
	[request setDownloadProgressDelegate:imageProgressIndicator2];
    [request setUserInfo:[NSDictionary dictionaryWithObject:@"request2" forKey:@"name"]];
    //大文件断点续传---允许文件下载重新启动resume
    [request setAllowResumeForFileDownloads:YES];
	[_networkQueue addOperation:request];
	
	request = [[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:@"http://allseeing-i.com/ASIHTTPRequest/tests/images/large-image.jpg"]] autorelease];
	[request setDownloadDestinationPath:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"3.png"]];
	[request setDownloadProgressDelegate:imageProgressIndicator3];
    [request setUserInfo:[NSDictionary dictionaryWithObject:@"request3" forKey:@"name"]];
	[_networkQueue addOperation:request];
	
    //设置队列中一个请求失败的时候是否取消掉所有未完成的请求
    [_networkQueue setShouldCancelAllRequestsOnFailure:NO];
    
	[_networkQueue go];
    
    //主动取消所有请求
//    [_networkQueue cancelAllOperations];
}


- (void)imageFetchComplete:(ASIHTTPRequest *)request
{
    NSLog(@"request userinfo -> name :%@",[request.userInfo objectForKey:@"name"]);
	UIImage *img = [UIImage imageWithContentsOfFile:[request downloadDestinationPath]];
	if (img) {
		if ([imageView1 image]) {
			if ([imageView2 image]) {
				[imageView3 setImage:img];
			} else {
				[imageView2 setImage:img];
			}
		} else {
			[imageView1 setImage:img];
		}
	}
}

- (void)imageFetchFailed:(ASIHTTPRequest *)request
{
	if (!failed) {
		if ([[request error] domain] != NetworkRequestErrorDomain || [[request error] code] != ASIRequestCancelledErrorType) {
			UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Download failed" message:@"Failed to download images" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
			[alertView show];
		}
		failed = YES;
	}
}

//上传数据
- (IBAction)onUploadDataBtnClicked:(id)sender
{
    [self uploadData];
}

- (void)uploadData1
{
    //ASIFormDataRequest ，模拟 Form表单提交，其提交格式与 Header会自动识别。
    //没有文件：application/x-www-form-urlencoded
    //有文件：multipart/form-data
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"Ben" forKey:@"first_name"];
    [request setPostValue:@"Copsey" forKey:@"last_name"];
    [request setFile:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"2.png"] forKey:@"photo"];
    //    [request addData:[NSData dataWithContentsOfFile:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"2.png"]] withFileName:@"2.png" andContentType:@"image/png"forKey:@"photos"];
    
    //获取上传进度
    //    [request setUploadProgressDelegate:progressIndicator];
    [request setRequestMethod:@"PUT"];
    request.timeOutSeconds = 5;
    request.delegate = self;
    [request startAsynchronous];

}

- (void)uploadData
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://allseeing-i.com/ignore"]];
	[request setPostValue:@"test" forKey:@"value1"];
	[request setPostValue:@"test" forKey:@"value2"];
	[request setPostValue:@"test" forKey:@"value3"];
	[request setTimeOutSeconds:20];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
	[request setShouldContinueWhenAppEntersBackground:YES];
#endif
	[request setUploadProgressDelegate:_uploadProgressIndicator];
	[request setDelegate:self];
	[request setDidFailSelector:@selector(uploadFailed:)];
	[request setDidFinishSelector:@selector(uploadFinished:)];
	
	//Create a 256KB file
	NSData *data = [[[NSMutableData alloc] initWithLength:256*1024] autorelease];
	NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"file"];
	[data writeToFile:path atomically:NO];
	
	//Add the file 8 times to the request, for a total request size around 2MB
	int i;
	for (i=0; i<8; i++) {
		[request setFile:path forKey:[NSString stringWithFormat:@"file-%i",i]];
	}
	
	[request startAsynchronous];
}


- (void)uploadFailed:(ASIHTTPRequest *)theRequest
{
	[_uploadStateLabel setText:[NSString stringWithFormat:@"Request failed:\r\n%@",[[theRequest error] localizedDescription]]];
}

- (void)uploadFinished:(ASIHTTPRequest *)theRequest
{
	[_uploadStateLabel setText:[NSString stringWithFormat:@"Finished uploading %llu bytes of data",[theRequest postLength]]];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
    // Clear out the old notification before scheduling a new one.
    if ([[[UIApplication sharedApplication] scheduledLocalNotifications] count] > 0)
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    // Create a new notification
    UILocalNotification *notification = [[[UILocalNotification alloc] init] autorelease];
    if (notification) {
		[notification setFireDate:[NSDate date]];
		[notification setTimeZone:[NSTimeZone defaultTimeZone]];
		[notification setRepeatInterval:0];
		[notification setSoundName:@"alarmsound.caf"];
		[notification setAlertBody:@"Boom!\r\n\r\nUpload is finished!"];
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
#endif
}

#pragma mark -- asirequestdelegate

//请求开始
- (void)requestStarted:(ASIHTTPRequest *)request
{
    NSLog(@"aSysnc request start");
}

//请求完成--成功
- (void)requestFinished:(ASIHTTPRequest *)request
{
    //main线程
    NSLog(@"aSysnc request finish: %@",[request responseString]);
    self.aSysncResultLabel.text = [request responseString];
}

//请求完成--失败
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"aSysnc request failed: %@",[[request error] description]);
    self.aSysncResultLabel.text = [request responseString];
}

//下载中的数据---如果加上这个代理则会使finished回调方法没有数据
- (void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data
{
    //子线程--非main线程
    NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"aSysnc request running : %@",response);
    [self performSelectorOnMainThread:@selector(showASyncResult:) withObject:response waitUntilDone:NO];
    [response release];
}

- (void)showASyncResult:(NSString *)response
{
    self.aSysncResultLabel.text = response;
}

@end
