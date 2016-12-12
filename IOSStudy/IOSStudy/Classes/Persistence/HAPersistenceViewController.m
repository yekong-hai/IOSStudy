//
//  HAPersistenceViewController.m
//  IOSStudy
//
//  Created by haiwang on 14-10-30.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAPersistenceViewController.h"
#import "HAArchiveTest.h"

@interface HAPersistenceViewController ()

@end

@implementation HAPersistenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self presistanceWithPlistFile];
    [self presistanceWithArchive];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//plist
//基本类型，简单类型
- (void)presistanceWithPlistFile
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    HALog(path);
    
    NSString *preStr = @"ios持久化，存储到任意文件中";
    NSString *strPath = [NSString stringWithFormat:@"%@/pre_string_file.a",path];
    [preStr writeToFile:strPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    NSString *readStr = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
    HALog(@"11111 string = %@",readStr);
    
    NSString *presString = @"ios的持久化存储方式，存储到plist中";
    NSString *stringPath = [NSString stringWithFormat:@"%@/pre_string.plist",path];
    [presString writeToFile:stringPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    NSString *readString = [NSString stringWithContentsOfFile:stringPath encoding:NSUTF8StringEncoding error:nil];
    HALog(@"string = %@",readString);
    
    NSArray *preArray = [NSArray arrayWithObject:presString];
    NSString *arrayPath = [NSString stringWithFormat:@"%@/pre_array.plist",path];
    [preArray writeToFile:arrayPath  atomically:YES];
    NSArray *readArray = [NSArray arrayWithContentsOfFile:arrayPath];
//    HALog([readArray description]);
    for (NSString *content in readArray) {
        HALog(@"array string = %@",content);
    }
    
    NSDictionary *preDictionary = [NSDictionary dictionaryWithObject:presString forKey:@"desc"];
    NSString *dictionaryPath = [NSString stringWithFormat:@"%@/pre_dictionary.plist",path];
    [preDictionary writeToFile:dictionaryPath  atomically:YES];
    NSDictionary *readDictionary = [NSDictionary dictionaryWithContentsOfFile:dictionaryPath];
//    HALog([readDictionary description]);
    NSString *dicContent = [readDictionary objectForKey:@"desc"];
    HALog(@"dictionary string = {desc = %@}",dicContent);
    
    NSString *dataString = @"ios持久化，针对NSData数据";
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *dataPath = [NSString stringWithFormat:@"%@/dataSource",path];
    [data writeToFile:dataPath atomically:YES];
    NSData *readData = [NSData dataWithContentsOfFile:dataPath];
    NSString *readDataStr = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
    HALog(@"data content = %@",readDataStr);

}

//归档
- (void)presistanceWithArchive
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    HALog(path);

    NSString *dataString = @"ios持久化，,使用归档方式";
    NSString *dataPath = [NSString stringWithFormat:@"%@/data.archive",path];
    HAArchiveTest *archive = [[HAArchiveTest alloc] init];
    archive.userName = @"海王";
    archive.userAge = 28;
    HAUserAge *userAge = [[HAUserAge alloc] init];
    userAge.age = @"28";
    userAge.ageTime = @"2014";
    archive.age = userAge;
    [userAge release];
    HAUserDesc *userDesc = [[HAUserDesc alloc] init];
    userDesc.userDesc = dataString;
    userDesc.descTime = @"2014-10-31";
    archive.userDesc = userDesc;
    [userDesc release];
    [NSKeyedArchiver archiveRootObject:archive toFile:dataPath];//[[NSKeyedArchiver alloc] initForWritingWithMutableData:mData];
    [archive release];
    
    HAArchiveTest *test = [NSKeyedUnarchiver unarchiveObjectWithFile:dataPath];
    HALog([test description]);
}

@end
