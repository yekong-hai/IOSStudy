//
//  HAArchiveTest.m
//  IOSStudy
//
//  Created by haiwang on 14-10-31.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAArchiveTest.h"

@implementation HAArchiveTest

- (void)dealloc
{
    [_userName release];
    [_age release];
    [super dealloc];
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_userName forKey:@"userName"];
    [aCoder encodeObject:_userDesc forKey:@"userDesc"];
    [aCoder encodeObject:[NSNumber numberWithInt:_userAge] forKey:@"userAge"];
    [aCoder encodeObject:_age forKey:@"age"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _userName = [[aDecoder decodeObjectForKey:@"userName"] copy];
        _userDesc = [[aDecoder decodeObjectForKey:@"userDesc"] retain];//需要NSCopying协议支持
        _userAge = [[aDecoder decodeObjectForKey:@"userAge"] intValue];
        _age = [[aDecoder decodeObjectForKey:@"age"] copy];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"{userName = %@,userAge = %d,userDesc = %@,age = %@}", _userName,_userAge,_userDesc,[_age description]];
}

@end

@implementation HAUserDesc

- (void)dealloc
{
    [_descTime release];
    [_userDesc release];
    [super dealloc];
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_userDesc forKey:@"userDesc"];
    [aCoder encodeObject:_descTime forKey:@"descTime"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _userDesc = [[aDecoder decodeObjectForKey:@"userDesc"] copy];
        _descTime = [[aDecoder decodeObjectForKey:@"descTime"] copy];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"{userDesc = %@,descTime = %@}", _userDesc,_descTime];
}

@end

@implementation HAUserAge

- (void)dealloc
{
    [_age release];
    [_ageTime release];
    [super dealloc];
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_age forKey:@"age"];
    [coder encodeObject:_ageTime forKey:@"ageTime"];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _age = [[coder decodeObjectForKey:@"age"] copy];
        _ageTime = [[coder decodeObjectForKey:@"ageTime"] copy];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    HAUserAge *userAge = [[HAUserAge alloc] init];
    userAge.age = self.age;
    userAge.ageTime = self.ageTime;
    return userAge;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"{age = %@,ageTime = %@}", _age,_ageTime];
}

@end