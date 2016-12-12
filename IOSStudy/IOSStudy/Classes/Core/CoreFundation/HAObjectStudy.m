//
//  HAObjectStudy.m
//  IOSStudy
//
//  Created by haiwang on 15-1-14.
//  Copyright (c) 2015年 hai. All rights reserved.
//

#import "HAObjectStudy.h"
#import "CoreFoundationStudyHeader.h"

@implementation HAObjectStudy

- (void)studyObject
{
    [self studyObject1];
}

- (BOOL)isEqual:(id)object
{
    if (object == nil) {
        return NO;
    }else{
        if (self == object) {
            return YES;
        }else{
            if ([object isKindOfClass:[self class]]) {
                //比较2个对象的属性
            }else{
                return NO;
            }
        }
    }
    return NO;
}

- (void)studyObject1
{
    NSObject *a = nil;
    //object 运行时
    //NSMethodSignature
    //NSInvocation
    //子类和父类的关系，父类还能知道子类，一般是不能的啊
    
//    - (BOOL)isEqual:(id)object;
    NSLog(@"%lo",a.hash);
    
    id b;
    b = a;
    a = b;
    
    //对象为nil，发消息没事
    [a doSomething];
    [b doSome];
    [b respondsToSelector:@selector(aaa)];
    
    //对象release则发消息错误
    a = [NSObject new];
    [a release];
//    [a diSome];//[NSObject diSome]: message sent to deallocated instance 0x7fc102cc3860
    
    NSObject *aa = [NSObject new];
    NSObject *bb = [NSObject new];
    NSLog(@"%lo,%lo",aa.hash,bb.hash);
    aa = bb;
    NSLog(@"%lo,%lo",aa.hash,bb.hash);
    
    [self testPerformSelector];
    
    BOOL isA = [self isKindOfClass:[HAObjectStudy class]];
    BOOL isB = [self isMemberOfClass:[HAObjectStudy class]];
    BOOL isC = [self isMemberOfClass:[NSObject class]];
    BOOL isD = [self isKindOfClass:[NSObject class]];
    NSLog(@"%d,%d,%d,%d---kind一种，member成员一类，member的作用比kind小",isA,isB,isC,isD);
    
    BOOL isE = [self conformsToProtocol:@protocol(NSObject)];
    NSLog(@"是否遵循NSObject协议=== %d",isE);
    BOOL isF = [HAObjectStudy isSubclassOfClass:[NSObject class]];
    NSLog(@"HAObjectStudy 是否是 NSObject的子类 -- %d",isF);
    
    //函数指针
    IMP imp = [self methodForSelector:@selector(testPerformSelector)];
    imp(self,@selector(testPerformSelector));
    
    IMP imp2 = [self methodForSelector:@selector(testPerformWithParam:)];
    imp2(self,@selector(testPerformWithParam:),@"函数指针测试");
    //主动注销一个方法，并引起崩溃异常
//    [self doesNotRecognizeSelector:@selector(testPerformSelector)];
    
    
    NSLog(@"desription %@",self.description);
    NSLog(@"debugDesription %@",self.debugDescription);
    
    [HAObjectStudy load];
    HAObjectStudy *aStu = [[HAObjectStudy alloc] init];
    [aStu release];
    HAObjectStudy *bStu = [HAObjectStudy new];
    [bStu release];
    
    HAObjectStudy *defaultStudy2 = [HAObjectStudy getInitializeInstance];
    HAObjectStudy *defaultStudy = [HAObjectStudy getInstance];
    NSLog(@"%@,%@",defaultStudy2,defaultStudy);
}

- (void)testPerformSelector
{
    [self testPerformWithParam:@"123123"];
    [self testPerformWithParam:@"123" andParam:@"456"];
    
    [self performSelector:@selector(testPerformWithParam:) withObject:@"gsdfgdfg"];
    [self performSelector:@selector(testPerformWithParam:andParam:) withObject:@"345sdf" withObject:@"123123123"];
    
}

- (void)testPerformWithParam:(NSString *) param1
{
    DLogCMD
    NSLog(@"%@",param1);
}

- (void)testPerformWithParam:(NSString *) param1 andParam:(NSString *) param2
{
    DLogCMD
    NSLog(@"%@-----%@",param1,param2);
}

//静态方法
+ (void)load
{
    [super load];
    NSLog(@"load -- 当这个类在文件状态下被加载的时候调用(类的过程--加载-连接-初始化)");
}

+ (void)initialize
{
    [super initialize];
    NSLog(@"initialize --- 初始化，类在创建的时候进行初始化要进行的操作");
    if (defaultStudy == nil) {
        defaultStudy = [HAObjectStudy new];
        NSLog(@"defaultStudy 被initialize创建");
    }
}

static HAObjectStudy *defaultStudy = nil;

+(HAObjectStudy *)getInstance
{
    @synchronized(self){
        if(defaultStudy == nil){
            defaultStudy = [HAObjectStudy new];
            NSLog(@"defaultStudy 被getInstance创建");
        }
        return defaultStudy;
    }
}

+(HAObjectStudy *)getInitializeInstance
{
    return defaultStudy;
}

//这下2个需要
+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [[self getInitializeInstance] retain];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return self;
}

- (void)dealloc
{
    NSLog(@"进行释放操作");
    [super dealloc];
}

- (void)finalize
{
    DLogCMD
    [super finalize];
}


#pragma mark -- NSString

- (void)studyString
{
    Byte byte[] = {'a','b','c','d','e'};
    NSString *a = [[NSString alloc] initWithBytes:byte length:3 encoding:NSUTF8StringEncoding];
    NSLog(@"----string:%@",a);
    [a release];
    
    unichar bb = 'a';
    NSString *b = [[NSString alloc] initWithCharacters:&bb length:1];
    NSLog(@"---ssss:%@",b);
    [b release];
    
//    unichar[6] c = ['a','d','d','s','t','y'];
//    NSString *d = [[NSString alloc] initWithCharacters:&c length:1];
//    NSLog(@"---ssss:%@",b);
//    [b release];
 
    char *ee = "23r8gdos8";
    NSString *e = [[NSString alloc] initWithCString:ee encoding:NSUTF8StringEncoding];
    NSLog(@"e:%@",e);
    [e release];
    
    NSString *f = [[NSString alloc] initWithFormat:@"format string :%@",@"asdfasdfsdf"];
    NSLog(@"f:%@",f);
    [f release];
    
    NSString *h = [[NSString alloc] initWithData:[NSData dataWithBytes:byte length:3] encoding:NSUTF8StringEncoding];
    NSLog(@"h:%@",h);
    [h release];
    
    NSString *asd = [NSString stringWithFormat:@"123123123%@",@"asfsdfsdf"];
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    path = [NSString stringWithFormat:@"%@/pp.txt",path];
    [asd writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];

    asd = nil;
    asd = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"asd:%@",asd);
    
    NSString *dd = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://www.baidu.com"] encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"dd:%@",dd);
    [dd release];
    
    [asd stringByAppendingString:@"姐姐的"];
    NSLog(@"asd:%@",asd);
    
    NSString *aaa = @"1234";
    NSString *bbb = @"1234";
    NSLog(@"a的地址:%@,b的地址:%@,  地址不一样",aaa,bbb);
}

@end
