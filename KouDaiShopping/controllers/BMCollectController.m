//
//  BMCollectController.m
//  KouDaiShopping
//
//  Created by admin on 14-5-6.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import "BMCollectController.h"
#import "BMShopFavController.h"
#import "BMProductFavController.h"
#import "BMColloctBigCell.h"
#import "TGCollectTool.h"
#import "UIImageView+WebCache.h"

@interface BMCollectController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *_myCollectionView;
    NSArray *data;
    NSString *ctype;
}
@end

@implementation BMCollectController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"我的收藏";
        ctype = @"商品";
       self.view.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:nil];
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"分类" style:UIBarButtonItemStylePlain target:self action:nil];
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"settings_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(hardSetting)];
        data = @[@"1",@"2",@"3",@"4"];
        
        UISegmentedControl *back = [[UISegmentedControl alloc]initWithItems:@[@"商品",@"商户"]];
        [back addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
        back.selectedSegmentIndex = 0;
        back.frame = CGRectMake(0, 0, 160, 30);
        back.layer.cornerRadius = 5.0f;
//        back.layer.backgroundColor = (__bridge CGColorRef)([UIColor colorWithRed:0.223 green:0.555 blue:1.000 alpha:1.000]);
        self.navigationItem.titleView = back;
//        [self segmentChange:nil];
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.itemSize = CGSizeMake(155, 160);
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 3, 5, 3);
        flowLayout.minimumInteritemSpacing = 1;
        flowLayout.minimumLineSpacing = 1;
        
        _myCollectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _myCollectionView.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height - 44);
        _myCollectionView.backgroundColor =[UIColor colorWithWhite:0.902 alpha:1.000];

        _myCollectionView.dataSource = self;
        _myCollectionView.delegate = self;
        _myCollectionView.showsHorizontalScrollIndicator = YES;
        
        
        [_myCollectionView registerNib:[UINib nibWithNibName:@"BMColloctBigCell" bundle:nil] forCellWithReuseIdentifier:@"BMColloctBigCell"];
        _myCollectionView.alwaysBounceVertical = YES;
        
        [self.view addSubview:_myCollectionView];
        
        data = [TGCollectTool sharedTGCollectTool].collectedDeals;
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return data.count;
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
    

    BMSecKillModel *model = data[indexPath.row];
    
    BMColloctBigCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BMColloctBigCell" forIndexPath:indexPath];
//    cell.title.text = @"精品男装";
    if (ctype != nil && [ctype isEqualToString:@"商品"]) {
        NSURL *url = [NSURL URLWithString:model.imageurl];
        [cell.imageURL setImageWithURL:url placeholderImage:[UIImage imageNamed:@"nanrenzhuang"]];
        cell.cTitle.text = model.wareName;
    }

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"select");
}

- (void)segmentChange:(UISegmentedControl *)sender
{
    
    if (sender != nil && sender.selectedSegmentIndex == 0) {
        BMShopFavController *shop = [[BMShopFavController alloc]init];
     //   [self.view addSubview:shop.view];
//        [self.navigationController pushViewController:shop animated:YES];
//        data = @[@"1",@"2",@"3",@"4"];
        [_myCollectionView reloadData];

        return ;
    }

    BMProductFavController *pro =  [[BMProductFavController alloc]init];
    //        [self.view pushViewController:pro animated:YES];
  //  [self.view addSubview:pro.view];
//  [self.navigationController pushViewController:pro animated:YES];
    data = @[@"1",@"2",@"3",@"4",@"5",@"6"];
    ctype = @"商家";
    [_myCollectionView reloadData];
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
