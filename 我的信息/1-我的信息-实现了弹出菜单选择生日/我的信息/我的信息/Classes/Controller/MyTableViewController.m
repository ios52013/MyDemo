//
//  MyTableViewController.m
//  我的信息
//
//  Created by 黄永锐 on 2017/5/2.
//  Copyright © 2017年 LoveQi. All rights reserved.
//

#import "MyTableViewController.h"
#import "UIImage+image.h"
#import "MyInfoItem.h"
#import "HYRMyInfoTableViewCell.h"
#import "MyInfoBindingItem.h"
#import "HYRPushViewController.h"
#import <MJExtension/MJExtension.h>
#import "userInfo.h"
#import "UIImage+image.h"
#import "HYRBindingViewController.h"
#import "HYRCover.h"
#import "HYRPopDatePickerMenu.h"

#define HYRKeyWindow [UIApplication sharedApplication].keyWindow



@interface MyTableViewController ()<HYRPopDatePickerMenuDelegate>
/** 数组总数 */
@property (nonatomic, strong) NSMutableArray *groups;

/*** 数据模型 ***/
@property (nonatomic, strong) userInfo *item;
/** <#注释#> */
@property (nonatomic, strong) UIDatePicker *datePick;

@end

@implementation MyTableViewController

- (NSMutableArray *)groups{
    if (!_groups) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

//
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"userInfo" ofType:@"plist"];
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    self.item = [userInfo mj_objectWithKeyValues:dict];
    //
    // 第0组
    [self setupGrup0];
    
    // 第1组
    [self setupGrup1];
}

// 第0组
- (void)setupGrup0{
    // 创建行模型
    UIImage *headerImage = [UIImage imageWithBorder:2 color:[UIColor greenColor] image:[UIImage imageNamed:self.item.headerImageName]];
    MyInfoItem *item1 = [MyInfoItem itemWithUserHeaderImage:headerImage andTitle:@"头像"];

    //
    MyInfoItem *item2 = [MyInfoItem itemWithTitle:@"昵称" andSubTitle:self.item.nickName];
    item2.desVC = [HYRPushViewController class];
    
    //
    MyInfoItem *item3 = [MyInfoItem itemWithTitle:@"性别" andSubTitle:self.item.sex];

    //
    MyInfoItem *item4 = [MyInfoItem itemWithTitle:@"生日" andSubTitle:self.item.brithday];
    //
    MyInfoItem *item5 = [MyInfoItem itemWithTitle:@"修改密码" andSubTitle:nil];
   
    item5.desVC = [HYRPushViewController class];

    NSArray *items = @[item1,item2,item3,item4,item5];
    
    // 将行模型数组添加到数组总数
    [self.groups addObject:items];
}

// 第1组
- (void)setupGrup1{
    // 创建行模型
    NSMutableArray *items = [NSMutableArray array];
    
    MyInfoBindingItem *item1 = [MyInfoBindingItem itemWithIcon:[UIImage imageNamed:@"wx"] andTitle:@"微信" andSubTitle:nil];
    item1.binding = self.item.isBandingWX;
    item1.desVC = [HYRBindingViewController class];
    
    [items addObject:item1];
    
    
    MyInfoBindingItem *item2 = [MyInfoBindingItem itemWithIcon:[UIImage imageNamed:@"QQ"] andTitle:@"QQ" andSubTitle:nil];
    item2.binding = self.item.isBandingQQ;
    item2.desVC = [HYRBindingViewController class];
    
    [items addObject:item2];
    
    
    // 将行模型数组添加到数组总数
    [self.groups addObject:items];
}





#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 1.取出行模型数组
    NSArray *items = self.groups[section];
    return items.count;
}

//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYRMyInfoTableViewCell *cell = [HYRMyInfoTableViewCell cellWithTableView:tableView];
    
   
    // 设置数据
    // 0.取出行模型数组
    NSArray *group = self.groups[indexPath.section];
    
    // 1.取出行模型
    MyInfoItem *item =  group[indexPath.row];
    
    // 2.设置数据
    cell.item = item;
    
    return cell;
}

//选择了某一行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 1.取出组模型
    NSArray *group =  self.groups[indexPath.section];
    // 2.取出行模型
    MyInfoItem *item =  group[indexPath.row];
    // 只有箭头模型才具备跳转
    //if ([item isKindOfClass:[MyInfoItem class]]) {
        // 跳转
        MyInfoItem *arrowItem = (MyInfoItem *)item;
        if (arrowItem.desVC) {
            // 如果有目标控制器才跳转
            UIViewController *vc =  [[arrowItem.desVC alloc] init];
            vc.navigationItem.title = item.title;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
    //}
    
    
    if (indexPath.row == 2 || indexPath.row == 3) {
        // 1.弹出蒙版.占据整个屏幕,不允许与用户交互
        [HYRCover show];
        
        // 2.添加popMenu
        //     1.蒙版上  耦合度太高了
        //    2.窗口上
        //[self showDatePicker];
        
        HYRPopDatePickerMenu *popMenu = [HYRPopDatePickerMenu showDatePicker];
        popMenu.delegate = self;
    }
}

#pragma mark - HYRPopDatePickerMenuDelegate
-(void)popMenuDidCloseBtn:(HYRPopDatePickerMenu *)popMenu{
    void(^completion)() =^(){
        // 2.移除蒙版
        // 当动画执行完毕的时候移除蒙版
        [HYRCover hide];
    };
    
    // 隐藏popMenu
    [popMenu hideInCenter:CGPointMake(44, 44) completion:completion];
    

}



-(UIDatePicker *)showDatePicker{
   
    if (_datePick == nil) {
        UIDatePicker *datePick = [[UIDatePicker alloc] init];
        datePick.frame = CGRectMake((self.view.bounds.size.width-300)*0.5, self.view.bounds.size.height-(200+100), 300, 200);
        //修改datePick日期模式
        datePick.datePickerMode = UIDatePickerModeDate;
        datePick.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        
        //监听日期改变
        [datePick addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
        
        self.datePick = datePick;
        
    }
    //
    [HYRKeyWindow addSubview:_datePick];
    return self.datePick;
}

//当日期改变的时候会调用
- (void)dateChange:(UIDatePicker *)datePick{
    
    //把当前的日期给文本框赋值
    //获取当前选中的日期
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    //把当前日期转成字符串
    //self.birthdayLabel.text = [fmt stringFromDate:datePick.date];
    
    
}

@end





