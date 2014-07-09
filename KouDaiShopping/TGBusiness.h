//
//  TGBusiness.h
//  团购
//
//  Created by apple on 13-11-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TGBusiness : NSObject
@property (nonatomic, copy) NSString * city;
@property (nonatomic, copy) NSString * h5_url;
@property (nonatomic, assign) int ID;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@property (nonatomic, copy) NSString *name;
@end
