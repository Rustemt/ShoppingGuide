//
//  BMCateCell.h
//  KouDaiShopping
//
//  Created by admin on 14-6-2.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMCategory.h"
#import "BMMyButton.h"

@interface BMCateCell : UITableViewCell

@property(nonatomic,strong)  UILabel *title;
@property(nonatomic,strong)  UIView *side ;
@property(nonatomic,strong)  UIView *bottom;
@property(nonatomic,strong)  BMMyButton *more;
@property(nonatomic,strong) BMCategory *model;
@end
