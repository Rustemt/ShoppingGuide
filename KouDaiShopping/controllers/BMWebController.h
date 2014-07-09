//
//  BMWebController.h
//  KouDaiShopping
//
//  Created by admin on 14-6-7.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMSecKillModel.h"

@interface BMWebController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic) NSString *type;
@property (nonatomic) BMSecKillModel *model;

@end
