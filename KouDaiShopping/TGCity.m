//
//  TGCity.m
//  团购
//
//  Created by apple on 13-11-9.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "TGCity.h"
#import "TGDistrict.h"
#import "NSObject+Value.h"

@implementation TGCity
- (void)setDistricts:(NSArray *)districts
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in districts) {
        TGDistrict *district = [[TGDistrict alloc] init];
        [district setValues:dict];
        [array addObject:district];
    }
    
    _districts = array;
}
@end
