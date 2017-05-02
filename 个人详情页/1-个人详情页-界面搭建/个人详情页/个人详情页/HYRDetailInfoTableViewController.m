//
//  HYRDetailInfoTableViewController.m
//  个人详情页
//
//  Created by 黄永锐 on 2017/5/2.
//  Copyright © 2017年 LoveQi. All rights reserved.
//

#import "HYRDetailInfoTableViewController.h"

@interface HYRDetailInfoTableViewController ()

@end

@implementation HYRDetailInfoTableViewController


static NSString *ID = @"cell";


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人详情页";
    //注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    //1.凡是在导航条下面的scrollView.默认会设置偏移量.UIEdgeInsetsMake(64, 0, 0, 0)
    //self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    NSLog(@"%@",NSStringFromCGRect(self.tableView.frame));
    //不要自动设置偏移量
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //让导航条隐藏
//    self.navigationController.navigationBar.hidden = YES;
    
    //导航条或者是导航条上的控件设置透明度是没有效果.
//    self.navigationController.navigationBar.alpha = 0;
    
    
    
    //设置导航条背景(必须得要使用默认的模式UIBarMetricsDefault)
    //当背景图片设置为Nil,系统会自动生成一张半透明的图片,设置为导航条背景
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
    header.backgroundColor = [UIColor redColor];
    //self.tableView.tableHeaderView = header;
    
    /*
     如果是用tableHeaderView 往上拖动 是没问题的
     但是往下拉动的时候，顶部会出现一片空白
     */
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 40;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    NSLog(@"%p",cell);
    
    cell.textLabel.text = @"HYR";
    
    return cell;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
