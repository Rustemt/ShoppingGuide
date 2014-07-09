//
//  BMCategory.h
//  KouDaiShopping
//
//  Created by admin on 14-6-2.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMCategory : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) UIColor *color;
@property (nonatomic) BOOL isCollect;
+ (instancetype)initWithTitle:(NSString *)title Color:(UIColor*)color;
@end
