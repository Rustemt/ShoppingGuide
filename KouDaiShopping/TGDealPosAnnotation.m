//
//  TGDealPosAnnotation.m
//  团购
//
//  Created by apple on 13-11-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "TGDealPosAnnotation.h"
#import "TGMetaDataTool.h"
#import "TGDeal.h"

@implementation TGDealPosAnnotation
- (void)setDeal:(TGDeal *)deal
{
    _deal = deal;
    
    for (NSString *c in deal.categories) {
        NSString *icon = [[TGMetaDataTool sharedTGMetaDataTool] iconWithCategoryName:c];
        if (icon) {
            _icon = [icon stringByReplacingOccurrencesOfString:@"filter_" withString:@""];
            break;
        }
    }
}
@end
