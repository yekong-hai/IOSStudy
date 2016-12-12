//
//  HANews.h
//  IOSStudy
//
//  Created by hai on 14-7-8.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface HANews : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSNumber * level;
@property (nonatomic, retain) NSString * title;

@end
