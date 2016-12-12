//
//  HATextFieldViewController.m
//  IOSStudy
//
//  Created by hai on 14-6-23.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HATextFieldViewController.h"

@interface HATextFieldViewController ()<UITextFieldDelegate>

@property (nonatomic, retain) IBOutlet UITextField *firstTextField;

@end

@implementation HATextFieldViewController

- (void)dealloc
{
    [_firstTextField release];
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

- (void)setupFirstTextField
{
    _firstTextField.placeholder = @"请输入文字";
    //开始编辑的时候清除输入框的内容
    _firstTextField.clearsOnBeginEditing = YES;
    
    //设置根据控件的宽度来调整字体大小
    _firstTextField.minimumFontSize = 9.0f;
    _firstTextField.adjustsFontSizeToFitWidth = YES;
    
    //设置输入框的右侧清除按钮的模式，
    //UITextFieldViewModeNever----从不出现
    //UITextFieldViewModeWhileEditing---编辑的时候出现
    //UITextFieldViewModeUnlessEditing----非编辑的时候出现
    //UITextFieldViewModeAlways----一直出现
    _firstTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    //left view
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    leftView.backgroundColor = [UIColor greenColor];
    _firstTextField.leftView = leftView;
    [leftView release];
    _firstTextField.leftViewMode = UITextFieldViewModeAlways;
    
    //right view
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    rightView.backgroundColor = [UIColor redColor];
    _firstTextField.rightView = rightView;
    [rightView release];
    _firstTextField.rightViewMode = UITextFieldViewModeAlways;
    
    //input view-----------自定义键盘显示视图-代替原有键盘
    UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 200)];
    inputView.backgroundColor = [UIColor blueColor];
//    _firstTextField.inputView = inputView;
    [inputView release];

    //inputAccessory view----------自定义键盘视图上面的一个横条的附属视图
    UIView *inputAccessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    inputAccessoryView.backgroundColor = [UIColor brownColor];
//    _firstTextField.inputAccessoryView = inputAccessoryView;
    [inputAccessoryView release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupFirstTextField];
    
    [self registNotification];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- private methods

- (void)registNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onTextFieldTextDidChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)onTextFieldTextDidChanged:(id)sender
{
    NSLog(@"text change ...");
}

#pragma mark -- UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark -- action methods

- (IBAction)onEndEditingBtnClicked:(id)sender
{
    [self.view endEditing:YES];
}

@end
