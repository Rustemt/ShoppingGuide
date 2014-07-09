//
//  BMMapController.m
//  Sensoro Configuration Utility
//
//  Created by admin on 14-4-13.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import "BMMapController.h"
#import <MapKit/MapKit.h>
#import "BMAnnotation.h"
#import "BMBeaconMgr.h"
#import "TGDealTool.h"
#import "TGDeal.h"
#import "TGBusiness.h"
#import "TGDealPosAnnotation.h"
#import "TGCity.h"
#import "TGLocationTool.h"
#import "TGCategory.h"

#define kRegion 10000.0f
#define kSpan MKCoordinateSpanMake(0.018404, 0.031468)

@interface BMMapController ()<MKMapViewDelegate>
{
    MKMapView *_mapView;
    UIPinchGestureRecognizer *_pinchGestureRecognizer;
    UITapGestureRecognizer *_tap;
    BMAnnotation *lastAnnotation;
    MKCoordinateRegion _myRegion;
    NSMutableArray *_showingDeals;

}
@property(nonatomic, unsafe_unretained)CGFloat currentScale;

@end

@implementation BMMapController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_center_img"] style:UIBarButtonItemStylePlain target:self action:@selector(myLocation)];
    self.title = @"周围商家";
    [self initView];
    // 3.添加回到用户位置的按钮
    UIButton *backUser = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:@"btn_map_locate.png"];
    [backUser setBackgroundImage:image forState:UIControlStateNormal];
    [backUser setBackgroundImage:[UIImage imageNamed:@"btn_map_locate_hl.png"] forState:UIControlStateNormal];
    CGFloat w = 44;
    CGFloat h = 44;
    CGFloat margin = 20;
    CGFloat x = self.view.frame.size.width - w - margin ;
    CGFloat y = self.view.frame.size.height - h - margin -35;
    backUser.frame = CGRectMake(x, y, w, h);
    backUser.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    [backUser addTarget:self action:@selector(myLocation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backUser];

}
- (void)backUserClick
{
    CLLocationCoordinate2D center = _mapView.userLocation.location.coordinate;
    MKCoordinateRegion region = MKCoordinateRegionMake(center, kSpan);
    [_mapView setRegion:region animated:YES];
}

#pragma mark - 实例化视图
- (void)initView
{
    self.view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    _mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_mapView];
    
    [_mapView setDelegate:self];
    [_mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    _mapView.showsUserLocation = YES;
    [_mapView setMapType:MKMapTypeStandard];
    
 
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    if (self.isInfoAddr) {
        [self addAnnotation];
        _pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinches:)];
        [_mapView addGestureRecognizer:_pinchGestureRecognizer];
        return ;
    }
    
   // _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addAnnotation)];
 //   [_mapView addGestureRecognizer:_tap];
    
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(myLocation)];
}
- (void)viewWillAppear:(BOOL)animated
{
    
}
-(void)handlePinches:(UIPinchGestureRecognizer *)paramSender{
    if (paramSender.state == UIGestureRecognizerStateEnded) {
        self.currentScale = paramSender.scale;
    }else if(paramSender.state == UIGestureRecognizerStateBegan && self.currentScale != 0.0f){
        paramSender.scale = self.currentScale;
    }
    if (paramSender.scale !=NAN && paramSender.scale != 0.0) {
        paramSender.view.transform = CGAffineTransformMakeScale(paramSender.scale, paramSender.scale);
    }
}



