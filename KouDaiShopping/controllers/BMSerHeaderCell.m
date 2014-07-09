//
//  BMSerHeaderCell.m
//  KouDaiShopping
//
//  Created by admin on 14-6-3.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import "BMSerHeaderCell.h"

@implementation BMSerHeaderCell

- (void)awakeFromNib
{
    // Initialization code
    self.headIcon.layer.cornerRadius = 10.0f;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(change) userInfo:nil repeats:YES];
}
- (void)change
{
    CGFloat centerX = self.sAD.center.x - 1;
    self.sAD.center = CGPointMake(centerX, self.sAD.center.y);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
