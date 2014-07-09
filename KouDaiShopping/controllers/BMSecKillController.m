//
//  BMSecKillController.m
//  KouDaiShopping
//
//  Created by admin on 14-6-8.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import "BMSecKillController.h"
#import "BMSecKillCell.h"
#import "JDClient.h"
#import "JOSPublicDefine.h"
#import "BMSecKillModel.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "BMWebController.h"
#import "BMCommon.h"

#define kPromoteCellHeight 245
#define kSecKill @"http://m.jd.com/product/1076285251.html?resourceType=index_floor&resourceValue=m197"

@interface BMSecKillController ()<UITableViewDelegate,UITableViewDataSource,JDRequestDelegate>
{
    JDClient   *jdClient;
    NSMutableArray    *m_dataSource;
}

@property (strong, nonatomic)  UITableView *myTalbeView;
@property (nonatomic,strong) BMWebController *webController;

@end

@implementation BMSecKillController

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
    // Do any additional setup after loading the view.
    //  self.navigationItem.rightBarButtonItem = self.editButtonItem;
    m_dataSource = [[NSMutableArray alloc] init];
	jdClient = [[JDClient alloc] initWithAppId:JD_APP_KEY appSecret:JD_APP_SECRET];
    [jdClient setSandboxMode:NO];
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    //客户端类型(apple、iPad、android、m、wp、wp7、Symbian、qt、androidTv、win8、android、Pad)
    [paramsDic setObject:@"apple" forKey:@"client"];
    [jdClient requestWithMethodName:@"jingdong.ware.promotion.seckill.list.get" andParams:paramsDic andHttpMethod:@"POST" andDelegate:self];
    
    
    
    self.title = @"秒杀专场";
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height -44);
    _myTalbeView = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
    self.myTalbeView.dataSource = self;
    self.myTalbeView.delegate = self;
    self.myTalbeView.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [self.view addSubview:_myTalbeView];
    [_myTalbeView registerNib:[UINib nibWithNibName:@"BMSecKillCell" bundle:nil] forCellReuseIdentifier:@"BMSecKillCell"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search)];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [SVProgressHUD showWithStatus:@"促销数据加载中"];
}

//解析返回结果
-(void)parseResponseResult:(NSDictionary *)response{
    NSArray *allKeys = [response allKeys];
    if ([allKeys count] <= 0) {
        return;
    }
    
    NSMutableArray *resultArray = nil;
    NSString *requestMethod = [allKeys objectAtIndex:0];
    NSMutableDictionary *responseDic = [response objectForKey:requestMethod];
    
    if([requestMethod isEqualToString:@"jingdong_ware_promotions_list_get_responce"]) {
        NSMutableDictionary *promotionDic = [responseDic objectForKey:@"cmsPromotionsList"];
        resultArray = [promotionDic objectForKey:@"cmsPromotionsAll"];
    } else if ([requestMethod isEqualToString:@"jingdong_ware_promotion_indexactivity_list_get_responce"]) {
        NSMutableDictionary *activityDic = [responseDic objectForKey:@"activityList"];
        resultArray = [activityDic objectForKey:@"activityList"];
    } else if ([requestMethod isEqualToString:@"jingdong_ware_promotion_seckill_list_get_responce"]) {
        NSMutableDictionary *fatherDic = [responseDic objectForKey:@"miaoShaFatherList"];
        resultArray = [fatherDic objectForKey:@"miaoShaList"];
    } else if ([requestMethod isEqualToString:@"jingdong_ware_promotion_activities_list_get_responce"]) {
        NSMutableDictionary *acDic = [responseDic objectForKey:@"cmsActivityList"];
        resultArray = [acDic objectForKey:@"cmsActivityList"];
    } else if ([requestMethod isEqualToString:@"jingdong_ware_promotions_catelogyidlist_get_responce"]) {
        NSMutableDictionary *cmsDic = [responseDic objectForKey:@"cmsPromotionsByCatelogyIdList"];
        resultArray = [cmsDic objectForKey:@"cmsPromotionsList"];
    } else if ([requestMethod isEqualToString:@"jingdong_ware_promotion_indexactivity_get_responce"]) {
        NSMutableDictionary *proDic = [responseDic objectForKey:@"activityProductsList"];
        resultArray = [proDic objectForKey:@"activityProducts"];
    } else if ([requestMethod isEqualToString:@"jingdong_ware_promotion_activityware_list_get_responce"]) {
        NSMutableDictionary *proDic = [responseDic objectForKey:@"cmsActivityWareList"];
        resultArray = [proDic objectForKey:@"cmsActivityWareList"];
    } else if ([requestMethod isEqualToString:@"jingdong_ware_selected_province_list_get_responce"]) {
        NSMutableDictionary *provinceDic = [responseDic objectForKey:@"provinceList"];
        resultArray = [provinceDic objectForKey:@"provinces"];
    } else if ([requestMethod isEqualToString:@"jingdong_ware_promotion_categoryware_list_get_responce"]) {
        NSMutableDictionary *wareDic = [responseDic objectForKey:@"wareInfoList"];
        resultArray = [wareDic objectForKey:@"wareInfoList"];
    }
    
    [m_dataSource removeAllObjects];
    if (resultArray && [resultArray count] > 0) {
        NSLog(@"parseResponseResult %d",[resultArray count]);
        
        for (NSDictionary *obj in resultArray) {
            BMSecKillModel *model = [BMSecKillModel initWithDict:obj];
            [m_dataSource addObject:model];
        }
    }
    
    [_myTalbeView reloadData];
    [SVProgressHUD dismiss];
}

#pragma mark - JDRequestDelegate 代理方法
- (void)request:(JDRequest *)request didLoad:(id)result{
    NSLog(@"result is %@",result);
    if ([result isKindOfClass:[NSDictionary class]]) {
        [self parseResponseResult:result];
    }
}

//接收服务器返回数据回调函数
- (void)request:(JDRequest *)request didDidReceiveData:(NSData *)data{
    //    NSLog(@"data is %@",data);
}

//请求错误回调函数
- (void)request:(JDRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"error is %@",error);
    [SVProgressHUD showErrorWithStatus:@"加载失败"];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return m_dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  kPromoteCellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMSecKillCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMSecKillCell" forIndexPath:indexPath];
    if (indexPath.row >= m_dataSource.count) {
        return  cell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BMSecKillModel *model = m_dataSource[indexPath.row];
    cell.wareName.text = model.wareName;
    NSURL *imageUrl = [NSURL URLWithString:model.imageurl];
    UIImage *image = [UIImage imageNamed:@"temaihui"];
    [cell.imageurl setImageWithURL:imageUrl placeholderImage:image];

    // Configure the cell...
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Did select");
    _webController = [[BMWebController alloc]init];
    [BMCommon sharedBMCommon].type = @"";
    [_webController.view setFrame:self.view.frame];
    _webController.view.backgroundColor = [UIColor grayColor];
    _webController.webView.scalesPageToFit = YES;
    NSString *urlstr = kSecKill;
    BMSecKillModel *model = m_dataSource[indexPath.row];
    NSString *VidStr = [NSString stringWithFormat:@"%@",model.skuId];
    urlstr = [urlstr stringByReplacingOccurrencesOfString:@"1076285251" withString:VidStr];
    NSURL *url =[NSURL URLWithString:urlstr];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [_webController.webView loadRequest:request];
    [self.navigationController pushViewController:_webController animated:YES];
    

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
