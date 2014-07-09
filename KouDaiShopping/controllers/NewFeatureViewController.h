//
//  NewFeatureViewController.h
//  SinaWeibo
//
//  Created by mj on 13-8-19.
//  Copyright (c) 2013年 itcast. All rights reserved.
//  版本新特性

#import <UIKit/UIKit.h>
@interface NewFeatureViewController : UIViewController <UIScrollViewDelegate>
@property (nonatomic, copy) void (^startWeibo)(BOOL shared);
@end
