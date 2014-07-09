//
//  BMHomeController.m
//  KouDaiShopping
//
//  Created by skyming on 14-5-6.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import "BMHomeController.h"
#import "BMAdScrollView.h"
#import "BMDefineUtils.h"
#import "BMMyButton.h"
#import "SVProgressHUD.h"
#import "BMmyCell.h"
#import "BMCategory.h"
#import "BMCateCell.h"
#import "BMeveryTenCell.h"
#import "BMFavCell.h"
#import "BMPromoteController.h"
#import "BMTemaiController.h"
#import "BMCollectController.h"
#import "BMTemaiController.h"
#import "BMWebController.h"
#import "BMCommon.h"
#import "JDClient.h"
#import "JOSPublicDefine.h"
#import "BMSecKillModel.h"
#import "AFNetworkReachabilityManager.h"
#import "UIButton+WebCache.h"
#import "BMSecKillController.h"
#import "BMStrollManController.h"
#import "BMStrollWomenController.h"
#import "BMSelectController.h"
#import "BMCategoryModel.h"
#import "UIImageView+WebCache.h"
#import "DPRequest.h"
#import "DPAPI.h"
#import "BMCategoryListController.h"
#import "BMCommonDefines.h"
#import "BMMyFavController.h"
#import "BMMyDynmicController.h"
#import "BMShopController.h"
#import "BMAlumController.h"
#import "BMSearchBarController.h"
#import "BMSearchController.h"

@interface BMHomeController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,ValueClickDelegate,BMTenDelegate,JDRequestDelegate,BMShopDelegate,DPRequestDelegate>
{
    UISearchBar *_searchBar;
    NSMutableArray *cArray;
    NSMutableArray *adImageArray;
    NSMutableArray *adTitleArray;
    NSMutableArray *adModels;
    JDClient   *jdClient;
    JDClient   *jdClientCat;
    DPRequest *ShopReq;
    NSMutableArray    *m_dataSource;
    NSMutableArray    *m_dataSourceList;

    UIView *headerView;
    AFNetworkReachabilityManager *reachMgr;
//    UITableView       *m_tableView;
}
@property (strong, nonatomic)  UITableView *myTalbeView;
@property (nonatomic,strong) BMWebController *webController;

@end

@implementation BMHomeController

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
    
    self.title = @"我的街";
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,44)];
    _searchBar.delegate = self;
    _searchBar.showsCancelButton = YES;
//    _searchBar.barTintColor = [UIColor greenColor];
    
    _searchBar.placeholder = @"请输入宝贝关键字                               ";
    self.navigationItem.titleView = _searchBar;

    CGRect rect = CGRectMake(0, 66, self.view.frame.size.width, self.view.frame.size.height -110);
    _myTalbeView = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
    self.myTalbeView.dataSource = self;
    self.myTalbeView.delegate = self;
    self.myTalbeView.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [self.view addSubview:_myTalbeView];
    
    NSMutableArray *arr=[[NSMutableArray alloc]initWithObjects:@"image1.jpg",@"image2.jpg",@"image3.jpg", nil];
    //设置标题数组
    NSMutableArray *strArr = [[NSMutableArray alloc]initWithObjects:@"1:我们是一支可以撼动世界的力量",@"2:向前冲吧，小伙伴们", @"3:再不会为任何理由停下脚步",nil];
    adImageArray = [NSMutableArray arrayWithArray:arr];
    adTitleArray = [NSMutableArray arrayWithArray:strArr];
    adModels = [NSMutableArray array];
    LOGRECT(self.view.frame);
    
    CGRect hRect = CGRectMake(0, 66, 320, 225);
    headerView = [[UIView alloc]initWithFrame:hRect];
    headerView.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];

