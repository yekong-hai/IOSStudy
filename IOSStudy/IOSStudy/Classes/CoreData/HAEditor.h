//
//  HAEditor.h
//  IOSStudy
//
//  Created by hai on 14-7-8.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface HAEditor : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * code;

@end
