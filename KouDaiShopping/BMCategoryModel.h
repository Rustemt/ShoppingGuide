//
//  BMCategoryModel.h
//  KouDaiShopping
//
//  Created by admin on 14-6-9.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMCategoryModel : NSObject

@property (nonatomic,strong) NSString *cid;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *cdescription;
@property (nonatomic,strong) NSString *icon;
@property (nonatomic,strong) NSString *fid;
@property (nonatomic,strong) NSString *orderSort;
+ (instancetype)initWithDict:(NSDictionary *)dict;

@end
