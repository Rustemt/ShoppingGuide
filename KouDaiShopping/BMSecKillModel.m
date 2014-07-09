//
//  BMSecKillModel.m
//  KouDaiShopping
//
//  Created by admin on 14-6-7.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import "BMSecKillModel.h"

@implementation BMSecKillModel

+ (instancetype)initWithDict:(NSDictionary *)dic
{
    NSLog(@"dict -- %@",dic);

    BMSecKillModel *model = [[BMSecKillModel alloc]init];
    
    if (dic ==nil || dic == NULL) {
        return model;
    }
    
    NSDictionary *dict = [NSDictionary dictionary];
    NSArray *dictM = [NSArray array];
    if (dic[@"wareInfoList"]) {
        dictM = dic[@"wareInfoList"];
        dict = dictM[0];
    }
    
    if (dict[@"imageurl"]) {
        model.imageurl = dict[@"imageurl"];
    }
    if (dict[@"wareName"]) {
        model.wareName = dict[@"wareName"];
    }
    if (dict[@"endRemainTime"]) {
        model.endRemainTime = dict[@"endRemainTime"];
    }
    if (dict[@"startRemainTime"]) {
        model.startRemainTime = dict[@"startRemainTime"];
    }
    
    if (dict[@"jdPrice"]) {
        model.jdPrice = dict[@"jdPrice"];
    }
    
    if (dict[@"skuId"]) {
        model.skuId = dict[@"skuId"];
    }
        
    
    return model;
}
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_wareName forKey:@"_wareName"];
    [encoder encodeObject:_skuId forKey:@"_skuId"];
    [encoder encodeObject:_jdPrice forKey:@"_jdPrice"];
    [encoder encodeObject:_imageurl forKey:@"_imageurl"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.wareName = [decoder decodeObjectForKey:@"_wareName"];
        self.skuId = [decoder decodeObjectForKey:@"_skuId"];
        self.jdPrice = [decoder decodeObjectForKey:@"_jdPrice"];
        self.imageurl = [decoder decodeObjectForKey:@"_imageurl"];
    }
    return self;
}
@end
