//
//  BMmyCell.h
//  KouDaiShopping
//
//  Created by admin on 14-5-6.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BMShopDelegate <NSObject>
- (void)ShopClick:(UIButton*)btn;
@end

@interface BMmyCell : UITableViewCell
@property(nonatomic,weak) id<BMShopDelegate> shopDelegate;
@property (nonatomic,strong) NSIndexPath *selectPath;
@end
