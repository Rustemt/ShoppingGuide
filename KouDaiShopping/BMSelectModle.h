//
//  BMSelectModle.h
//  KouDaiShopping
//
//  Created by admin on 14-6-8.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMSelectModle : NSObject
@property (nonatomic,strong) NSString *startRemainTime;
@property (nonatomic,strong) NSString *endRemainTime;
@property (nonatomic,strong) NSString *imageurl;
@property (nonatomic,strong) NSString *jdPrice;
@property (nonatomic,strong) NSString *wareName;
@property (nonatomic,strong) NSString *skuId;
+ (instancetype)initWithDict:(NSDictionary *)dict;

@end
