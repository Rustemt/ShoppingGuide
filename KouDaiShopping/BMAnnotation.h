//
//  BMAnnotation.h
//  01.地图
//
//  Created by skyming on 14-4-13.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface BMAnnotation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

// 大头针图标
@property (nonatomic, strong) NSString *icon;
@end
