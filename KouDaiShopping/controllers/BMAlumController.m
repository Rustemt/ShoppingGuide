//
//  BMAlumController.m
//  KouDaiShopping
//
//  Created by admin on 14-6-2.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import "BMAlumController.h"
#import "BMAlbumCell.h"

@interface BMAlumController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *myTalbeView;


@end

@implementation BMAlumController

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height -110);
    _myTalbeView = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
    self.myTalbeView.dataSource = self;
    self.myTalbeView.delegate = self;
    self.myTalbeView.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [self.view addSubview:_myTalbeView];
    
    [_myTalbeView registerNib:[UINib nibWithNibName:@"BMAlbumCell" bundle:nil] forCellReuseIdentifier:@"BMAlbumCell"];
    

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
    return 140;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    BMAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMAlbumCell" forIndexPath:indexPath];
//    
    // Configure the cell...
    BMAlbumCell *cell = (BMAlbumCell *)[tableView dequeueReusableCellWithIdentifier:@"BMAlbumCell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BMAlbumCell" owner:self options:nil] objectAtIndex:0];
    }

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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
