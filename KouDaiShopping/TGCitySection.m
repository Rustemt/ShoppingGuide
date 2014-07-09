//
//  CitySection.m
//  团购
//
//  Created by apple on 13-11-9.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "TGCitySection.h"
#import "TGCity.h"
#import "NSObject+Value.h"

@implementation TGCitySection

- (void)setCities:(NSMutableArray *)cities
{
    // 当cities为空或者里面装的是模型数据，就直接赋值
    id obj = [cities lastObject];
    if (![obj isKindOfClass:[NSDictionary class]]){
        _cities = cities;
        return;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in cities) {
        TGCity *city = [[TGCity alloc] init];
        [city setValues:dict];
        [array addObject:city];
    }
    _cities = array;
}
@end
