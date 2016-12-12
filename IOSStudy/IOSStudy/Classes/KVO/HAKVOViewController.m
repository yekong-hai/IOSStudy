//
//  HAKVOViewController.m
//  IOSStudy
//
//  Created by haiwang on 14-8-19.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAKVOViewController.h"
#import "StockData.h"

#define RETAINCOUNT NSLog(@" self retaincount = %d", self.retainCount);

@interface HAKVOViewController ()

@property (nonatomic, retain) IBOutlet UILabel *priceLabel;

@property (nonatomic, retain) StockData *data;

@end

@implementation HAKVOViewController

- (void)dealloc
{
    [_priceLabel release];
    RETAINCOUNT;
    [_data removeObserver:self forKeyPath:@"price"];
    RETAINCOUNT;
    [_data release];
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
    
    _data = [[StockData alloc] init];
    _data.stockName = @"searph";
    _data.price = 10.0f;
    RETAINCOUNT;
    [_data addObserver:self forKeyPath:@"price" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    RETAINCOUNT;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onChangeValueBtnClicked:(id)sender
{
    _data.price++;
    HALog(@"change data value");
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"price"]) {
        _priceLabel.text = [NSString stringWithFormat:@"%.1f",_data.price];
    }
}

@end
