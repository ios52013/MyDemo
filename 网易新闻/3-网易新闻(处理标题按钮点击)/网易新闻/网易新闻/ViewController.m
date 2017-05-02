//
//  ViewController.m
//  网易新闻
//
//  Created by 黄永锐 on 2017/4/26.
//  Copyright © 2017年 LoveQi. All rights reserved.
//

#import "ViewController.h"
#import "TopLineViewController.h"
#import "HotTableViewController.h"
#import "ScoietyTableViewController.h"
#import "ReaderViewController.h"
#import "ScienceViewController.h"
#import "VideoViewController.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height



@interface ViewController ()

/*** 标题滑动视图 ***/
@property (nonatomic, weak)  UIScrollView *titleScrollView;
/*** 内容滑动视图 ***/
@property (nonatomic, weak) UIScrollView *contentScrollView;
/*** 记录选中的按钮 ***/
@property (nonatomic, weak) UIButton *selectButton;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"求求你";
    // 1.添加标题滚动视图
    [self setupTitleScrollView];
    
    // 2.添加内容滚动视图
    [self setupContentScrollView];
    
    //3、添加所有子控制器
    [self setupAllChildViewController];
    
    // 4.设置所有标题
    [self setupAllTitle];
    
    //5、处理标题按钮的点击
}

#pragma mark - 添加标题滚动视图
- (void)setupTitleScrollView
{
    // 创建titleScrollView
    UIScrollView *titleScrollView = [[UIScrollView alloc] init];
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

#pragma mark - 添加所有子控制器
-(void)setupAllChildViewController{
    // 头条
    TopLineViewController *vc1 = [[TopLineViewController alloc] init];
    vc1.title = @"头条";
    [self addChildViewController:vc1];
    // 热点
    HotTableViewController *vc2 = [[HotTableViewController alloc] init];
    vc2.title = @"热点";
    [self addChildViewController:vc2];
    // 视频
    VideoViewController *vc3 = [[VideoViewController alloc] init];
    vc3.title = @"视频";
    [self addChildViewController:vc3];
    // 社会
    ScoietyTableViewController *vc4 = [[ScoietyTableViewController alloc] init];
    vc4.title = @"社会";
    [self addChildViewController:vc4];
    // 订阅
    ReaderViewController *vc5 = [[ReaderViewController alloc] init];
    vc5.title = @"订阅";
    [self addChildViewController:vc5];
    // 科技
    ScienceViewController *vc6 = [[ScienceViewController alloc] init];
    vc6.title = @"科技";
    [self addChildViewController:vc6];

}


#pragma mark - 设置所有标题
- (void)setupAllTitle
{
    // 已经把内容展示上去 -> 展示的效果是否是我们想要的(调整细节)
    // 1.标题颜色 为黑色
    // 2.需要让titleScrollView可以滚动
    
    // 添加所有标题按钮
    NSInteger count = self.childViewControllers.count;
    CGFloat btnW = 100;
    CGFloat btnH = self.titleScrollView.bounds.size.height;
    CGFloat btnX = 0;
    for (NSInteger i = 0; i < count; i++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
#pragma mark - 注意传tag
        titleButton.tag = i;
        UIViewController *vc = self.childViewControllers[i];
        [titleButton setTitle:vc.title forState:UIControlStateNormal];
        btnX = i * btnW;
        titleButton.frame = CGRectMake(btnX, 0, btnW, btnH);
        [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        // 监听按钮点击
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            [self titleClick:titleButton];
        }
        
        [self.titleScrollView addSubview:titleButton];
    }
    
    
    // 设置标题的滚动范围
    self.titleScrollView.contentSize = CGSizeMake(count * btnW, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    
    // 设置内容的滚动范围
    self.contentScrollView.contentSize = CGSizeMake(count * ScreenW, 0);
    
    // bug:代码跟我的一模一样,但是标题就是显示不出来
    // 内容往下移动,莫名其妙
}

#pragma mark - 处理标题点击
- (void)titleClick:(UIButton *)button
{
    NSInteger i = button.tag;
    
    // 1.标题颜色 变成 红色
    [self selButton:button];
    // 2.把对应子控制器的view添加上去
    UIViewController *vc = self.childViewControllers[i];
    CGFloat x = i * [UIScreen mainScreen].bounds.size.width;
    vc.view.frame = CGRectMake(x, 0, ScreenW  , self.contentScrollView.bounds.size.height);
    [self.contentScrollView addSubview:vc.view];
    
    // 3.内容滚动视图滚动到对应的位置
    self.contentScrollView.contentOffset = CGPointMake(x, 0);
}

#pragma mark - 选中标题
- (void)selButton:(UIButton *)button
{
    //上一次选中的 变黑色
    [_selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //当前选中的变红色
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //记录当前选中的按钮
    _selectButton = button;
}



@end
