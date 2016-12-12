//
//  HAPDFView.m
//  IOSStudy
//
//  Created by haiwang on 16/5/18.
//  Copyright © 2016年 hai. All rights reserved.
//

#import "HAPDFView.h"

@interface HAPDFView ()

@property (nonatomic, copy) NSString *pdfUrl;

@property (nonatomic, retain) NSData *pdfData;

@property (nonatomic, retain) UIImage *image;

@end

@implementation HAPDFView

- (instancetype)initWithPDFUrl:(NSString *) pdfUrl
{
    self = [super init];
    if (self) {
        self.pdfUrl = pdfUrl;
        [self loadPDF];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)loadPDF
{
//    NSLog(@"vancl app dir : %@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]);
//    
//    NSURL* url = [NSURL URLWithString:self.pdfUrl];
//    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        
//        // NSFileManager *manager = [NSFileManager defaultManager];
//        [data writeToFile:@"fapiao.pdf" atomically:YES];
//    }];
//    return;
    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.pdfUrl]];
//    return;
    //TJHTFP20160512122794.pdf    TJHTFP201605121227942222.pdf
//    NSURL *pdfFile  = [[NSBundle mainBundle] URLForResource:@"TJHTFP201605121227942222" withExtension:@"pdf"];
    NSURL *pdfFile  = [[NSBundle mainBundle] URLForResource:@"TJHTFP20160512122794" withExtension:@"pdf"];
    pdfFile = [NSURL URLWithString:self.pdfUrl];
    self.pdfData = [NSData dataWithContentsOfURL:pdfFile];
    NSString *dataDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"%@",dataDirPath);
    NSString *file = [dataDirPath stringByAppendingString:@"fapiao.pdf"];
    [self.pdfData writeToFile:file atomically:YES];
    [self setNeedsDisplay];
    return;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CFDataRef pdfData = (CFDataRef)self.pdfData;
    //    pdfData = CFDataCreate(NULL, self.pdfData.bytes, self.pdfData.bytes.count);
    CGDataProviderRef provideRef = CGDataProviderCreateWithCFData(pdfData);
    CGPDFDocumentRef pdfDocumentRef = CGPDFDocumentCreateWithProvider(provideRef);
    
    self.image = [self imageFromPDFWithDocumentRef:pdfDocumentRef];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    image  = [UIImage imageWithData:self.pdfData];
    image = self.image;
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo
{
    if (error) {
        NSLog(@"保存失败");
    }else{
        NSLog(@"保存成功");
    }
}

- (UIImage *)imageFromPDFWithDocumentRef:(CGPDFDocumentRef)documentRef {
    CGPDFPageRef pageRef = CGPDFDocumentGetPage(documentRef, 1);
    CGRect pageRect = CGPDFPageGetBoxRect(pageRef, kCGPDFCropBox);
    
    UIGraphicsBeginImageContext(pageRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, CGRectGetMinX(pageRect),CGRectGetMaxY(pageRect));
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, -(pageRect.origin.x), -(pageRect.origin.y));
    CGContextDrawPDFPage(context, pageRef);
    
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return finalImage;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CFDataRef pdfData = (CFDataRef)self.pdfData;
    //    pdfData = CFDataCreate(NULL, self.pdfData.bytes, self.pdfData.bytes.count);
    CGDataProviderRef provideRef = CGDataProviderCreateWithCFData(pdfData);
    CGPDFDocumentRef pdfDocumentRef = CGPDFDocumentCreateWithProvider(provideRef);
    
    CGPDFPageRef pageRef = CGPDFDocumentGetPage(pdfDocumentRef, 1);
    CGRect pageRect = CGPDFPageGetBoxRect(pageRef, kCGPDFArtBox);
    
    UIGraphicsBeginImageContext(pageRect.size);
    CGContextTranslateCTM(context, CGRectGetMinX(pageRect),CGRectGetMaxY(pageRect));
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, -(pageRect.origin.x), -(pageRect.origin.y));
    CGContextDrawPDFPage(context, pageRef);
    CGPDFDocumentRelease (pdfDocumentRef);
}

@end