//    [self initAdView];
    BMMyButton *checkBtn = [[BMMyButton alloc]initWithFrame:CGRectMake(0, 180, 106, 40)];
    checkBtn.backgroundColor = [UIColor whiteColor];
    [checkBtn setTitle:@"签到" Image:@"GLPad_qiandao_icon_normal"];
    checkBtn.tag = kCheck;
    [checkBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:checkBtn];
    
    BMMyButton *mCharge = [[BMMyButton alloc]initWithFrame:CGRectMake(107, 180, 106, 40)];
    mCharge.backgroundColor = [UIColor whiteColor];
    [mCharge setTitle:@"充值" Image:@"GLPad_chongzhi_icon_normal"];
    mCharge.tag = kCharge;
    [mCharge addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:mCharge];
    
    BMMyButton *lottery = [[BMMyButton alloc]initWithFrame:CGRectMake(214, 180, 106, 40)];
    lottery.backgroundColor = [UIColor whiteColor];
    [lottery setTitle:@"彩票" Image:@"GLPad_caipiao_icon_normal"];
    lottery.tag = kLottery;
    [lottery addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIView *adBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 220, kScreen_Width, 5)];
//    adBackView.backgroundColor = [UIColor lightGrayColor];
    [headerView addSubview:adBackView];
    [headerView addSubview:lottery];
    _myTalbeView.tableHeaderView = headerView;
    
    [_myTalbeView registerNib:[UINib nibWithNibName:@"BMmyCell" bundle:nil] forCellReuseIdentifier:@"BMmyCell"];
    [_myTalbeView registerNib:[UINib nibWithNibName:@"BMeveryTenCell" bundle:nil] forCellReuseIdentifier:@"BMeveryTenCell"];
    [_myTalbeView registerNib:[UINib nibWithNibName:@"BMFavCell" bundle:nil] forCellReuseIdentifier:@"BMFavCell"];
    
    cArray = [NSMutableArray array];
    BMCategory *model = [BMCategory initWithTitle:@"今日特卖" Color:[UIColor orangeColor]];
    [cArray addObject:model];
    model = [BMCategory initWithTitle:@"我的街" Color:[UIColor redColor]];
    [cArray addObject:model];
    model = [BMCategory initWithTitle:@"编辑推荐" Color: [UIColor orangeColor]];
    [cArray addObject:model];
    model = [BMCategory initWithTitle:@"精选商家" Color:[UIColor greenColor]];
    model.isCollect = YES;
    [cArray addObject:model];
    
    m_dataSource = [[NSMutableArray alloc] init];
    m_dataSourceList = [[NSMutableArray alloc] init];
    
    jdClient = [[JDClient alloc] initWithAppId:JD_APP_KEY appSecret:JD_APP_SECRET];
    [jdClient setSandboxMode:NO];
    
    jdClientCat = [[JDClient alloc]initWithAppId:JD_APP_KEY appSecret:JD_APP_SECRET];
    [jdClientCat setSandboxMode:NO];
    [self getAllCategoryList:@"0" nextLevel:@"0"];

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    //客户端类型(apple、iPad、android、m、wp、wp7、Symbian、qt、androidTv、win8、android、Pad)
    [paramsDic setObject:@"apple" forKey:@"client"];
    
    [jdClient requestWithMethodName:@"jingdong.ware.promotion.seckill.list.get" andParams:paramsDic andHttpMethod:@"POST" andDelegate:self];
    
    
    
    [SVProgressHUD dismiss];
    
    DPAPI *api = [DPAPI sharedDPAPI];
    /*
     1.请求成功会调用self的下面方法
     - (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
     
     2.请求失败会调用self的下面方法
     - (void)request:(DPRequest *)request didFailWithError:(NSError *)error
     */
    NSString *url = @"http://api.dianping.com/v1/business/find_businesses";
    
    ShopReq = [api requestWithURL:url params:nil delegate:self];

    reachMgr = [AFNetworkReachabilityManager sharedManager];
    [reachMgr startMonitoring];
    [reachMgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusUnknown || status == AFNetworkReachabilityStatusNotReachable) {
            [SVProgressHUD showErrorWithStatus:@"网络中断"];
        }
    }];
    
}

