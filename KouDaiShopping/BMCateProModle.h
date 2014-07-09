//
//  BMCateProModle.h
//  KouDaiShopping
//
//  Created by admin on 14-6-15.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMCateProModle : NSObject
@property (nonatomic,strong) NSString *wareName;
@property (nonatomic,strong) NSString *skuId;
@property (nonatomic,strong) NSString *adWord;
@property (nonatomic,strong) NSString *imageUrl;
@property (nonatomic,strong) NSString *fid;
@property (nonatomic,strong) NSString *orderSort;
+ (instancetype)initWithDict:(NSDictionary *)dict;


@end
