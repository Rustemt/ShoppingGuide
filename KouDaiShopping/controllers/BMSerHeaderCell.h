//
//  BMSerHeaderCell.h
//  KouDaiShopping
//
//  Created by admin on 14-6-3.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMSerHeaderCell : UITableViewCell
{
    NSTimer *timer;
}
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *sAD;

@end
