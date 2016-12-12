//
//  HACoreTextView.m
//  IOSStudy
//
//  Created by haiwang on 14-12-26.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HACoreTextView.h"
#import <CoreText/CoreText.h>



@implementation HACoreTextView

- (instancetype)init
{
    self = [super init];
    if (self) {
        UITextView *a;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)coreTextMubColorInRect:(CGRect) rect
{
    NSString *content = @"经济技术开发区工业区东区经海一路科创三街三号院,凡客诚品技术测试,请忽略次订单";
    CTFontRef sysUIFont = CTFontCreateUIFontForLanguage(kCTFontUIFontSystem, 14.0f, (CFStringRef)content);
    CGColorRef frontColor = [UIColor blackColor].CGColor;
    NSDictionary *frontAttDic = [NSDictionary dictionaryWithObjectsAndKeys:(id)sysUIFont,(id)kCTFontAttributeName,(id)frontColor,(id)kCTForegroundColorAttributeName, nil];
    
    CGColorRef behindColor = [UIColor redColor].CGColor;
    NSDictionary *behindAttDic = [NSDictionary dictionaryWithObjectsAndKeys:(id)sysUIFont,(id)kCTFontAttributeName,(id)behindColor,(id)kCTForegroundColorAttributeName, nil];
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:content];
    [attString beginEditing];
//    attString addAttribute:<#(NSString *)#> value:<#(id)#> range:<#(NSRange)#>
    [attString addAttributes:frontAttDic range:NSMakeRange(0, 10)];
    [attString addAttributes:behindAttDic range:NSMakeRange(10, 20)];
    [attString endEditing];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //1.直接打印--字体倒置
//    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)attString);
//    CTLineDraw(line, context);
//    CFRelease(line);
    
    //2.根本不显示
//    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
//    [attString drawInRect:rect];
//    [content drawInRect:rect withFont:[UIFont systemFontOfSize:14.0f]];

    //3.只显示1行，而且不能显示全
    //旋转
//    CGContextScaleCTM(context, 1.0, -1.0);
//    //平移
//    CGContextTranslateCTM(context, 10.0, -self.bounds.size.height + 10.0);
//
//    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)attString);
//    CTLineDraw(line, context);
//    CFRelease(line);
    
    //4
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(10, 0, self.bounds.size.width - 10, self.bounds.size.height - 10));
    //CFRangeMake(0, 0) 设置需要输出得字符，如果定义区间则显示区间内的字符，如果0，0不定义则全部显示
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    //压栈，压入图形状态栈中.每个图形上下文维护一个图形状态栈，并不是所有的当前绘画环境的图形状态的元素都被保存。图形状态中不考虑当前路径，所以不保存
    //保存现在得上下文图形状态。不管后续对context上绘制什么都不会影响真正得屏幕。
    CGContextSaveGState(context);
    //x，y轴方向移动
    CGContextTranslateCTM(context , 0 ,self.bounds.size.height);
    //缩放x，y轴方向缩放，－1.0为反向1.0倍,坐标系转换,沿x轴翻转180度
    CGContextScaleCTM(context, 1.0 ,-1.0);
    CTFrameDraw(frame, context);
    
    CGPathRelease(path);
    CFRelease(framesetter);
    
    CFRelease(sysUIFont);
    [attString release];
}

- (void)coretext1
{
    // create a font, quasi systemFontWithSize:24.0
    CTFontRef sysUIFont = CTFontCreateUIFontForLanguage(kCTFontSystemFontType,
                                                        24.0, NULL);
    // create a naked string
    NSString *string = @"Some Text";
    // blue
    CGColorRef color = [UIColor blueColor].CGColor;
    // single underline
    NSNumber *underline = [NSNumber numberWithInt:kCTUnderlineStyleSingle];
    // pack it into attributes dictionary
    NSDictionary *attributesDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                    (id)sysUIFont, (id)kCTFontAttributeName,
                                    color, (id)kCTForegroundColorAttributeName,
                                    underline, (id)kCTUnderlineStyleAttributeName, nil];
    // make the attributed string
    NSAttributedString *stringToDraw = [[NSAttributedString alloc] initWithString:string
                                                                       attributes:attributesDict];
    // now for the actual drawing
    CGContextRef context = UIGraphicsGetCurrentContext();
    // flip the coordinate system
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    // draw
    CTLineRef line = CTLineCreateWithAttributedString(
                                                      (CFAttributedStringRef)stringToDraw);
    CGContextSetTextPosition(context, 10.0, 10.0);
    CTLineDraw(line, context);
    // clean up
    CFRelease(line);
    CFRelease(sysUIFont);
    [stringToDraw release];
}

