//
//  BMmyCell.m
//  KouDaiShopping
//
//  Created by admin on 14-5-6.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import "BMmyCell.h"

@implementation BMmyCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)shopcellClick:(UIButton *)sender {
    if ([self.shopDelegate respondsToSelector:@selector(ShopClick:)]) {
        [self.shopDelegate ShopClick:sender];
    }
}

@end
