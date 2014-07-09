//
//  BMWebController.m
//  KouDaiShopping
//
//  Created by admin on 14-6-7.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import "BMWebController.h"
#import "BMCommon.h"
#import "SVProgressHUD.h"
#import "TGCollectTool.h"
#define kChargeURL @"http://m.jd.com/chongzhi/index.action"
#define kLotteryURL @"http://caipiao.m.jd.com/"
#define kHomeURL @"http://m.jd.com/index.html?"
#define kSecKill @"http://m.jd.com/product/1076285251.html?resourceType=index_floor&resourceValue=m197"
@interface BMWebController ()<UIWebViewDelegate>
{
    UIButton *backUser;
}
@end

@implementation BMWebController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.frame = CGRectMake(0, 44, 320, 380);
        self.type = [NSString string];
        self.webView.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.title = @"充值";

    _webView.scrollView.contentOffset = CGPointMake(0, 44);
    _model = [BMCommon sharedBMCommon].model;
    
    NSLog(@"web %@",[BMCommon sharedBMCommon].model);
//    // 5.监听通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(collectChange) name:kCollectChangeNote object:nil];
}
#pragma mark 收藏


#pragma mark 收藏状态改变
- (void)collectChange
{
    [[TGCollectTool sharedTGCollectTool] handleDeal:_model];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.type = [BMCommon sharedBMCommon].type;
    if ( [self.type isEqualToString:@"Lottory"]) {
        self.title = @"彩票";
    }else if([self.type isEqualToString:@"Charge"]){
        self.title = @"充值";
    }else
    {
    
        // 3.添加回到用户位置的按钮
        backUser = [UIButton buttonWithType:UIButtonTypeCustom];
        backUser.tag = 0;
        UIImage *image = [UIImage imageNamed:@"GLIP簇－未收藏"];
        [backUser setBackgroundImage:image forState:UIControlStateNormal];
        [backUser setBackgroundImage:[UIImage imageNamed:@"GLIP簇－未收藏"] forState:UIControlStateNormal];
        backUser.layer.cornerRadius = 5.0;
        backUser.clipsToBounds = YES;
        CGFloat w = 44;
        CGFloat h = 44;
        CGFloat margin = 20;
        CGFloat x = self.view.frame.size.width - w - margin ;
        CGFloat y = self.view.frame.size.height - h - margin -35;
        backUser.frame = CGRectMake(x, y, w, h);
        backUser.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
        [backUser addTarget:self action:@selector(myLocation:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:backUser];
    }
//    _webView.scrollView.contentOffset = CGPointMake(0, 44);
    _model = [BMCommon sharedBMCommon].model;
    
    NSLog(@"web %@",[BMCommon sharedBMCommon].model);

}
- (void)myLocation:(UIButton *)obj
{
    
    NSLog(@"Common  %@",[BMCommon sharedBMCommon].model);
    self.model = [BMCommon sharedBMCommon].model;
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kCollectChangeNote object:nil];
    if (obj.tag == 0)
    {
    UIImage *image = [UIImage imageNamed:@"GLIP簇－已收藏"];
    [backUser setBackgroundImage:image forState:UIControlStateNormal];
    [[TGCollectTool sharedTGCollectTool] collectDeal:_model];

    }else{
        UIImage *image = [UIImage imageNamed:@"GLIP簇－未收藏"];
        [backUser setBackgroundImage:image forState:UIControlStateNormal];
        [[TGCollectTool sharedTGCollectTool] uncollectDeal:_model];

    }
    obj.tag = ! obj.tag;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.type = [BMCommon sharedBMCommon].type;
    if ( [self.type isEqualToString:@"Lottory"]) {
        self.title = @"彩票";
    }else if([self.type isEqualToString:@"Charge"]){
        self.title = @"充值";
    }
  //  _webView.scrollView.contentOffset = CGPointMake(0, 44);

}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//    webView.scrollView.contentOffset = CGPointMake(0, 60);

    if (![[request.URL absoluteString] hasPrefix:kHomeURL]) {
        return  YES;
    }
    [self.navigationController popViewControllerAnimated:YES];
    return  NO;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [SVProgressHUD showWithStatus:@"加载中"];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
