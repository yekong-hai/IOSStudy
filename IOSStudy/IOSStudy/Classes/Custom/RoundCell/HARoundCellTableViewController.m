//
//  HARoundCellTableViewController.m
//  IOSStudy
//
//  Created by haiwang on 15-4-2.
//  Copyright (c) 2015年 hai. All rights reserved.
//

#import "HARoundCellTableViewController.h"
#import "HARoundCornerCell.h"

@interface HARoundCellTableViewController ()

@property (nonatomic, retain) NSArray *contentArray;

@end

@implementation HARoundCellTableViewController

- (void)dealloc
{
    [_contentArray release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.contentArray = [NSArray arrayWithObjects:[NSArray arrayWithObjects:@"圆角矩形cell", nil],[NSArray arrayWithObjects:@"123",@"圆角矩形cell", nil],[NSArray arrayWithObjects:@"123",@"圆角矩形cell",@"top圆角",@"再来一个试试", nil], nil];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return _contentArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSArray *contents = [_contentArray objectAtIndex:section];
    return contents.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"HARoundCornerCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (cell == nil) {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
//    }
//    NSArray *contents = [_contentArray objectAtIndex:indexPath.section];
//    NSString *content = [contents objectAtIndex:indexPath.row];
//    cell.textLabel.text = content;
    
    HARoundCornerCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[HARoundCornerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        cell.borderColor = [UIColor lightGrayColor];
        cell.roundBackgroundColor = [UIColor whiteColor];
        cell.padding = 10.0f;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    // Configure the cell...
    NSArray *contents = [_contentArray objectAtIndex:indexPath.section];
    NSString *content = [contents objectAtIndex:indexPath.row];
    cell.textLabel.text = content;
    
    [cell setCellStyleWithDataCounts:contents.count andIndex:indexPath.row];
//    if (contents.count == 1) {
//        [cell setSingleCellStyle];
//    }else{
//        if (indexPath.row == 0) {
//            [cell setTopCellStyle];
//        }else if (indexPath.row == contents.count - 1){
//            [cell setBottomCellStyle];
//        }else{
//            [cell setMiddleCellStyle];
//        }
//    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
