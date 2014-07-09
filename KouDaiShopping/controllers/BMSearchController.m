//
//  BMSearchController.m
//  KouDaiShopping
//
//  Created by admin on 14-5-6.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import "BMSearchController.h"
#import "BMCollectCell.h"
#import "JDClient.h"
#import "JOSPublicDefine.h"
#import "UIImageView+WebCache.h"
#import "BMWebController.h"
#import "BMCommon.h"
#import "BMSecKillModel.h"

#define kSecKill @"http://m.jd.com/product/1076285251.html?resourceType=index_floor&resourceValue=m197"

@interface BMSearchController ()<UISearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegate,JDRequestDelegate>
{
    UISearchBar *_searchBar;
    UICollectionView *_myCollectionView;
    JDClient   *jdClient;
    NSMutableArray    *m_dataSource;
}
@property (nonatomic,strong) BMWebController *webController;

@end

@implementation BMSearchController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"搜索";
//        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,44)];
//        _searchBar.delegate = self;
//        _searchBar.showsCancelButton = NO;
//        _searchBar.barTintColor = [UIColor greenColor];
//        _searchBar.placeholder = @"请输入宝贝关键字                               ";
//        self.navigationItem.titleView = _searchBar;
//        self.view.backgroundColor = [UIColor lightGrayColor];
//        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.itemSize = CGSizeMake(105, 105);
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 1, 5, 1);
        flowLayout.minimumInteritemSpacing = 1;
        flowLayout.minimumLineSpacing = 1;
        
        _myCollectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _myCollectionView.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
        _myCollectionView.dataSource = self;
        _myCollectionView.delegate = self;
        _myCollectionView.showsHorizontalScrollIndicator = YES;
        
        
      [_myCollectionView registerNib:[UINib nibWithNibName:@"BMCollectCell" bundle:nil] forCellWithReuseIdentifier:@"BMCollectCell"];
     _myCollectionView.alwaysBounceVertical = YES;

        [self.view addSubview:_myCollectionView];

    }
    return self;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return m_dataSource.count;
}


// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
//    IKEDMyOwnImgView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IKeD" forIndexPath:indexPath];
//    
//    NSDictionary *dic = [collectionImageData objectAtIndex:[indexPath row]];
//    
//    
//    [cell setImg:[UIImage imageNamed:[dic objectForKey:@"pic"]]];
//    [cell setTitle:[dic objectForKey:@"title"]];
//
    NSDictionary *dict = m_dataSource[indexPath.row];
    BMCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BMCollectCell" forIndexPath:indexPath];
    cell.title.text = dict[@"wareName"];
    NSURL *url = [NSURL URLWithString:dict[@"imageUrl"]];
    [cell.imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"temaihui"]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"select");
    _webController = [[BMWebController alloc]init];
    [BMCommon sharedBMCommon].type = @"";
    [_webController.view setFrame:self.view.frame];
    _webController.view.backgroundColor = [UIColor grayColor];
    _webController.webView.scalesPageToFit = YES;
    NSString *urlstr = kSecKill;
    NSDictionary *dict = m_dataSource[indexPath.row];
    NSString *skuId = dict[@"skuId"];
    NSString *VidStr = [NSString stringWithFormat:@"%@",skuId];
    urlstr = [urlstr stringByReplacingOccurrencesOfString:@"1076285251" withString:VidStr];
    NSURL *url =[NSURL URLWithString:urlstr];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [_webController.webView loadRequest:request];
    [self.navigationController pushViewController:_webController animated:YES];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // /        NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    //商品条形码
    NSString *keyword  = [BMCommon sharedBMCommon].keyword;
    m_dataSource = [[NSMutableArray alloc] init];
    jdClient = [[JDClient alloc] initWithAppId:JD_APP_KEY appSecret:JD_APP_SECRET];
    [jdClient setSandboxMode:NO];
    

    //        [paramsDic setObject:keyword forKey:@"keyword"];
    //        //客户端类型(apple、iPad、android、m、wp、wp7、Symbian、qt、androidTv、win8、android、Pad)
    //        [paramsDic setObject:@"apple" forKey:@"client"];
    [self getProductByKeyword:keyword];
    

}

- (void)getProductByKeyword:(NSString *)keyword{
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    //是否加载评星，true为加载，false为不加载
    [paramsDic setObject:@"true" forKey:@"isLoadAverageScore"];
    //是否加载促销，true为加载，false为不加载
    [paramsDic setObject:@"true" forKey:@"isLoadPromotion"];
    //1:销量排序 2:价格降序 3:价格升序 4:好评度 6:评论数
    [paramsDic setObject:@"1" forKey:@"sort"];
    //页码
    [paramsDic setObject:@"1" forKey:@"page"];
    //分页大小
    [paramsDic setObject:@"30" forKey:@"pageSize"];
    //关键词
    [paramsDic setObject:keyword forKey:@"keyword"];
    //客户端类型(apple、iPad、android、m、wp、wp7、Symbian、qt、androidTv、win8、android、Pad)
    [paramsDic setObject:@"apple" forKey:@"client"];
    [jdClient requestWithMethodName:@"jingdong.ware.product.search.list.get" andParams:paramsDic andHttpMethod:@"POST" andDelegate:self];
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
    
    if ([requestMethod isEqualToString:@"jingdong_ware_search_hotkeywords_list_get_responce"]) {
        NSMutableDictionary *keyDic = [responseDic objectForKey:@"hotKeyWord"];
        resultArray = [keyDic objectForKey:@"keyWords"];
    } else if([requestMethod isEqualToString:@"jingdong_ware_product_search_list_get_responce"]){
        NSMutableDictionary *keyDic = [responseDic objectForKey:@"searchProductList"];
        resultArray = [keyDic objectForKey:@"wareInfo"];
    } else if ([requestMethod isEqualToString:@"jingdong_ware_barcode_get_responce"]){
        NSMutableDictionary *channelDic = [responseDic objectForKey:@"channelList"];
        resultArray = [channelDic objectForKey:@"wareInfoList"];
    }
    if (resultArray && [resultArray count] > 0) {
        NSLog(@"parseResponseResult %lu",(unsigned long)[resultArray count]);
        [m_dataSource removeAllObjects];
        [m_dataSource addObjectsFromArray:resultArray];
        [_myCollectionView reloadData];
    }
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
