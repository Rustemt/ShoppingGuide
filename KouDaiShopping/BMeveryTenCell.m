//
//  BMeveryTenCell.m
//  KouDaiShopping
//
//  Created by admin on 14-5-6.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import "BMeveryTenCell.h"

#define kFirst      1000
#define kSecond  1001
#define kThird     1002
#define kFour      1004

@implementation BMeveryTenCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

//    NSLog(@"selct");
    // Configure the view for the selected state
}
- (IBAction)proClick:(UIButton *)sender {
    
    NSLog(@"Cell proClick");
    if ([self.tDelegate respondsToSelector:@selector(clickTen:)]) {
        [self.tDelegate clickTen:sender];
    }

}

@end
