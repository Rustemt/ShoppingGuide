//
//  BMeveryTenCell.h
//  KouDaiShopping
//
//  Created by admin on 14-5-6.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BMTenDelegate <NSObject>
- (void)clickTen:(UIButton*)btn;
@end

@interface BMeveryTenCell : UITableViewCell
@property(nonatomic,weak) id<BMTenDelegate> tDelegate;
@property (weak, nonatomic) IBOutlet UIButton *moblePro;
@property (weak, nonatomic) IBOutlet UIButton *secKillPro;
@property (weak, nonatomic) IBOutlet UIButton *selectionPro;
@property (weak, nonatomic) IBOutlet UIButton *couponPro;

@end