- (void) getAllCategoryList:(NSString *)categoryId nextLevel:(NSString *)level{
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    //类目编号
    [paramsDic setObject:categoryId forKey:@"catelogyId"];
    //客户端类型(apple、iPad、android、m、wp、wp7、Symbian、qt、androidTv、win8、android、Pad)
    [paramsDic setObject:@"apple" forKey:@"client"];
    //是否加载下级描述
    [paramsDic setObject:@"true" forKey:@"isDescription"];
    //是否加载下级图标
    [paramsDic setObject:@"true" forKey:@"isIcon"];
    //类目分类
    [paramsDic setObject:level forKey:@"level"];
    [jdClient requestWithMethodName:@"jingdong.ware.product.catelogy.list.get" andParams:paramsDic andHttpMethod:@"POST" andDelegate:self];
}

- (void)initAdView
{
    BMAdScrollView *adView = [[BMAdScrollView alloc] initWithNameArr:adImageArray  titleArr:adTitleArray height:180.0f offsetY:0];
    adView.vDelegate = self;
    adView.pageCenter = CGPointMake(155, 140);
    //    [self.view addSubview:adView];
    
    [headerView addSubview:adView];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  cArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return 2;
    }if (section == 1) {
        return  5;
    }
    return 4;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 44.0;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;   // custom view for header. will be adjusted to default or specified header height
