//
//  TGCollectTool.h
//  团购
//
//  Created by apple on 13-11-17.
//  Copyright (c) 2013年 itcast. All rights reserved.
//  专门用来处理收藏业务

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "BMSecKillModel.h"

@class TGDeal;

@interface TGCollectTool : NSObject
singleton_interface(TGCollectTool)

// 获得所有的收藏信息
@property (nonatomic, strong, readonly) NSArray *collectedDeals;

// 处理团购是否收藏
- (void)handleDeal:(BMSecKillModel *)deal;

// 添加收藏
- (void)collectDeal:(BMSecKillModel *)deal;

// 取消收藏
- (void)uncollectDeal:(BMSecKillModel *)deal;

@end
