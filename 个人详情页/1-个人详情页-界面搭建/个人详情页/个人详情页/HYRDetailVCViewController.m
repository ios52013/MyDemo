//
//  HYRDetailVCViewController.m
//  个人详情页
//
//  Created by 黄永锐 on 2017/5/2.
//  Copyright © 2017年 LoveQi. All rights reserved.
//

#import "HYRDetailVCViewController.h"

@interface HYRDetailVCViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//背景图 高度的约束

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstr;

@end

@implementation HYRDetailVCViewController



#define HYRDetailImageY -244 //最原始的点
#define HYRDetailImageH 200 //最原始的高度

static NSString *ID = @"cell";

//
- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.navigationItem.title = @"个人详情页";
    //把自身设置成代理
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
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
    
#pragma mark -当调用contentInset会自动调用scrollViewDidScroll
    
    self.tableView.contentInset = UIEdgeInsetsMake(244, 0, 0, 0);
}

#pragma mark - 监听scrollView的滚动方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%f",scrollView.contentOffset.y);
    
    //求偏移量
    //当前点 - 最原始的点
    CGFloat offset = scrollView.contentOffset.y - HYRDetailImageY;
    NSLog(@"offset======%f",offset);
    
    //最原始的高度 - 偏移量  就是现在的高度
    CGFloat h = HYRDetailImageH - offset;
    
    if (h < 64) {
        h = 64;
    }
    self.heightConstr.constant = h;
    
}


#pragma mark - UITableViewDataSource
//多少个分区
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
//每一个分区多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
//每一行什么样
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];

    
    cell.textLabel.text = @"HYR";
    
    return cell;
}

@end





