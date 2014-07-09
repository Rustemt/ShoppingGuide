//
//  BMPromotion.m
//  KouDaiShopping
//
//  Created by admin on 14-6-7.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import "BMPromotion.h"

@implementation BMPromotion
+ (instancetype)initWithDict:(NSDictionary *)dict
{
    BMPromotion *model = [[BMPromotion alloc]init];
//    NSNull *null = [NSNull null];
    if (dict == nil ||dict == NULL) {
        return  model;
    }
    if (dict[@"catelogyId"]) {
        model.catelogyId = dict[@"catelogyId"];
    }
    if (dict[@"imageUrl"]) {
        model.imageUrl = dict[@"imageUrl"];
    }
    if (dict[@"promitionInfo"]) {
        model.promitionInfo = dict[@"promitionInfo"];
    }
    if (dict[@"promotionId"]) {
        model.promotionId = dict[@"promotionId"];
    }
    if (dict[@"promotionName"]) {
        model.promotionName = dict[@"promotionName"];
    }
    
    return  model;
}
@end
