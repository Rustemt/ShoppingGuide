//
//  BMCategoryListController.m
//  KouDaiShopping
//
//  Created by admin on 14-6-14.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import "BMCategoryListController.h"
#import "BMCollectCell.h"
#import "BMCommon.h"
#import "JDClient.h"
#import "JOSPublicDefine.h"
#import "BMCategoryModel.h"
#import "UIImageView+WebCache.h"
#import "BMSelectModle.h"
#import "BMCateProModle.h"
#import "BMCommon.h"
#import "BMWebController.h"

#define kSecKill @"http://m.jd.com/product/1076285251.html?resourceType=index_floor&resourceValue=m197"


@interface BMCategoryListController ()<UICollectionViewDataSource,UICollectionViewDelegate,JDRequestDelegate>
{
    UICollectionView *_myCollectionView;
    JDClient   *jdClient;
    NSMutableArray    *m_dataSource;
    int        currentLevel;
    BOOL       showProduct;

}
@property (nonatomic,strong) BMWebController *webController;


@end

@implementation BMCategoryListController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        m_dataSource = [[NSMutableArray alloc] init];
        currentLevel = 1;

        // Custom initialization
        self.title = [BMCommon sharedBMCommon].type;
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.itemSize = CGSizeMake(103, 103);
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 4, 5, 4);
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

        jdClient = [[JDClient alloc] initWithAppId:JD_APP_KEY appSecret:JD_APP_SECRET];
        [jdClient setSandboxMode:NO];
        
        NSString *cid = [BMCommon sharedBMCommon].cid;
        [self getAllCategoryList:cid    nextLevel:@"0"];

    }
    return self;
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
- (void)getProductByCategoryName:(NSString *)cid{
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    //三级类目编号
    [paramsDic setObject:cid forKey:@"catelogyId"];
    //页码
    [paramsDic setObject:@"1" forKey:@"page"];
    //分页大小
    [paramsDic setObject:@"30" forKey:@"pageSize"];
    //客户端类型(apple、iPad、android、m、wp、wp7、Symbian、qt、androidTv、win8、android、Pad)
    [paramsDic setObject:@"apple" forKey:@"client"];
    [jdClient requestWithMethodName:@"jingdong.ware.promotion.search.catelogy.list" andParams:paramsDic andHttpMethod:@"POST" andDelegate:self];
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
    
    
    BMCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BMCollectCell" forIndexPath:indexPath];
    NSObject *obj = m_dataSource[indexPath.row];
    
    if ([obj isKindOfClass:[BMCategoryModel class]]) {
    
        BMCategoryModel *model = m_dataSource[indexPath.row];
        NSURL *url = [NSURL URLWithString:model.icon];
        [cell.imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"temaihui"]];
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
        cell.title.text = model.name;

    }
    if ([obj isKindOfClass:[BMSelectModle class]]) {
        BMSelectModle *model = m_dataSource[indexPath.row];
        NSURL *url = [NSURL URLWithString:model.imageurl];
        [cell.imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"temaihui"]];
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
        cell.title.text = model.wareName;
    }
    if ([obj isKindOfClass:[BMCateProModle class]]) {
        BMCateProModle *model = m_dataSource[indexPath.row];
        NSURL *url = [NSURL URLWithString:model.imageUrl];
        [cell.imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"temaihui"]];
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
        cell.title.text = model.wareName;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"select");
    NSObject *obj = m_dataSource[indexPath.row];
    if ([obj isKindOfClass:[BMCateProModle class]]) {
        BMCateProModle *model = m_dataSource[indexPath.row];
        _webController = [[BMWebController alloc]init];
        [BMCommon sharedBMCommon].type = @"";
        [_webController.view setFrame:self.view.frame];
        _webController.view.backgroundColor = [UIColor grayColor];
        _webController.webView.scalesPageToFit = YES;
        NSString *urlstr = kSecKill;
        NSString *VidStr = [NSString stringWithFormat:@"%@",model.skuId];
        urlstr = [urlstr stringByReplacingOccurrencesOfString:@"1076285251" withString:VidStr];
        NSURL *url =[NSURL URLWithString:urlstr];
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        [_webController.webView loadRequest:request];
        [self.navigationController pushViewController:_webController animated:YES];
        return ;

    }
    NSDictionary *rowData = [m_dataSource objectAtIndex:indexPath.row];
    if (showProduct) {
        NSString *detailUrl = [NSString stringWithFormat:@"http://m.jd.com/product/%@.html", [rowData objectForKey:@"skuId"]];
        NSURL *url = [[NSURL alloc] initWithString:detailUrl];
        [[UIApplication sharedApplication] openURL:url];
    } else {
        BMCategoryModel *model = m_dataSource[indexPath.row];
        if (model.cdescription) {
            currentLevel++;
            [self getAllCategoryList:model.cid nextLevel:[NSString stringWithFormat:@"%d", currentLevel]];
        } else  if(model.cid){
            [self getProductByCategoryName:model.cid];
        }else
        {
            ;
        }
    }
}

//解析返回结果
-(void)parseResponseResult:(NSDictionary *)response{
    NSArray *allKeys = [response allKeys];
    if ([allKeys count] <= 0) {
        return;
    }
    showProduct = NO;
    NSMutableArray *resultArray = nil;
    NSString *requestMethod = [allKeys objectAtIndex:0];
    NSMutableDictionary *responseDic = [response objectForKey:requestMethod];
    //获取所有类目请求结果
    if ([requestMethod isEqualToString:@"jingdong_ware_product_catelogy_list_get_responce"]) {
        NSMutableDictionary *productCatelogyDic = [responseDic objectForKey:@"productCatelogyList"];
        resultArray = [productCatelogyDic objectForKey:@"catelogyList"];

    } else if([requestMethod isEqualToString:@"jingdong_ware_promotion_search_catelogy_list_responce"]){
        NSMutableDictionary *productDic = [responseDic objectForKey:@"searchCatelogyList"];
        resultArray = [productDic objectForKey:@"wareInfo"];
        showProduct = YES;
    }
    
    if (resultArray && [resultArray count] > 0) {
        NSLog(@"parseResponseResult %d",[resultArray count]);
        [m_dataSource removeAllObjects];
//        [m_dataSource addObjectsFromArray:resultArray];
        for (int i = 0; i < resultArray.count && !showProduct ; i ++) {
            NSDictionary *dict = resultArray[i];
            BMCategoryModel *model = [BMCategoryModel initWithDict:dict];
            [m_dataSource addObject:model];
        }
        
        for (int i = 0; i < resultArray.count && showProduct ; i ++) {
            NSDictionary *dict = resultArray[i];
            BMCateProModle *model = [BMCateProModle initWithDict:dict];
            [m_dataSource addObject:model];
        }
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
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
