//
//  BMAppDelegate.m
//  KouDaiShopping
//
//  Created by admin on 14-5-6.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import "BMAppDelegate.h"
#import "NewFeatureViewController.h"
#import "SDWebImageManager.h"
#import "BMMenuViewController.h"
#import "TGCollectTool.h"

@implementation BMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [TGCollectTool sharedTGCollectTool];
    UILocalNotification *newNotification = [[UILocalNotification alloc] init];
    
    if (newNotification) {
        //时区
        newNotification.timeZone=[NSTimeZone defaultTimeZone];
        //推送事件---10秒后
        newNotification.fireDate=[[NSDate date] dateByAddingTimeInterval:10];
        //推送内容
        newNotification.alertBody = @"欢迎来到，CoffeeBene望京店";
        
        //应用右上角红色图标数字
        
        newNotification.applicationIconBadgeNumber = 1;
        
        //1:格式一定要支持播放，常用的格式caf
        
        //2:音频播放时间不能大于30秒
        
        //3:在Resource里要找到音频文件，倒入时最好能点项目名称右键add导入
        newNotification.soundName = UILocalNotificationDefaultSoundName;
        
        //设置按钮
        newNotification.alertAction = @"关闭";
        
        //判断重复与否
        
        newNotification.repeatInterval = NSWeekCalendarUnit;
        
        //存入的字典，用于传入数据，区分多个通知
        
        NSMutableDictionary *dicUserInfo = [[NSMutableDictionary alloc] init];
        
        [dicUserInfo setValue:@"" forKey:@"clockID"];
        
//        float floatHeng = userLocation.location.coordinate.latitude;
//        
//        float floatShu = userLocation.location.coordinate.longitude;
//        
//        [dicUserInfo setValue:[NSString stringWithFormat:@"%f",strX] forKey:@"heng"];
//        
//        [dicUserInfo setValue:[NSString stringWithFormat:@"%f",strY] forKey:@"shu"];
//        
        newNotification.userInfo = [NSDictionary dictionaryWithObject:dicUserInfo forKey:@"dictionary"];
        
        
        [[UIApplication sharedApplication] scheduleLocalNotification:newNotification];
        
    }
    
    NSLog(@"Post new localNotification:%@", newNotification);
    
    
    // 1.创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 2.版本号的key
    NSString *key = (NSString *)kCFBundleVersionKey;
    
    // 3.取出存储的版本号
    NSString *savedVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    // 4.获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    // 5.如果是第一次使用这个版本
    if (![currentVersion isEqualToString:savedVersion]) {
        // 5.1.存储字符串
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // 5.2.隐藏状态栏
        [UIApplication sharedApplication].statusBarHidden = YES;
        
        // 5.3.显示版本新特性界面
        NewFeatureViewController *new = [[NewFeatureViewController alloc] init];
        __unsafe_unretained BMAppDelegate *app = self;
        new.startWeibo = ^(BOOL shared) {
            [app start:shared];
        };
        self.window.rootViewController = new;
    } else {
        [self start:NO];
    }
    
    // 6.显示窗口
    [self.window makeKeyAndVisible];
    return YES;

    return YES;
}
- (void)start:(BOOL)shared
{
    // 1.显示状态栏
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    UIStoryboard *Main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BMMenuViewController *menuContreller = [Main instantiateViewControllerWithIdentifier:@"Menu"];
        self.window.rootViewController = menuContreller;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    // If the application is in the foreground, we will notify the user of the region's state via an alert.
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:notification.alertBody message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
 //   [[UIApplication sharedApplication] presentLocalNotificationNow:notification];

    [alert show];
}
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 清除内存中的图片缓存
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    [mgr cancelAll];
    [mgr.imageCache clearMemory];
}
@end
