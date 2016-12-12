//
//  HAMutableColorTextView.m
//  IOSStudy
//
//  Created by haiwang on 14-12-26.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAMutableColorTextView.h"

const NSString *haTextViewKeyColor = @"haTextViewKeyColor";

const NSString *haTextViewKeyRange = @"haTextViewKeyRange";


@interface HAMutableColorTextView ()
{
    float _padding;
}

@property (nonatomic, retain) NSMutableArray *colorRangeArray;

@end

@implementation HAMutableColorTextView

- (void)dealloc
{
    [_colorRangeArray release];
    [_text release];
    [super dealloc];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initParams];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initParams];
    }
    return self;
}

- (void)initParams
{
    self.backgroundColor = [UIColor lightGrayColor];
    _colorRangeArray = [[NSMutableArray array] retain];
    _padding = 5.0f;
    _fontSize = 17.0;
    self.text = @"经济技术开发区工业区东区经海一路科创三街三号院,凡客诚品技术测试,请忽略次订单";
    [self setFontColor:[UIColor blackColor] forRange:NSMakeRange(0, 10)];
    [self setFontColor:[UIColor redColor] forRange:NSMakeRange(10, 10)];
    [self setFontColor:[UIColor greenColor] forRange:NSMakeRange(20, 10)];
    [self heightForText];
}

- (void)coreTextMubColorInRect:(CGRect) rect
{
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:_text];
    [attString beginEditing];
    for (NSDictionary *dic in _colorRangeArray) {
        UIColor *fontColor = [dic objectForKey:haTextViewKeyColor];
        NSString *colorRange = [dic objectForKey:haTextViewKeyRange];
        NSRange fontRange = NSRangeFromString(colorRange);
        [attString addAttribute:(NSString *)kCTForegroundColorAttributeName value:fontColor range:fontRange];
    }
    CTFontRef sysUIFont = CTFontCreateUIFontForLanguage(kCTFontUIFontSystem, _fontSize, (CFStringRef)_text);
    [attString addAttribute:(NSString *)kCTFontAttributeName value:(id)sysUIFont range:NSMakeRange(0, _text.length)];
    [attString endEditing];
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(_padding, _padding, self.bounds.size.width - _padding, self.bounds.size.height - _padding));
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

- (void)drawRect:(CGRect)rect
{
    [self coreTextMubColorInRect:rect];
}

#pragma mark -- public methods

- (void)setFontColor:(UIColor *)color forRange:(NSRange)range
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:color,haTextViewKeyColor,NSStringFromRange(range),haTextViewKeyRange, nil];
    [_colorRangeArray addObject:dic];
}

- (CGFloat)heightForText
{
    NSLog(@"%f",self.bounds.size.width);
    CGSize size;
    //7.0
    size = [_text boundingRectWithSize:CGSizeMake(self.bounds.size.width, 10000) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:nil context:nil].size;
    NSLog(@"%@",NSStringFromCGSize(size));
    
    //6.0
    size = [_text sizeWithFont:[UIFont systemFontOfSize:_fontSize] forWidth:self.bounds.size.width lineBreakMode:NSLineBreakByClipping];
    NSLog(@"%@",NSStringFromCGSize(size));
    return size.height;
}

@end
