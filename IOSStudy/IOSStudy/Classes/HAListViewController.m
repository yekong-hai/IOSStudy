//
//  HAListViewController.m
//  IOSStudy
//
//  Created by hai on 14-6-19.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAListViewController.h"
#import "HASourceListViewController.h"
#import "HANetViewController.h"
#import "HAHeaderScrollViewController.h"
#import "HAScrollViewController.h"
#import "HALayerViewController.h"
#import "HAShopCartViewController.h"
#import "HAToastViewController.h"
#import "HAHttpViewController.h"
#import "HAModelViewController.h"
#import "HALoadingViewController.h"
#import "HACoreDataViewController.h"
#import "HACGViewController.h"
#import "HACAViewController.h"
#import "HABlockViewController.h"
#import "HAGCDViewController.h"
#import "HACoreFundationViewController.h"
#import "HAKVOViewController.h"
#import "HACheckButtonViewController.h"
#import "HAVersionViewController.h"
#import "HAAutoLayoutViewController.h"
#import "HAPersistenceViewController.h"
#import "HAImageViewController.h"
#import "HANavViewController.h"
#import "HASingletonViewController.h"
#import "HACacheViewController.h"
#import "HANotificationViewController.h"
#import "HAOcScatterViewController.h"
#import "HACoreTextViewController.h"
#import "HARoundCellTableViewController.h"
#import "HAScreenShotViewController.h"
#import "HAPictureLoadViewController.h"
#import "HANativeAndJsViewController.h"
#import "HAPDFViewController.h"

@interface HAListViewController ()

@property (nonatomic, retain) NSArray *studyInfoArray;

@end

@implementation HAListViewController


