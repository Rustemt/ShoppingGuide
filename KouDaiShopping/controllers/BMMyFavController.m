//
//  BMMyFavController.m
//  KouDaiShopping
//
//  Created by admin on 14-6-2.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import "BMMyFavController.h"
#import "BMMyFavCell.h"


@interface BMMyFavController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *_myCollectionView;
}
@end

@implementation BMMyFavController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.itemSize = CGSizeMake(105, 100);
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 1, 5, 1);
        flowLayout.minimumInteritemSpacing = 1;
        flowLayout.minimumLineSpacing = 1;
        
        _myCollectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _myCollectionView.backgroundColor = [UIColor lightGrayColor];
        _myCollectionView.dataSource = self;
        _myCollectionView.delegate = self;
        _myCollectionView.showsHorizontalScrollIndicator = YES;
        
        
        [_myCollectionView registerNib:[UINib nibWithNibName:@"BMMyFavCell" bundle:nil] forCellWithReuseIdentifier:@"BMMyFavCell"];
        _myCollectionView.alwaysBounceVertical = YES;
        
        [self.view addSubview:_myCollectionView];
        

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 12;
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
    BMMyFavCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BMMyFavCell" forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"select");
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
