//
//  BMPromotion.h
//  KouDaiShopping
//
//  Created by admin on 14-6-7.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMPromotion : NSObject
@property (nonatomic,strong) NSString *catelogyId;
@property (nonatomic,strong) NSString *imageUrl;
@property (nonatomic,strong) NSString *promitionInfo;
@property (nonatomic,strong) NSString *promotionId;
@property (nonatomic,strong) NSString *promotionName;

+ (instancetype)initWithDict:(NSDictionary *)dict;
@end
