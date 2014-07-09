//
//  BMSelectModle.m
//  KouDaiShopping
//
//  Created by admin on 14-6-8.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import "BMSelectModle.h"

@implementation BMSelectModle

+ (instancetype)initWithDict:(NSDictionary *)dict
{
    NSLog(@"dict -- %@",dict);
    
    BMSelectModle *model = [[BMSelectModle alloc]init];
    
    
    if (dict ==nil || dict == NULL) {
        return model;
    }
        
    if (dict[@"imageUrl"]) {
        model.imageurl = dict[@"imageUrl"];
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
