//
//  BMBeaconMgr.h
//  Sensoro Configuration Utility
//
//  Created by admin on 14-4-10.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Singleton.h"
@interface BMBeaconMgr : NSObject
singleton_interface(BMBeaconMgr)
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;

@property (nonatomic, copy) NSString *beaconID;//
@property (nonatomic, copy) NSString *beaconName;
@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *lon;
@property (nonatomic, copy) NSString *location; //
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *detailAddress;

@property (nonatomic, copy) NSString *picture;
@property (nonatomic, copy) NSString *majorStr;
@property (nonatomic, copy) NSString *minjorStr;
@property (nonatomic) NSInteger rssi;
@property (nonatomic, copy) NSMutableArray *beacons;
@property (nonatomic, assign) BOOL needRefresh;
@property (nonatomic, copy) NSString *battery;

@end
