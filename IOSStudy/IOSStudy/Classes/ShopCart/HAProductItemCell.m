//
//  HAProductItemCell.m
//  IOSStudy
//
//  Created by hai on 14-7-2.
//  Copyright (c) 2014年 hai. All rights reserved.
//

#import "HAProductItemCell.h"

@interface HAProductItemCell ()

@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *colorLabel;
@property (nonatomic, retain) IBOutlet UILabel *sizeLabel;
@property (nonatomic, retain) IBOutlet UILabel *countLabel;

@property (nonatomic, retain) HAShopCartItem *item;

@end


@implementation HAProductItemCell

- (void)dealloc
{
    [_nameLabel release];
    [_colorLabel release];
    [_sizeLabel release];
    [_countLabel release];
    [_item release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"HAProductItemCell" owner:self options:nil];
        self = [array[0] retain];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -- public methods

- (void)updateData:(HAShopCartItem *) productItem
{
    self.item = productItem;
    _nameLabel.text = productItem.productName;
    _colorLabel.text = [NSString stringWithFormat:@"颜色:%@",productItem.skuProduct.color];
    _sizeLabel.text = [NSString stringWithFormat:@"尺码:%f",productItem.skuProduct.size];
    _countLabel.text = [NSString stringWithFormat:@"X%d",productItem.counts];
}

@end
