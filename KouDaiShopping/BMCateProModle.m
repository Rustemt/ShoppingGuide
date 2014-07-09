//
//  BMCateProModle.m
//  KouDaiShopping
//
//  Created by admin on 14-6-15.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import "BMCateProModle.h"

@implementation BMCateProModle
+ (instancetype)initWithDict:(NSDictionary *)dict
{
    NSLog(@"dict -- %@",dict);
    
    BMCateProModle *model = [[BMCateProModle alloc]init];
    
    
    if (dict ==nil || dict == NULL) {
        return model;
    }
    
    if (dict[@"wareName"]) {
        model.wareName = dict[@"wareName"];
    }
    if (dict[@"skuId"]) {
        model.skuId = dict[@"skuId"];
    }
    if (dict[@"adWord"]) {
        model.adWord = dict[@"adWord"];
    }
    if (dict[@"imageUrl"]) {
        model.imageUrl = dict[@"imageUrl"];
    }
    
    
    return model;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_wareName forKey:@"_wareName"];
    [encoder encodeObject:_skuId forKey:@"_skuId"];
    
    [encoder encodeObject:_adWord forKey:@"_adWord"];
    [encoder encodeObject:_imageUrl forKey:@"_imageUrl"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.wareName = [decoder decodeObjectForKey:@"_wareName"];
        self.skuId = [decoder decodeObjectForKey:@"_skuId"];
        self.adWord = [decoder decodeObjectForKey:@"_adWord"];
        self.imageUrl = [decoder decodeObjectForKey:@"_imageUrl"];
    }
    return self;
}

@end
