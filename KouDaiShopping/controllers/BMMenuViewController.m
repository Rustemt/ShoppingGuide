//
//  BMViewController.m
//  KouDaiShopping
//
//  Created by admin on 14-5-6.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import "BMMenuViewController.h"
#import "BMHomeController.h"
#import "BMSearchController.h"
#import "BMCollectController.h"
#import "BMSettingController.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "BMMyFavController.h"
#import "BMMyDynmicController.h"
#import "BMShopController.h"
#import "BMAlumController.h"
#import "BMMapController.h"

@interface BMMenuViewController ()

@end

@implementation BMMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    [self setupViewControllers];
}
- (NSUInteger)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return UIInterfaceOrientationMaskAll;
    } else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return YES;
    }
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}
- (void)setupViewControllers {
    
    UIStoryboard *Main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BMHomeController *homeContreller = [Main instantiateViewControllerWithIdentifier:@"Home"];
    UIViewController *homeNav = [[UINavigationController alloc]
                                 initWithRootViewController:homeContreller];
    
    BMMapController *searchController = [[BMMapController alloc] init];
    UIViewController *searchNav = [[UINavigationController alloc]
                                   initWithRootViewController:searchController];
    
    NSArray *titleArray = [NSArray arrayWithObjects:@"宝贝",@"动态",@"店铺",@"专辑", nil];
    
    NSMutableArray *controllerArray = [[NSMutableArray alloc]init];
    
    for (NSString* title in titleArray)
    {
        
        UIViewController *vc = [[UIViewController alloc]init];
        if ([title isEqualToString:@"宝贝"]) {
            vc = [[BMMyFavController alloc]init];
        }else if([title isEqualToString:@"动态"])
        {
            vc = [[BMMyDynmicController alloc]init];
        }else if([title isEqualToString:@"店铺"])
        {
            vc = [[BMShopController alloc]init];
        }else if([title isEqualToString:@"专辑"])
        {
            vc = [[BMAlumController alloc]init];
        }
        int r = rand() % 255;
        int b = rand() % 255;
        vc.view.backgroundColor = RGBCOLOR(r,255, b);
        
        [controllerArray addObject:vc];
    }
    
    BMCollectController *collectController = [[ BMCollectController alloc]init];
    
    UIViewController *collectNav = [[UINavigationController alloc]
                                    initWithRootViewController:collectController];
    BMSettingController *settingController = [[BMSettingController alloc] init];
    UIViewController *settingNav = [[UINavigationController alloc]
                                    initWithRootViewController:settingController];
    
    [self setViewControllers:@[homeNav, searchNav,
                                           collectNav,settingNav]];
    
    [self customizeTabBarForController:self];
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    
    // 注：图片可以更小，节约资源
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"GLIPN_myStreet", @"GLIPN_search", @"GLIPN_favo",@"GLIPN_setting"];
    NSArray *titleName = @[@"我的街",@"地图",@"收藏",@"服务"];
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_sel",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        [item setTitle:titleName[index]];
        UIOffset imageOffset = UIOffsetMake(0, 8);
        UIOffset titleOffset = UIOffsetMake(0, -12);
        [item setImagePositionAdjustment:imageOffset];
        [item setTitlePositionAdjustment:titleOffset];
        index++;
    }
}

- (void)customizeInterface {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    if ([[[UIDevice currentDevice] systemVersion] integerValue] >= 7.0) {
        [navigationBarAppearance setBackgroundImage:[UIImage imageNamed:@"navigationbar_background_tall"]
                                      forBarMetrics:UIBarMetricsDefault];
    } else {
        [navigationBarAppearance setBackgroundImage:[UIImage imageNamed:@"navigationbar_background"]
                                      forBarMetrics:UIBarMetricsDefault];
        
        NSDictionary *textAttributes = nil;
        
        if ([[[UIDevice currentDevice] systemVersion] integerValue] >= 7.0) {
            textAttributes = @{
                               NSFontAttributeName: [UIFont boldSystemFontOfSize:20],
                               NSForegroundColorAttributeName: [UIColor blackColor],
                               };
        } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
            textAttributes = @{
                               UITextAttributeFont: [UIFont boldSystemFontOfSize:20],
                               UITextAttributeTextColor: [UIColor blackColor],
                               UITextAttributeTextShadowColor: [UIColor clearColor],
                               UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                               };
#endif
        }
        
        [navigationBarAppearance setTitleTextAttributes:textAttributes];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