- (void)dealloc
{
    [_studyInfoArray release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadArrayDatas
{
    HALog(@"加载数据--test log");
    _studyInfoArray = [[NSArray arrayWithObjects:
                        @"app原生控件体验",
                        @"自定义网络层",
                        @"HeaderImageScrollView",
                        @"HerizontalScrollView",
                        @"自定义cell",
                        @"购物车",
                        @"toast",
                        @"封装网络层",
                        @"model",
                        @"loadingview",
                        @"CoreData",
                        @"Core Graphics",
                        @"Core Animation",
                        @"Block",
                        @"GCD",
                        @"Core Fundation",
                        @"Log",
                        @"KVO",
                        @"CheckButton",
                        @"Version Check",
                        @"自适应布局",
                        @"数据持久化",
                        @"图片问题",
                        @"导航navBar显示",
                        @"单例模式",
                        @"缓存策略",
                        @"测试通知",
                        @"零散知识点",
                        @"Core Text",
                        @"RoundCornerCell",
                        @"截图",
                        @"图片加载",
                        @"native和js交互",
                        @"pdf加载显示转图片保存",
                        @"三层左右滑动视图",
                        @"下拉刷新",
                        @"统计扩展",
                        @"自定义segment",
                        @"自定义alertview消息提示",
                        @"json to object",
                        @"设计最顶层super controller", nil] retain];
    
    //·
    //检测版本更新
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"IOS学习";
    [self loadArrayDatas];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _studyInfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = _studyInfoArray[indexPath.row];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = _studyInfoArray[indexPath.row];
    UIViewController *targetViewController = nil;
    switch (indexPath.row) {
        case 0://app原生控件体验
        {
            targetViewController = [[HASourceListViewController alloc] initWithTitile:title];
        }
            break;
        case 1://网络层
        {
            targetViewController = [[HANetViewController alloc] initWithTitile:title];
        }
            break;
        case 2://HeaderImageScrollView
        {
            targetViewController = [[HAHeaderScrollViewController alloc] init];
        }
            break;
        case 3://HerizontalScrollView
        {
            targetViewController = [[HAScrollViewController alloc] initWithTitile:title];
        }
            break;
        case 4://自定义cell
        {
            targetViewController = [[HALayerViewController alloc] initWithStyle:UITableViewStylePlain];
        }
            break;
        case 5://购物车
        {
            targetViewController = [[HAShopCartViewController alloc] initWithStyle:UITableViewStylePlain];
        }
            break;
        case 6://toast
        {
            targetViewController = [[HAToastViewController alloc] init];
        }
            break;
        case 7://封装网络层
        {
            targetViewController = [[HAHttpViewController alloc] initWithTitile:title];
        }
            break;
        case 8://model
        {
            targetViewController = [[HAModelViewController alloc] initWithTitile:title];
        }
            break;
        case 9://loading view
        {
            targetViewController = [[HALoadingViewController alloc] initWithTitile:title];
        }
            break;
        case 10://coreData
        {
            targetViewController = [[HACoreDataViewController alloc] initWithTitile:title];
        }
            break;
        case 11://Core Graphics
        {
            targetViewController = [[HACGViewController alloc] initWithTitile:title];
        }
            break;
        case 12://core animation
        {
            targetViewController = [[HACAViewController alloc] initWithTitile:title];
        }
            break;
        case 13://block
        {
            targetViewController = [[HABlockViewController alloc] initWithTitile:title];
        }
            break;
        case 14://gcd
        {
            targetViewController = [[HAGCDViewController alloc] initWithTitile:title];
        }
            break;
        case 15://core fundation
        {
            targetViewController = [[HACoreFundationViewController alloc] initWithTitile:title];
        }
            break;
        case 17://kvo
        {
            targetViewController = [[HAKVOViewController alloc] initWithTitile:title];
        }
            break;
        case 18://check button
        {
            targetViewController = [[HACheckButtonViewController alloc] initWithTitile:title];
        }
            break;
        case 19://version check
        {
            targetViewController = [[HAVersionViewController alloc] initWithTitile:title];
        }
            break;
        case 20://自适应布局
        {
            targetViewController = [[HAAutoLayoutViewController alloc] initWithTitile:title];
        }
            break;
        case 21://持久化
        {
            targetViewController = [[HAPersistenceViewController alloc] initWithTitile:title];
        }
            break;
        case 22://图片问题
        {
            targetViewController = [[HAImageViewController alloc] initWithTitile:title];
        }
            break;
        case 23://导航navBar显示
        {
            targetViewController = [[HANavViewController alloc] initWithTitile:title];
        }
            break;
        case 24://单例模式
        {
            targetViewController = [[HASingletonViewController alloc] initWithTitile:title];
        }
            break;
        case 25://缓存策略
        {
            targetViewController = [[HACacheViewController alloc] initWithTitile:title];
        }
            break;
            case 26://测试通知
        {
            targetViewController = [[HANotificationViewController alloc] initWithTitile:title];
        }
            break;
            case 27://零散知识点
        {
            targetViewController = [[HAOcScatterViewController alloc] initWithTitile:title];
        }
            break;
            case 28://Core Text
        {
            targetViewController = [[HACoreTextViewController alloc] initWithTitile:title];
        }
            break;
            case 29://RoundCornerCell
        {
            targetViewController = [[HARoundCellTableViewController alloc] initWithTitile:title];
        }
            break;
            case 30://截图
        {
            targetViewController = [[HAScreenShotViewController alloc] initWithNibName:@"HAScreenShotViewController" bundle:nil];
        }
            break;
            case 31://图片加载
        {
            targetViewController = [[HAPictureLoadViewController alloc] initWithTitile:title];
        }
            break;
            case 32:// native和js交互
        {
            targetViewController = [[HANativeAndJsViewController alloc] initWithTitile:title];
        }
            break;
        case 33://pdf加载显示转图片保存
        {
            targetViewController = [[HAPDFViewController alloc] initWithTitile:title];
        }
            break;
        default:
        {
            targetViewController = nil;
        }
            break;
    }
    if (targetViewController) {
        [self.navigationController pushViewController:targetViewController animated:YES];
        [targetViewController release];
    }
}


@end
