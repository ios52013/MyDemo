//
//  MainViewController.m
//  抽屉效果的使用
//
//  Created by 黄永锐 on 2017/4/25.
//  Copyright © 2017年 LoveQi. All rights reserved.
//

#import "MainViewController.h"
#import "MyInfoTableViewController.h"
#import "ThemeViewController.h"


@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加主视图
    ThemeViewController *themeVC = [[ThemeViewController alloc] init];
    [self.mainV addSubview:themeVC.view];
    [self addChildViewController:themeVC];
    
    //添加个人信息视图
    MyInfoTableViewController *myInfoVC = [[MyInfoTableViewController alloc] init];
    [self.leftV addSubview:myInfoVC.view];
    [self addChildViewController:myInfoVC];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
