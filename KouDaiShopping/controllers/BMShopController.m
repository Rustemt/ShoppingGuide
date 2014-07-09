//
//  BMShopController.m
//  KouDaiShopping
//
//  Created by admin on 14-6-2.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import "BMShopController.h"
#import "BMShopCell.h"

@interface BMShopController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *myTalbeView;

@end

@implementation BMShopController

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
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height -110);
    _myTalbeView = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
    self.myTalbeView.dataSource = self;
    self.myTalbeView.delegate = self;
    self.myTalbeView.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [self.view addSubview:_myTalbeView];
    
    [_myTalbeView registerNib:[UINib nibWithNibName:@"BMShopCell" bundle:nil] forCellReuseIdentifier:@"BMShopCell"];
    

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMShopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMShopCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"did Select");
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
