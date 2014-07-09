//
//  TGMetaDataTool.h
//  团购
//
//  Created by apple on 13-11-9.
//  Copyright (c) 2013年 itcast. All rights reserved.
//  元数据管理类
// 1.城市数据
// 2.下属分区数据
// 3.分类数据

#import <Foundation/Foundation.h>
#import "Singleton.h"
@class TGCity, TGOrder;

@interface TGMetaDataTool : NSObject
singleton_interface(TGMetaDataTool)
@property (nonatomic, strong, readonly) NSDictionary *totalCities; // 所有的城市
@property (nonatomic, strong, readonly) NSArray *totalCitySections; // 所有的城市组数据

@property (nonatomic, strong, readonly) NSArray *totalCategories; // 所有的分类数据

// 所有的排序数据
@property (nonatomic, strong, readonly) NSArray *totalOrders;

- (TGOrder *)orderWithName:(NSString *)name;

- (NSString *)iconWithCategoryName:(NSString *)name;


@property (nonatomic, strong) TGCity *currentCity; // 当前选中的城市
@property (nonatomic, strong) NSString *currentCategory; // 当前选中的类别
@property (nonatomic, strong) NSString *currentDistrict; // 当前选中的区域
@property (nonatomic, strong) TGOrder *currentOrder; // 当前选中的排序
@end