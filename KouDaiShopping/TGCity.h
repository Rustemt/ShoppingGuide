//
//  TGCity.h
//  团购
//
//  Created by apple on 13-11-9.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "TGBaseModel.h"
#import <CoreLocation/CoreLocation.h>
@interface TGCity : TGBaseModel
@property (nonatomic, strong) NSArray *districts; // 分区
@property (nonatomic, assign) BOOL hot;

@property (nonatomic, assign) CLLocationCoordinate2D position;
@end
