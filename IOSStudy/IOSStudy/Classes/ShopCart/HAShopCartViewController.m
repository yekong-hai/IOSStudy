//
//  HAShopCartViewController.m
//  IOSStudy
//
//  Created by hai on 14-7-2.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAShopCartViewController.h"
#import "HAVShopCart.h"
#import "HASKUProduct.h"
#import "HAVShopCartStore.h"
#import "HAShopCartItem.h"
#import "HAProductItemCell.h"

@interface HAShopCartViewController ()

@property (nonatomic, retain) HAVShopCart *shopCart;

@property (nonatomic, retain) NSArray *storeArray;

@end

@implementation HAShopCartViewController

#pragma mark -- init methods

- (void)dealloc
{
    [_shopCart release];
    [_storeArray release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"购物车";
        _shopCart = [[HAVShopCart defaultShopCart] retain];
        [self initProductList];
        _storeArray = [_shopCart.storeList retain];
    }
    return self;
}

- (void)initProductList
{
    [_shopCart clear];
    for (int i = 0; i < 3; i ++) {
        @autoreleasepool {
            HASKUProduct *skuProduct = [[HASKUProduct alloc] init];
            skuProduct.sku = @"100";
            skuProduct.color = @"红色";
            skuProduct.size = 45.0f;
            skuProduct.price = 123.0f;
            skuProduct.name = @"衬衫";
            skuProduct.storeId = @"111";
            skuProduct.storeName = @"凡客";
            skuProduct.storage = 1345;
            [_shopCart addProduct:skuProduct];
            [skuProduct release];
        }
    }
    for (int i = 0; i < 3; i ++) {
        HASKUProduct *skuProduct = [[HASKUProduct alloc] init];
        skuProduct.sku = @"101";
        skuProduct.color = @"蓝色";
        skuProduct.size = 45.0f;
        skuProduct.price = 123.0f;
        skuProduct.name = @"衬衫";
        skuProduct.storeId = @"111";
        skuProduct.storeName = @"凡客";
        skuProduct.storage = 1345;
        [_shopCart addProduct:skuProduct];
        [skuProduct release];
    }
    for (int i = 0; i < 3; i ++) {
        HASKUProduct *skuProduct = [[HASKUProduct alloc] init];
        skuProduct.sku = @"200";
        skuProduct.color = @"卡其色";
        skuProduct.size = 4.0f;
        skuProduct.price = 12.0f;
        skuProduct.name = @"袜子";
        skuProduct.storeId = @"222";
        skuProduct.storeName = @"衣舍";
        skuProduct.storage = 134;
        [_shopCart addProduct:skuProduct];
        [skuProduct release];
    }
    for (int i = 0; i < 1; i ++) {
        HASKUProduct *skuProduct = [[HASKUProduct alloc] init];
        skuProduct.sku = @"201";
        skuProduct.color = @"绿色";
        skuProduct.size = 41.0f;
        skuProduct.price = 1266.0f;
        skuProduct.name = @"大衣";
        skuProduct.storeId = @"222";
        skuProduct.storeName = @"衣舍";
        skuProduct.storage = 13;
        [_shopCart addProduct:skuProduct];
        [skuProduct release];
    }
}

#pragma mark -- lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _storeArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    view.backgroundColor = [UIColor orangeColor];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 21)];
    nameLabel.backgroundColor = [UIColor clearColor];
    HAVShopCartStore *store = _storeArray[section];
    nameLabel.text = store.storeName;
    [view addSubview:nameLabel];
    [nameLabel release];
    return [view autorelease];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    HAVShopCartStore *store = _storeArray[section];
    return store.productItemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HAProductItemCell";
    HAProductItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[HAProductItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    HAVShopCartStore *store = _storeArray[indexPath.section];
    HAShopCartItem *item = store.productItemArray[indexPath.row];
    [cell updateData:item];
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        HAVShopCartStore *store = _storeArray[indexPath.section];
        HAShopCartItem *item = store.productItemArray[indexPath.row];
        [store.productItemArray removeObject:item];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];

    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
 
 */

@end
