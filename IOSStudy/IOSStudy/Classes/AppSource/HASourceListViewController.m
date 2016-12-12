//
//  HASourceListViewController.m
//  IOSStudy
//
//  Created by hai on 14-6-23.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HASourceListViewController.h"
#import "HALabelViewController.h"
#import "HATextFieldViewController.h"
#import "HAIndicatorViewController.h"
#import "HASwitchViewController.h"
#import "HASegmentControlViewController.h"
#import "HAButtonViewController.h"
#import "HAPageControlViewController.h"
#import "HAStepperViewController.h"
#import "HACellViewController.h"
#import "HAXibViewController.h"
#import "HAViewShowController.h"
#import "HAWebViewTestViewController.h"
#import "HAStudyViewViewController.h"

@interface HASourceListViewController ()

@property (nonatomic, retain) NSArray *sourceArray;

@end

@implementation HASourceListViewController

- (void)dealloc
{
    [_sourceArray release];
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


- (id)initWithTitile:(NSString *) title
{
    self = [super init];
    if (self) {
        self.title = title;
        [self setupSourceArray];
    }
    return self;
}

- (void)setupSourceArray
{
    _sourceArray = [[NSArray arrayWithObjects:
                     @"Label",
                     @"TextField",
                     @"Indicator",
                     @"Switch",
                     @"Segment Control",
                     @"Button",
                     @"Page Control",
                     @"Stepper",
                     @"TableViewCell",
                     @"XibView",
                     @"ViewShow",
                     @"WebViewTest",
                     @"UIViewTest",
                     nil] retain];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"34234234" delegate:self cancelButtonTitle:@"2" otherButtonTitles:@"1", nil];
    [alertView show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _sourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    NSString *title = _sourceArray[indexPath.row];
    cell.textLabel.text = title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = _sourceArray[indexPath.row];
    UIViewController *targetController;
    switch (indexPath.row) {
        case 0://label
        {
            HALabelViewController *labelController = [[HALabelViewController alloc] initWithTitile:title];
            targetController = [labelController retain];
            [labelController release];
        }
            break;
        case 1://textfield
        {
            HATextFieldViewController *textFieldController = [[HATextFieldViewController alloc] initWithTitile:title];
            targetController = [textFieldController retain];
            [textFieldController release];
        }
            break;
        case 2://indicator
        {
            HAIndicatorViewController *indicatorController = [[HAIndicatorViewController alloc] initWithTitile:title];
            targetController = [indicatorController retain];
            [indicatorController release];
        }
            break;
        case 3://switch
        {
            HASwitchViewController *switchController = [[HASwitchViewController alloc] initWithTitile:title];
            targetController = [switchController retain];
            [switchController release];
        }
            break;
        case 4://segment control
        {
            HASegmentControlViewController *segmentController = [[HASegmentControlViewController alloc] initWithTitile:title];
            targetController = [segmentController retain];
            [segmentController release];
        }
            break;
        case 5:
        {
            HAButtonViewController *buttonController = [[HAButtonViewController alloc] initWithTitile:title];
            targetController = [buttonController retain];
            [buttonController release];
        }
            break;
        case 6:
        {
            HAPageControlViewController *pageController = [[HAPageControlViewController alloc] initWithTitile:title];
            targetController = [pageController retain];
            [pageController release];
        }
            break;
        case 7:
        {
            HAStepperViewController *stepController = [[HAStepperViewController alloc] initWithTitile:title];
            targetController = [stepController retain];
            [stepController release];
        }
            break;
        case 8://TableViewCell
        {
            HACellViewController *cellController = [[HACellViewController alloc] initWithStyle:UITableViewStylePlain];
            targetController = [cellController retain];
            [cellController release];
        }
            break;
        case 9://xibview
        {
            HAXibViewController *xibController = [[HAXibViewController alloc] initWithTitile:title];
            targetController = [xibController retain];
            [xibController release];
        }
            break;
        case 10://view show
        {
            HAViewShowController *showController = [[HAViewShowController alloc] initWithTitile:title];
            targetController = [showController retain];
            [showController release];
        }
            break;
        case 11://WebViewTest
        {
            HAWebViewTestViewController *webViewController = [[HAWebViewTestViewController alloc] initWithTitile:title];
            targetController = [webViewController retain];
            [webViewController release];
        }
            break;
        case 12://UIViewTest
        {
            HAStudyViewViewController *viewViewController = [[HAStudyViewViewController alloc] initWithTitile:title];
            targetController = [viewViewController retain];
            [viewViewController release];
        }
            break;
        default:
        {
            targetController = nil;
        }
            break;
    }
    if (targetController == nil) {
        return;
    }
    [self.navigationController pushViewController:targetController animated:YES];
    [targetController release];
}

@end
