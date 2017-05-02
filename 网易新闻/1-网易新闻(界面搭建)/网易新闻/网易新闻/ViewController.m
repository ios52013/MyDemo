//
//  ViewController.m
//  网易新闻
//
//  Created by 黄永锐 on 2017/4/26.
//  Copyright © 2017年 LoveQi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

/*** 标题滑动视图 ***/
@property (nonatomic, weak)  UIScrollView *titleScrollView;
/*** 内容滑动视图 ***/
@property (nonatomic, weak) UIScrollView *contentScrollView;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"求求你";
    // 1.添加标题滚动视图
    [self setupTitleScrollView];
    
    // 2.添加内容滚动视图
    [self setupContentScrollView];
    
}

#pragma mark - 添加标题滚动视图
- (void)setupTitleScrollView
{
    // 创建titleScrollView
    UIScrollView *titleScrollView = [[UIScrollView alloc] init];
    titleScrollView.backgroundColor = [UIColor redColor];
    CGFloat y = self.navigationController.navigationBarHidden? 20 : 64;
    titleScrollView.frame = CGRectMake(0, y, self.view.bounds.size.width, 44);
    [self.view addSubview:titleScrollView];
    _titleScrollView = titleScrollView;
    
}

#pragma mark - 添加内容滚动视图
- (void)setupContentScrollView
{
    // 创建titleScrollView
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    contentScrollView.backgroundColor = [UIColor greenColor];
    CGFloat y = CGRectGetMaxY(self.titleScrollView.frame);
    contentScrollView.frame = CGRectMake(0, y, self.view.bounds.size.width, self.view.bounds.size.height - y);
    [self.view addSubview:contentScrollView];
    _contentScrollView = contentScrollView;
}


@end
