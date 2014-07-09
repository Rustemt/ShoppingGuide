//
//  BMCategory.m
//  KouDaiShopping
//
//  Created by admin on 14-6-2.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import "BMCategory.h"

@implementation BMCategory

+ (instancetype)initWithTitle:(NSString *)title Color:(UIColor*)color
{
    BMCategory *model = [[BMCategory alloc]init];
    model.title = title;
    model.color = color;
    model.isCollect = NO;
    return  model;
}
@end
