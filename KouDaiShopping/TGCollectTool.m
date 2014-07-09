//
//  TGCollectTool.m
//  团购
//
//  Created by apple on 13-11-17.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "TGCollectTool.h"

#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"collects.data"]

@interface TGCollectTool()
{
    NSMutableArray *_collectedDeals;
}
@end

@implementation TGCollectTool
singleton_implementation(TGCollectTool)

// 从文件中读取了2个团购对象
//

- (id)init
{
    if (self = [super init]) {
        // 1.加载沙盒中的收藏数据
        _collectedDeals = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
        
        // 2.第一次没有收藏数据
        if (_collectedDeals == nil) {
            _collectedDeals = [NSMutableArray array];
        }
    }
    return self;
}

- (void)handleDeal:(BMSecKillModel *)deal
{
    deal.collected = [_collectedDeals containsObject:deal];
}

- (void)collectDeal:(BMSecKillModel *)deal
{
    deal.collected = YES;
    if (deal == nil) {
        return;
    }
    [_collectedDeals insertObject:deal atIndex:0];
    [NSKeyedArchiver archiveRootObject:_collectedDeals toFile:kFilePath];
}

- (void)uncollectDeal:(BMSecKillModel *)deal
{
    deal.collected = NO;
    if (deal == nil) {
        return;
    }
    [_collectedDeals removeObject:deal];
    [NSKeyedArchiver archiveRootObject:_collectedDeals toFile:kFilePath];
}
@end