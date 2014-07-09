//
//  TGLocationTool.m
//  团购
//
//  Created by apple on 13-11-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "TGLocationTool.h"
#import <CoreLocation/CoreLocation.h>
#import "TGMetaDataTool.h"
#import "TGCity.h"

@interface TGLocationTool() <CLLocationManagerDelegate>
{
    CLLocationManager *_mgr;
    CLGeocoder *_geo;
}
@end

@implementation TGLocationTool
singleton_implementation(TGLocationTool)

- (id)init
{
    if (self = [super init]) {
        _geo = [[CLGeocoder alloc] init];
        
        _mgr = [[CLLocationManager alloc] init];
        _mgr.delegate = self;
        [_mgr startUpdatingLocation];
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    // 1.停止定位
    [_mgr stopUpdatingLocation];
    
    // 2.根据经纬度反向获得城市名称
    CLLocation *loc = locations[0];
    [_geo reverseGeocodeLocation:loc completionHandler:
     ^(NSArray *placemarks, NSError *error) {
         CLPlacemark *place = placemarks[0];
         NSString *cityName = place.addressDictionary[@"State"];
         cityName = [cityName substringToIndex:cityName.length - 1];
         TGCity *city = [TGMetaDataTool sharedTGMetaDataTool].totalCities[cityName];
         [TGMetaDataTool sharedTGMetaDataTool].currentCity = city;
         
         _locationCity = city;
         _locationCity.position = loc.coordinate;
     }];
}
@end
