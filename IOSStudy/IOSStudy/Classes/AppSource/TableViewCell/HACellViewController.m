//
//  HACellViewController.m
//  IOSStudy
//
//  Created by hai on 14-6-25.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HACellViewController.h"
#import "HAUser.h"
#import "HAChangeHighCell.h"

@interface HACellViewController ()
{
    NSIndexPath *_selectIndexPath;
}
@property (nonatomic, retain) NSArray *dataArray;

@end

@implementation HACellViewController

- (void)dealloc
{
    [_dataArray release];
    [_selectIndexPath release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"TableViewCell";
        
        [self loadData];
    }
    return self;
}

- (void)loadData
{
    _dataArray = [[HAUser userList] retain];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- private methods

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectIndexPath && [_selectIndexPath compare:indexPath] == NSOrderedSame) {
        return [HAChangeHighCell heightWithCellSelect];
    }
//    HAChangeHighCell *cell = (HAChangeHighCell *)[tableView cellForRowAtIndexPath:indexPath];//此方法，每次都是tableview去计算这个位置的cell，而不是直接拿到此cell的对象引用,所以在tableview的datasource方法中调用就会造成循环调用
    return [HAChangeHighCell heightWithCellNormal];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HAChangeHighCell";
    HAChangeHighCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[HAChangeHighCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    HAUser *user = _dataArray[indexPath.row];
    [cell setData:user.name withDescription:user.info];
    if (_selectIndexPath && [_selectIndexPath compare:indexPath] == NSOrderedSame) {
        [cell show:YES];
    }else{
        [cell show:NO];
    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    _selectIndexPath = indexPath;
    
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
 


@end
