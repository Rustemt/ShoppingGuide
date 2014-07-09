//
//  TGDealTool.m
//  团购
//
//  Created by apple on 13-11-14.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "TGDealTool.h"
#import "TGMetaDataTool.h"
#import "DPAPI.h"
#import "TGCity.h"
#import "TGDeal.h"
#import "TGOrder.h"
#import "NSObject+Value.h"
#import "TGLocationTool.h"

typedef void (^RequestBlock)(id result, NSError *errorObj);

@interface TGDealTool() <DPRequestDelegate>
{
    NSMutableDictionary *_blocks;
}
@end

@implementation TGDealTool
singleton_implementation(TGDealTool)

- (id)init
{
    if (self = [super init]) {
        _blocks = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark 获得大批量团购
- (void)getDealsWithParams:(NSDictionary *)params success:(DealsSuccessBlock)success error:(DealsErrorBlock)error
{
    [self requestWithURL:@"v1/deal/find_deals" params:params block:^(id result, NSError *errorObj) {
         if (errorObj) { // 请求失败
             if (error) {
                 error(errorObj);
             }
         } else if (success) { // 请求成功
             NSArray *array = result[@"deals"];
             NSMutableArray *deals = [NSMutableArray array];
             
             for (NSDictionary *dict in array) {
                 TGDeal *d = [[TGDeal alloc] init];
                 [d setValues:dict];
                 [deals addObject:d];
             }
             
             success(deals, [result[@"total_count"] intValue]);
         }
     }];
}

#pragma mark 获得周边的团购
- (void)dealsWithPos:(CLLocationCoordinate2D)pos success:(DealsSuccessBlock)success error:(DealsErrorBlock)error
{
    TGCity *city = [TGLocationTool sharedTGLocationTool].locationCity;
    if (city == nil) return;
    
    [self getDealsWithParams:@{
         @"city" : @"淄博",
         @"latitude" : @(pos.latitude),
         @"longitude" : @(pos.longitude),
         @"radius" : @5000
     } success:success error:error];
}

#pragma mark 获得指定的团购数据
- (void)dealWithID:(NSString *)ID success:(DealSuccessBlock)success error:(DealErrorBlock)error
{
    [self requestWithURL:@"v1/deal/get_single_deal" params:@{
        @"deal_id" : ID
     } block:^(id result, NSError *errorObj) {
         NSArray *deals = result[@"deals"];
         if (deals.count) { // 成功
             if (success) {
                 TGDeal *deal = [[TGDeal alloc] init];
                 [deal setValues:deals[0]];
                 success(deal);
             }
         } else { // 失败
             if (error) {
                 error(errorObj);
             }
         }
     }];
}

#pragma mark 获得第page页的团购数据
- (void)dealsWithPage:(int)page success:(DealsSuccessBlock)success error:(DealsErrorBlock)error
{
    // 1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@(15) forKey:@"limit"];
    // 1.1.添加城市参数
    NSString *city = [TGMetaDataTool sharedTGMetaDataTool].currentCity.name;
    [params setObject:city forKey:@"city"];
    
    // 1.2.添加区域参数
    NSString *district = [TGMetaDataTool sharedTGMetaDataTool].currentDistrict;
    if (district && ![district isEqualToString:kAllDistrict]) {
        [params setObject:district forKey:@"region"];
    }
    
    // 1.3.添加分类参数
    NSString *category = [TGMetaDataTool sharedTGMetaDataTool].currentCategory;
    if (category && ![category isEqualToString:kAllCategory]) {
        [params setObject:category forKey:@"category"];
    }
    
    // 1.4.添加排序参数
    TGOrder *order = [TGMetaDataTool sharedTGMetaDataTool].currentOrder;
    if (order) {
        if (order.index == 7) {// 按距离最近排序
            TGCity *city = [TGLocationTool sharedTGLocationTool].locationCity;
            if (city) { // 按距离最近排序
                [params setObject:@(order.index) forKey:@"sort"];
                // 多增加经纬度参数
                [params setObject:@(city.position.latitude) forKey:@"latitude"];
                [params setObject:@(city.position.longitude) forKey:@"longitude"];
            }
        } else { // 按照其他方式排序
            [params setObject:@(order.index) forKey:@"sort"];
        }
    }
    
    // 1.5.添加页码参数
    [params setObject:@(page) forKey:@"page"];
    
    // 2.发送请求
    [self getDealsWithParams:params success:success error:error];
}

#pragma mark 封装了点评的任何请求
- (void)requestWithURL:(NSString *)url params:(NSDictionary *)params block:(RequestBlock)block
{
    DPAPI *api = [DPAPI sharedDPAPI];
    /*
     1.请求成功会调用self的下面方法
     - (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
     
     2.请求失败会调用self的下面方法
     - (void)request:(DPRequest *)request didFailWithError:(NSError *)error
     */
    DPRequest *request = [api requestWithURL:url params:params delegate:self];
    
    // 一次请求 对应 一个block
    // 不直接用request的原因是：字典的key必须遵守NSCopying协议
    // request.description返回的是一个格式为“<类名：内存地址>”的字符串，能代表唯一的一个request对象
    [_blocks setObject:block forKey:request.description];
}

#pragma mark - 大众点评的请求方法代理
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    // 取出这次request对应的block
    RequestBlock block = _blocks[request.description];
    if (block) {
        block(result, nil);
    }
}

- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    // 取出这次request对应的block
    RequestBlock block = _blocks[request.description];
    if (block) {
        block(nil, error);
    }
}
@end