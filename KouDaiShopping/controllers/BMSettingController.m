//
//  BMSettingController.m
//  KouDaiShopping
//
//  Created by admin on 14-5-6.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import "BMSettingController.h"
#import "BMSerHeaderCell.h"

@interface BMSettingController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *titleArr;
    NSArray *kTitleArr;
    NSArray *otherArr;
}
@property (strong, nonatomic)  UITableView *myTalbeView;



@end

@implementation BMSettingController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"服务";
        self.view.backgroundColor = [UIColor blueColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44);
    _myTalbeView = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
    self.myTalbeView.dataSource = self;
    self.myTalbeView.delegate = self;
    self.myTalbeView.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [self.view addSubview:_myTalbeView];
    
    [_myTalbeView registerNib:[UINib nibWithNibName:@"BMSerHeaderCell" bundle:nil] forCellReuseIdentifier:@"BMSerHeaderCell"];
    
    BMSerHeaderCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"BMSerHeaderCell" owner:self options:nil] objectAtIndex:0];
    _myTalbeView.tableHeaderView = cell;
    
    titleArr = @[@"口袋账号",@"京东快捷入口",@"其他"];
    kTitleArr = @[@"个人信息",@"我的账号：18513958568",@"我的订单",@"我的送货地址"];
    otherArr = @[@"通知设置",@"2G/3G环境下是使用省流量模式",@"给口袋好评",@"意见与问题反馈",@"使用指南",@"清理缓存",@"关于口袋购物"];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, 300, 44)];
    button.backgroundColor = [UIColor orangeColor];
    button.layer.cornerRadius = 5.0;
    [button setTitle:@"退出" forState:UIControlStateNormal];
    UIView *logout = [[UIView alloc]init];
    _myTalbeView.tableFooterView = logout;
    [_myTalbeView.tableFooterView addSubview:button];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 2) {
        return  otherArr.count;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return  30;
    }
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    BMAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMAlbumCell" forIndexPath:indexPath];
    //
    // Configure the cell...
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CID"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CID"];
        }
        cell.backgroundColor = [UIColor lightGrayColor];
        cell.textLabel.text = titleArr[indexPath.section];
        return cell;
    }

    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KoudaiID"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"KoudaiID"];
        }
        cell.textLabel.text = kTitleArr[indexPath.row -1];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }
    if (indexPath.section == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OID"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OID"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = otherArr[indexPath.row];
        
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    cell.textLabel.text = @"个人信息";
    return cell;
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;    // fixed font style. use custom view (UILabel) if you want something different
//{
//    return titleArr[section];
//}
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
