//
//  BMCommon.h
//  KouDaiShopping
//
//  Created by admin on 14-6-7.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "BMSecKillModel.h"

@interface BMCommon : NSObject
singleton_interface(BMCommon)
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *cid;
@property (nonatomic,strong) NSString *keyword;
@property (nonatomic,strong) BMSecKillModel *model;

@end