- (void)coreText2
{
    //创建要输出的字符串
    NSString *longText = @"袁唯来来 Lorem ipsum dolor sit amet, Before the iPad was released you had basically two ways how to get text on screen. Either you would stick with UILabel or UITextView provided by UIKit or if you felt hard-core you would draw the text yourself on the Quartz level incurring all the headaches induced by having to mentally switch between Objective-C and C API functions.\
        As of iOS 3.2 we gained a third alternative in Core Text promising full control over styles, thread safety and performance. However for most of my apps I did not want to break 3.x compatibility and so I procrastinated looking at this powerful new API. Apps running only on iPads could have made use of Core Text from day 1, but to me it made more sense supporting iPad via hybrid apps where the iPhone part would still be backwards compatible.\
            Now as the year has turned the adoption of 4.x on all iOS platforms is ever more accelerating. Many new iPads where found under the Christmas tree and by now even the most stubborn people (read needing 3.x for jailbreaking and sim-unlocking) have little reason to stick with 3.x. Thus we have almost no incentive left to stick with 3.x compatibility. Yay!"; /* … */
    
    //创建AttributeString
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]
                                         initWithString:longText];
    
    //创建字体以及字体大小
    CTFontRef helvetica = CTFontCreateWithName(CFSTR("Helvetica"), 14.0, NULL);
    CTFontRef helveticaBold = CTFontCreateWithName(CFSTR("Helvetica-Bold"), 14.0, NULL);
    
    //添加字体 目标字符串从下标0开始到字符串结尾
    [string addAttribute:(id)kCTFontAttributeName
                   value:(id)helvetica
                   range:NSMakeRange(0, [string length])];
    
    //添加字体 目标字符串从下标0开始，截止到4个单位的长度
    [string addAttribute:(id)kCTFontAttributeName
                   value:(id)helveticaBold
                   range:NSMakeRange(0, 4)];
    
    //添加字体 目标字符串从下标6开始，截止到5个单位长度
    [string addAttribute:(id)kCTFontAttributeName
                   value:(id)helveticaBold
                   range:NSMakeRange(6, 5)];
    
    //添加字体 目标字符串从下标109开始，截止到9个单位长度
    [string addAttribute:(id)kCTFontAttributeName
                   value:(id)helveticaBold
                   range:NSMakeRange(109, 9)];
    
    //添加字体 目标字符串从下标223开始，截止到6个单位长度
    [string addAttribute:(id)kCTFontAttributeName
                   value:(id)helveticaBold
                   range:NSMakeRange(223, 6)];
    
    //添加颜色，目标字符串从下标0开始，截止到4个单位长度
    [string addAttribute:(id)kCTForegroundColorAttributeName
                   value:(id)[UIColor blueColor].CGColor
                   range:NSMakeRange(0, 4)];
    
    //添加过程同上
    [string addAttribute:(id)kCTForegroundColorAttributeName
                   value:(id)[UIColor redColor].CGColor
                   range:NSMakeRange(18, 3)];
    
    [string addAttribute:(id)kCTForegroundColorAttributeName
                   value:(id)[UIColor greenColor].CGColor
                   range:NSMakeRange(657, 6)];
    
    [string addAttribute:(id)kCTForegroundColorAttributeName
                   value:(id)[UIColor blueColor].CGColor
                   range:NSMakeRange(153, 6)];
    
    //创建文本对齐方式
    CTTextAlignment alignment = kCTLeftTextAlignment;//左对齐 kCTRightTextAlignment为右对齐
    CTParagraphStyleSetting alignmentStyle;
    alignmentStyle.spec=kCTParagraphStyleSpecifierAlignment;//指定为对齐属性
    alignmentStyle.valueSize=sizeof(alignment);
    alignmentStyle.value=&alignment;
    
    //创建文本行间距
    CGFloat lineSpace=5.0f;//间距数据
    CTParagraphStyleSetting lineSpaceStyle;
    lineSpaceStyle.spec=kCTParagraphStyleSpecifierLineSpacing;//指定为行间距属性
    lineSpaceStyle.valueSize=sizeof(lineSpace);
    lineSpaceStyle.value=&lineSpace;
    
    //创建样式数组
    CTParagraphStyleSetting settings[]={
        alignmentStyle,lineSpaceStyle
    };
    
    //设置样式
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(settings, sizeof(settings));
    
    //给字符串添加样式attribute
    [string addAttribute:(id)kCTParagraphStyleAttributeName
                   value:(id)paragraphStyle
                   range:NSMakeRange(0, [string length])];
    
    // layout master
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(
                                                                           (CFAttributedStringRef)string);
    
    CGMutablePathRef leftColumnPath = CGPathCreateMutable();
    CGPathAddRect(leftColumnPath, NULL,  
                  CGRectMake(0, 0,  
                             self.bounds.size.width,  
                             self.bounds.size.height));  
    
    CTFrameRef leftFrame = CTFramesetterCreateFrame(framesetter,  
                                                    CFRangeMake(0, 0),  
                                                    leftColumnPath, NULL);  
    
    // flip the coordinate system  
    CGContextRef context = UIGraphicsGetCurrentContext();  
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);  
    CGContextTranslateCTM(context, 0, self.bounds.size.height);  
    CGContextScaleCTM(context, 1.0, -1.0);  
    
    // draw  
    CTFrameDraw(leftFrame, context);  
    
    // cleanup  
    
    CGPathRelease(leftColumnPath);  
    CFRelease(framesetter);  
    CFRelease(helvetica);  
    CFRelease(helveticaBold);  
    [string release];  
    UIGraphicsPushContext(context);
}

- (void)drawRect:(CGRect)rect

{
    [self coreTextMubColorInRect:rect];
//    [self coretext1];
}


@end
