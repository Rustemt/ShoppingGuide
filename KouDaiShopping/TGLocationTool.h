//
//  TGLocationTool.h
//  团购
//
//  Created by apple on 13-11-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@class TGCity;
@interface TGLocationTool : NSObject
singleton_interface(TGLocationTool)

@property (nonatomic, strong) TGCity *locationCity; // 定位城市
@end
