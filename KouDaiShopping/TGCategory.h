//
//  TGCategory.h
//  团购
//
//  Created by apple on 13-11-11.
//  Copyright (c) 2013年 itcast. All rights reserved.
//  分类对象

#import "TGBaseModel.h"

@interface TGCategory : TGBaseModel
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, strong) NSArray *subcategories;
@end
