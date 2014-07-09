//
//  TGDealTool.h
//  团购
//
//  Created by apple on 13-11-14.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import <MapKit/MapKit.h>

@class TGDeal;
// deals里面装的都是模型数据
typedef void (^DealsSuccessBlock)(NSArray *deals, int totalCount);
typedef void (^DealsErrorBlock)(NSError *error);

// deals里面装的都是模型数据
typedef void (^DealSuccessBlock)(TGDeal *deal);
typedef void (^DealErrorBlock)(NSError *error);


@interface TGDealTool : NSObject
singleton_interface(TGDealTool)

#pragma mark 获得第page页的团购数据
- (void)dealsWithPage:(int)page success:(DealsSuccessBlock)success error:(DealsErrorBlock)error;

#pragma mark 获得指定的团购数据
- (void)dealWithID:(NSString *)ID success:(DealSuccessBlock)success error:(DealErrorBlock)error;

#pragma mark 获得周边的团购信息
- (void)dealsWithPos:(CLLocationCoordinate2D)pos success:(DealsSuccessBlock)success error:(DealsErrorBlock)error;
@end