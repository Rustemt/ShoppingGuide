//
//  BMCategoryModel.m
//  KouDaiShopping
//
//  Created by admin on 14-6-9.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import "BMCategoryModel.h"

@implementation BMCategoryModel
+ (instancetype)initWithDict:(NSDictionary *)dict
{
    NSLog(@"dict -- %@",dict);
    
    BMCategoryModel *model = [[BMCategoryModel alloc]init];
    
    
    if (dict ==nil || dict == NULL) {
        return model;
    }
    
    if (dict[@"cid"]) {
        model.cid = dict[@"cid"];
    }
    if (dict[@"name"]) {
        model.name = dict[@"name"];
    }
    if (dict[@"description"]) {
        model.cdescription = dict[@"description"];
    }
    if (dict[@"icon"]) {
        model.icon = dict[@"icon"];
    }
        
    
    return model;
}
@end
