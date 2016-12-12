//
//  HACoreDataViewController.m
//  IOSStudy
//
//  Created by hai on 14-7-8.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HACoreDataViewController.h"
#import "HANews.h"
#import "HAEditor.h"
#import <CoreData/CoreData.h>

@interface HACoreDataViewController ()

//上下文对象
@property (nonatomic, retain) NSManagedObjectContext *context;

//实体描述对象
@property (nonatomic, retain) NSManagedObjectModel *objectModel;

//存储调度器
@property (nonatomic, retain) NSPersistentStoreCoordinator *storeCoordinator;

@end

@implementation HACoreDataViewController

- (void)dealloc
{
    [_context release];
    [_objectModel release];
    [_storeCoordinator release];
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
    [self initObjectModel];
    [self initStoreCoordinator];
    [self initContext];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initObjectModel
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"HANews" withExtension:@"momd"];
    _objectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
//    _objectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];
}

- (void)initStoreCoordinator
{
    _storeCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_objectModel];
    NSURL *storeUrl = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    storeUrl = [storeUrl URLByAppendingPathComponent:@"CoreData.sqlite"];
    NSError *error;
    [_storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error];
}

- (void)initContext
{
    _context = [[NSManagedObjectContext alloc] init];
    [_context setPersistentStoreCoordinator:_storeCoordinator];
}

#pragma mark -- IBAction methods

- (IBAction)onQueryBtnClicked:(id)sender
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"HANews"];
    [request setResultType:NSManagedObjectIDResultType];
    [request setFetchBatchSize:20];
    NSError *error;
    NSArray *result = [_context executeFetchRequest:request error:&error];
    for (NSManagedObjectID *objectId in result) {
        NSManagedObject *object = [_context objectWithID:objectId];
        if ([object isKindOfClass:[HANews class]]) {
            HANews *news = (HANews *)object;
            NSLog(@"news:%@",[news description]);
        }
    }
    [request release];
}

- (IBAction)onAddBtnClicked:(id)sender
{
    HANews *news = [NSEntityDescription insertNewObjectForEntityForName:@"HANews" inManagedObjectContext:_context];
    news.title = @"世界杯正在进行时";
    news.level = [NSNumber numberWithInt:1];
    news.content = @"2014年世界杯正在进行";
    NSError *error;
    BOOL isSave = [_context save:&error];
    if (isSave) {
        NSLog(@"保存成功");
    }else{
        NSLog(@"保存失败：%@",error);
    }
}

- (IBAction)onDeleteBtnClicked:(id)sender
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HANews" inManagedObjectContext:_context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"level = 1"];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setIncludesPropertyValues:NO];
    [request setEntity:entity];
    [request setPredicate:predicate];
//    [_context deleteObject:nil];直接删除已经索引出来的对象
    NSError *error;
    //更新，删除都是先查询出来所要修改的对象，然后再操作此对象
    NSArray *result = [_context executeFetchRequest:request error:&error];
    for (HANews *news in result) {
        [_context deleteObject:news];
    }
    if ([_context save:&error]) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败：%@",error);
    }
    [request release];
}

@end