//{
//    BMCategory *model = cArray[section];
//    UITableViewHeaderFooterView *sectionHead = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"SectionHeader"];
//    sectionHead.contentView.backgroundColor = [UIColor whiteColor];
////    sectionHead.textLabel.text = @"特色品牌";
//    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(18, 0, 280, 42)];
//    title.font = [UIFont boldSystemFontOfSize:14];
//
//    title.text = model.title;
//    [sectionHead addSubview:title];
//    UIView *side = [[UIView alloc]initWithFrame:CGRectMake(8, 14, 6, 15)];
//    side.backgroundColor = model.color;
//    [sectionHead addSubview:side];
//    
//    UIView *bottom = [[UIView alloc]initWithFrame:CGRectMake(0, 43, 320, 1)];
//    bottom.backgroundColor = [UIColor colorWithWhite:0.667 alpha:1.000];
//    [sectionHead addSubview:bottom];
//    return sectionHead;
//}
// 后调用
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"我的街";
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BMmyCell";
    static NSString *CateCell = @"CateCell";
    
    BMCategory *model = cArray[indexPath.section];
    if (indexPath.row == 0 ) {
        BMCateCell *cell  = [tableView dequeueReusableCellWithIdentifier:CateCell];
        if (cell == nil) {
            cell = [[BMCateCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CateCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = model;
        return  cell;
    }
    
    if (indexPath.section == 0) {
        BMeveryTenCell *cell = (BMeveryTenCell *)[tableView dequeueReusableCellWithIdentifier:@"BMeveryTenCell"];
        if (!cell) {
            cell = [[BMeveryTenCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BMeveryTenCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.tDelegate = self;
        NSURL *url = [NSURL URLWithString:kMoblePro];
        [cell.moblePro setImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"image1"]];
        [cell.moblePro setBackgroundImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"image1"]];
        
        url = [NSURL URLWithString:kSecKillPro];
        [cell.secKillPro setImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"iamge1"]];
        [cell.secKillPro setBackgroundImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"image1"]];
        
        url = [NSURL URLWithString:kSelectionPro];
        [cell.selectionPro setImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"image1"]];
        [cell.selectionPro setBackgroundImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"image1"]];
        
        url = [NSURL URLWithString:kCouponPro];
        [cell.couponPro setImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"iamge1"]];
        [cell.couponPro setBackgroundImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"iamge1"]];
        
        return cell;
    }
    if (indexPath.section == 1) {
        BMFavCell *cell = (BMFavCell *)[tableView dequeueReusableCellWithIdentifier:@"BMFavCell"];
        if (indexPath.row >= m_dataSourceList.count) {
            return cell;
        }
        BMCategoryModel *model = [BMCategoryModel initWithDict:m_dataSourceList[indexPath.row]];
        if (!cell) {
            cell = [[BMFavCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BMFavCell"];
        }
        
        if (model != nil && model.name) {
            cell.name.text = model.name;
        }
        if (model != nil && model.cdescription) {
            cell.deatilDesc.text = model.cdescription;
        }
        NSURL *url = [NSURL URLWithString:model.icon];
        [cell.imageurl setImageWithURL:url placeholderImage:[UIImage imageNamed:@"nanrenzhuang"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }
    
    if (indexPath.section == 2) {
        BMFavCell *cell = (BMFavCell *)[tableView dequeueReusableCellWithIdentifier:@"BMFavCell"];
        if (indexPath.row >= m_dataSourceList.count) {
            return cell;
        }
        NSUInteger key = m_dataSourceList.count - indexPath.row;
        BMCategoryModel *model = [BMCategoryModel initWithDict:m_dataSourceList[key]];
        if (!cell) {
            cell = [[BMFavCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BMFavCell"];
        }
        
        if (model != nil && model.name) {
            cell.name.text = model.name;
        }
        if (model != nil && model.cdescription) {
            cell.deatilDesc.text = model.cdescription;
        }
        NSURL *url = [NSURL URLWithString:model.icon];
        [cell.imageurl setImageWithURL:url placeholderImage:[UIImage imageNamed:@"nanrenzhuang"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }

    BMmyCell *cell = (BMmyCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.shopDelegate = self;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return kCateHeight;
    }
    if (indexPath.section == 0) {
        return 162.0;
    }
    if (indexPath.section == 3) {
        return 180;
    }
    return kCellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Select %d" ,indexPath.section);
    if (indexPath.section == 1) {
        
        BMCategoryModel *model = [BMCategoryModel initWithDict:m_dataSourceList[indexPath.row]];

        [BMCommon sharedBMCommon].type = model.name;
        [BMCommon sharedBMCommon].cid = model.cid;
        BMCategoryListController *cate = [[ BMCategoryListController alloc]init];
        [self.navigationController pushViewController:cate animated:YES];
        return;
    }
    if ( indexPath.section == 2) {
        
        NSUInteger key = 0;
        key = m_dataSourceList.count  - indexPath.row;
        BMCategoryModel *model = [BMCategoryModel initWithDict:m_dataSourceList[key]];
        
        [BMCommon sharedBMCommon].type = model.name;
        [BMCommon sharedBMCommon].cid = model.cid;
        BMCategoryListController *cate = [[ BMCategoryListController alloc]init];
        [self.navigationController pushViewController:cate animated:YES];
        return;
    }

    if (indexPath.section == 1) {
        NSArray *titleArray = [NSArray arrayWithObjects:@"全部",@"棉衣",@"夹克",@"衬衫", nil];
        
        NSMutableArray *controllerArray = [[NSMutableArray alloc]init];
        
        for (NSString* title in titleArray)
        {
            UIViewController *vc = [[UIViewController alloc]init];
            if ([title isEqualToString:@"全部"]) {
                vc = [[BMTemaiController alloc]init];
            }else if([title isEqualToString:@"棉衣"])
            {
                vc = [[BMTemaiController alloc]init];
            }else if([title isEqualToString:@"夹克"])
            {
                vc = [[BMTemaiController alloc]init];
            }else if([title isEqualToString:@"衬衫"])
            {
                vc = [[BMTemaiController alloc]init];
            }
            int r = rand() % 255;
            int b = rand() % 255;
            vc.view.backgroundColor = RGBCOLOR(r,255, b);
            
            //        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 320, 44)];
            //        [vc.view addSubview:label];
            //        label.text = [title stringByAppendingString:@" View Controller"];
            
            [controllerArray addObject:vc];
        }
        
        BMCollectController *myStreet = [[ BMCollectController alloc]init];
        [self.navigationController pushViewController:myStreet animated:YES];
    }
}
- (void)clickTen:(UIButton *)btn
{
    switch (btn.tag) {
        case kFirst:
            NSLog(@"1");
            {
                BMPromoteController *pro = [[BMPromoteController alloc]init];
                self.navigationItem.backBarButtonItem.title = @"";
                [self.navigationController pushViewController:pro animated:YES];
            }
            break;
        case kSecond:
            NSLog(@"2");
            {
                BMSecKillController *prot = [[BMSecKillController alloc]init];
                [self.navigationController pushViewController:prot animated:YES];
            }
            break;
        case kThird:
            NSLog(@"3");
            {
                BMSelectController *prot = [[BMSelectController alloc]init];
                [BMCommon sharedBMCommon].type = @"优惠精选";
                [self.navigationController pushViewController:prot animated:YES];
            }

            break;
        case kFour:
            NSLog(@"4");
            {
                BMSelectController *prot = [[BMSelectController alloc]init];
                [BMCommon sharedBMCommon].type = @"特卖精选";
                [self.navigationController pushViewController:prot animated:YES];
            }
            break;
            
        default:
            break;
    }

}
- (void)btnClick:(BMMyButton*)btn
{
    switch (btn.tag) {
        case kCheck:
            NSLog(@"Check");
            [SVProgressHUD showSuccessWithStatus:@"签到成功"];
            break;
        case kCharge:
            NSLog(@"Charge");
        {
            _webController = [[BMWebController alloc]init];
//            _webController.view.frame = CGRectMake(0, 44, 320, 380);
            _webController.view.backgroundColor = [UIColor grayColor];
            [BMCommon sharedBMCommon].type = @"Charge";
            _webController.webView.scalesPageToFit = YES;
            NSURL *url =[NSURL URLWithString:kChargeURL];
            NSURLRequest *request =[NSURLRequest requestWithURL:url];
            [_webController.webView loadRequest:request];
            [self.navigationController pushViewController:_webController animated:YES];
        }

            break;
        case kLottery:
            NSLog(@"Lottory");
            _webController = [[BMWebController alloc]init];
            [BMCommon sharedBMCommon].type = @"Lottory";
            [_webController.view setFrame:self.view.frame];
            _webController.view.backgroundColor = [UIColor grayColor];
            _webController.webView.scalesPageToFit = YES;
            NSURL *url =[NSURL URLWithString:kLotteryURL];
            NSURLRequest *request =[NSURLRequest requestWithURL:url];
            [_webController.webView loadRequest:request];
            [self.navigationController pushViewController:_webController animated:YES];
            

            break;
            
    }
}
- (void)buttonClick:(int)vid
{
    NSLog(@"AD -- %d",vid);
    _webController = [[BMWebController alloc]init];
    [BMCommon sharedBMCommon].type = @"";
    [_webController.view setFrame:self.view.frame];
    _webController.view.backgroundColor = [UIColor grayColor];
    _webController.webView.scalesPageToFit = YES;
    NSString *urlstr = kSecKill;
    BMSecKillModel *model = adModels[vid - 1];
    [BMCommon sharedBMCommon].model = model;
    NSLog(@"Common  %@",[BMCommon sharedBMCommon].model);

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
    } else  if ([requestMethod isEqualToString:@"jingdong_ware_product_catelogy_list_get_responce"]) {
        NSMutableDictionary *productCatelogyDic = [responseDic objectForKey:@"productCatelogyList"];
        resultArray = [productCatelogyDic objectForKey:@"catelogyList"];
        NSLog(@"Cate  %@",resultArray);
        [m_dataSourceList removeAllObjects];
        if (resultArray && [resultArray count] > 0) {
            NSLog(@"parseResponseResult %d",[resultArray count]);
            [m_dataSourceList addObjectsFromArray:resultArray];
        }
        
    }
    if (![requestMethod isEqualToString:@"jingdong_ware_product_catelogy_list_get_responce"]) {
        [m_dataSource removeAllObjects];
        if (resultArray && [resultArray count] > 0) {
            NSLog(@"parseResponseResult %d",[resultArray count]);
            [m_dataSource addObjectsFromArray:resultArray];
        }
        
        NSLog(@"Result -- %d",m_dataSource.count);
        [adImageArray removeAllObjects];
        [adTitleArray removeAllObjects];
        [adModels removeAllObjects];
        for (int i = 0; i < 5 && m_dataSource.count >= 5; i ++) {
            NSDictionary *dict = m_dataSource[i];
            
            BMSecKillModel *model = [BMSecKillModel initWithDict:dict];
            
            [adImageArray addObject:model.imageurl];
            [adTitleArray addObject:model.wareName];
            [adModels addObject:model];
        }
        [self initAdView];
    }

    [SVProgressHUD dismiss];
//    [m_tableView reloadData];
}

#pragma mark - JDRequestDelegate 代理方法
- (void)request:(JDRequest *)request didLoad:(id)result{
  //  NSLog(@"Request result is  %@",result);
    if ([result isKindOfClass:[NSDictionary class]]) {
        [self parseResponseResult:result];
    }
}

//接收服务器返回数据回调函数
- (void)request:(JDRequest *)request didDidReceiveData:(NSData *)data{
    //    NSLog(@"data is %@",data);
}

//请求错误回调函数
- (void)request:(id )request didFailWithError:(NSError *)error{
    
    NSLog(@"\n\n%@",request);
    NSLog(@"error is %@",[error localizedDescription]);
    
    [SVProgressHUD showErrorWithStatus:@"加载失败"];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [SVProgressHUD dismiss];
    [reachMgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusUnknown || status == AFNetworkReachabilityStatusNotReachable) {
            [SVProgressHUD showErrorWithStatus:@"网络中断"];
        }
    }];
}
- (void)ShopClick:(UIButton *)btn{
    NSLog(@"shopcellClick --- OK %d",btn.tag);
    
}


- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    NSLog(@"Sucess  %@",result);
    
    
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
//    NSArray *titleArray = [NSArray arrayWithObjects:@"宝贝",@"动态",@"店铺",@"专辑", nil];
//    
//    NSMutableArray *controllerArray = [[NSMutableArray alloc]init];
//    
//    for (NSString* title in titleArray)
//    {
//        
//        UIViewController *vc = [[UIViewController alloc]init];
//        if ([title isEqualToString:@"宝贝"]) {
//            vc = [[BMMyFavController alloc]init];
//        }else if([title isEqualToString:@"动态"])
//        {
//            vc = [[BMMyDynmicController alloc]init];
//        }else if([title isEqualToString:@"店铺"])
//        {
//            vc = [[BMShopController alloc]init];
//        }else if([title isEqualToString:@"专辑"])
//        {
//            vc = [[BMAlumController alloc]init];
//        }
//        int r = rand() % 255;
//        int b = rand() % 255;
//        vc.view.backgroundColor = RGBCOLOR(r,255, b);
//        
//        [controllerArray addObject:vc];
//    }
//    BMSearchBarController *sBack = [[BMSearchBarController alloc]initWithItems:titleArray andControllers:controllerArray];
//    [self.navigationController pushViewController:sBack animated:YES];
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"Button click %@",searchBar.text);
    [BMCommon sharedBMCommon].keyword = searchBar.text;
    BMSearchController *search = [[BMSearchController alloc]init];
    [self.navigationController pushViewController:search animated:YES];
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    NSLog(@"Cancel click");
    [_searchBar resignFirstResponder];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [reachMgr stopMonitoring];
    [SVProgressHUD dismiss];
}
@end