- (void)myLocation
{
    if (_isFreshed) {
        [_mapView setRegion:_myRegion animated:YES];
    }

}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    _isFreshed = NO;
}
- (void)addAnnotation
{
    
    CGPoint touchPoint = [_tap locationInView:_mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [_mapView convertPoint:touchPoint toCoordinateFromView:_mapView];
    
    if (self.isInfoAddr) {
        touchMapCoordinate.latitude =  [[BMBeaconMgr sharedBMBeaconMgr].lat doubleValue];
        touchMapCoordinate.longitude = [[BMBeaconMgr sharedBMBeaconMgr].lon doubleValue];
    }
    [BMBeaconMgr sharedBMBeaconMgr].lat = [NSString stringWithFormat:@"%f",touchMapCoordinate.latitude];
    [BMBeaconMgr sharedBMBeaconMgr].lon = [NSString stringWithFormat:@"%f",touchMapCoordinate.longitude];
    
    BMAnnotation  *annotation = [[BMAnnotation alloc]init];
    
    NSString *title = [NSString stringWithFormat:@"Location：%f--%f",touchMapCoordinate.latitude,touchMapCoordinate.longitude];
    [annotation setCoordinate:touchMapCoordinate];
    [annotation setTitle:title];
    [annotation setIcon:@"icon_pin.png"];
    
    MyLog(@"--%p %@", annotation, annotation);
    
    [_mapView removeAnnotation:lastAnnotation];
    [_mapView addAnnotation:annotation];
    lastAnnotation = annotation;

    if (self.isInfoAddr) {
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(touchMapCoordinate, kRegion, kRegion);
        [_mapView setRegion:region animated:YES];
//        _mapView.delegate = nil;
    }
    
}
#pragma mark - 地图代理方法
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MyLog(@"%@ %@", userLocation.location, userLocation.title);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, kRegion, kRegion);
    _myRegion = region;
    
    
    
    if (!self.isInfoAddr) {
        [BMBeaconMgr sharedBMBeaconMgr].lat = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
        [BMBeaconMgr sharedBMBeaconMgr].lon = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
    }

    if (!_isFreshed) {
        [mapView setRegion:region animated:YES];
        _isFreshed = YES;
    }
    
    CLLocationCoordinate2D pos = mapView.region.center;
    
    TGCity *city = [[TGCity alloc]init];
    city.position = pos;
    [TGLocationTool sharedTGLocationTool].locationCity = city;
    
    [[TGDealTool sharedTGDealTool] dealsWithPos:pos success:^(NSArray *deals, int totalCount) {
        for (TGDeal *d in deals) {
            // 已经显示过
            if ([_showingDeals containsObject:d]) continue;
            
            // 从未显示过
            [_showingDeals addObject:d];
            
            for (TGBusiness *b in d.businesses) {
                TGDealPosAnnotation *anno = [[TGDealPosAnnotation alloc] init];
                anno.business = b;
                anno.deal = d;
                NSString *iconStr = [NSString stringWithFormat:@"ic_category_%ld.png",random()%9];
                [anno setIcon:iconStr];                anno.coordinate = CLLocationCoordinate2DMake(b.latitude, b.longitude);
                [mapView addAnnotation:anno];
            }
        }
    } error:nil];
}
#pragma mark 拖动地图（地图展示的区域改变了）就会调用
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    // 1.地图当前展示区域的中心位置
    CLLocationCoordinate2D pos = mapView.region.center;

    TGCity *city = [[TGCity alloc]init];
    city.position = pos;
    [TGLocationTool sharedTGLocationTool].locationCity = city;
    
    [[TGDealTool sharedTGDealTool] dealsWithPos:pos success:^(NSArray *deals, int totalCount) {
        for (TGDeal *d in deals) {
            // 已经显示过
            if ([_showingDeals containsObject:d]) continue;
            
//            NSString *ct = [[NSString alloc]init];
//            if (d.categories.count > 0) {
//                NSLog(@"Cate %@",ct);
//                ct = d.categories[0];
//            }

            // 从未显示过
            [_showingDeals addObject:d];
            
            for (TGBusiness *b in d.businesses) {
                TGDealPosAnnotation *anno = [[TGDealPosAnnotation alloc] init];
                anno.business = b;
                anno.deal = d;
                NSString *iconStr = [NSString stringWithFormat:@"ic_category_%ld.png",random()%9];
                [anno setIcon:iconStr];
                anno.coordinate = CLLocationCoordinate2DMake(b.latitude, b.longitude);
                [mapView addAnnotation:anno];
            }
        }
    } error:nil];
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(TGDealPosAnnotation *)annotation
{
    
    if (![annotation isKindOfClass:[TGDealPosAnnotation class]]) return nil;
    
    // 1.从缓存池中取出大头针view
    static NSString *ID = @"MKAnnotationView";
    MKAnnotationView *annoView = [mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    
    // 2.缓存池没有可循环利用的大头针view
    if (annoView == nil) {
        // 这里应该用MKPinAnnotationView这个子类
        annoView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID];
    }
    
    // 3.设置view的大头针信息
    annoView.annotation = annotation;
    
    // 4.设置图片
    annoView.image = [UIImage imageNamed:annotation.icon];
    
    return annoView;
}

#pragma mark 点击了大头针
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    // 1.展示详情
    TGDealPosAnnotation *anno = view.annotation;
#warning 添加详情
//    [self showDetail:anno.deal];
    
    // 2.让选中的大头针居中
    [mapView setCenterCoordinate:anno.coordinate animated:YES];
    
    // 3.让view周边产生一些阴影效果
//    view.layer.shadowColor = [UIColor redColor].CGColor;
//    view.layer.shadowOpacity = 1;
//    view.layer.shadowRadius = 10;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
