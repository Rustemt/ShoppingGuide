//
//  BMSecKillModel.h
//  KouDaiShopping
//
//  Created by admin on 14-6-7.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMSecKillModel : NSObject

@property (nonatomic,strong) NSString *startRemainTime;
@property (nonatomic,strong) NSString *endRemainTime;
@property (nonatomic,strong) NSString *imageurl;
@property (nonatomic,strong) NSString *jdPrice;
@property (nonatomic,strong) NSString *wareName;
@property (nonatomic,strong) NSString *skuId;
@property (nonatomic,strong) NSString *title;

@property (nonatomic, assign) BOOL collected; // 是否被收藏

+ (instancetype)initWithDict:(NSDictionary *)dict;
@end
