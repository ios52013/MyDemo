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



@interface MyTableViewController ()<HYRPopDatePickerMenuDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

/*** 数组总数 ***/
@property (nonatomic, strong) NSMutableArray *groups;

/*** 数据模型 ***/
@property (nonatomic, strong) userInfo *item;
/*** 日期选择器 ***/
@property (nonatomic, strong) UIDatePicker *datePick;
/*** UIPickerView ***/
@property (nonatomic, strong) UIPickerView * pickerView;
/** 存放性别 */
@property (nonatomic, strong) NSArray *dataArray;

/*** 相机与相册 ***/
@property (nonatomic, strong) UIImagePickerController *imagePickerVC;

@end





@implementation MyTableViewController

//相机与相册的懒加载
-(UIImagePickerController *)imagePickerVC{
    
    if (_imagePickerVC == nil) {
        //
        _imagePickerVC = [[UIImagePickerController alloc] init];
        _imagePickerVC.delegate = self;
    }
    
    return _imagePickerVC;
}


//懒加载
- (NSMutableArray *)groups{
    if (!_groups) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

//程序生命周期
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
//有多少个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.groups.count;
}
//每个分区有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 1.取出行模型数组
    NSArray *items = self.groups[section];
    return items.count;
}

//每一行什么样
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
    
    // 跳转
    MyInfoItem *arrowItem = (MyInfoItem *)item;
    if (arrowItem.desVC) {
        // 如果有目标控制器才跳转
        UIViewController *vc =  [[arrowItem.desVC alloc] init];
        vc.navigationItem.title = item.title;
        
        [self.navigationController pushViewController:vc animated:YES];
    }

    
    if (0 == indexPath.section) {
        //选择头像
        if (0 == indexPath.row) {
            //
            // UIAlertControllerStyleActionSheet 是显示在屏幕底部
            // UIAlertControllerStyleAlert 是显示在中间
            UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
             // 设置按钮
            //拍照
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //
                NSLog(@"拍照按钮被点击了");
                //调用相机
                //设置照片的来源
                
                //判断是真机 还是 模拟器
                if (TARGET_IPHONE_SIMULATOR) {
                    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"该设备不支持相机功能" preferredStyle:UIAlertControllerStyleAlert];
                    
                    [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
                    //
                    [self presentViewController:alertVC animated:YES completion:nil];
                    
                }else{
                    //如果是真机 就设置照片的来源
                    self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
                }
                
                
            }];
            
            //从相册选取
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //
                NSLog(@"从相册选取 按钮被点击了");
                //从系统相册中选择一张图片
                //弹出系统相册
                
                //设置照片的来源
                self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                //modal出系统相册
                [self presentViewController:self.imagePickerVC animated:YES completion:nil];
                
            }];
            
            //取消
            UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //
                NSLog(@"取消按钮被点击了");
            }];
            
            
            [actionSheet addAction:action1];
            [actionSheet addAction:action2];
            [actionSheet addAction:action3];
            
            //显示
            [self presentViewController:actionSheet animated:YES completion:nil];
            
            
        }else if(indexPath.row == 2){ //弹出菜单选择性别 和 生日

            // 1.弹出蒙版.占据整个屏幕,不允许与用户交互
            [HYRCover show];

            // 2.添加popMenu
            //     1.蒙版上  耦合度太高了
            //    2.窗口上
            
            HYRPopDatePickerMenu *popMenu = [HYRPopDatePickerMenu showDatePicker];
            popMenu.delegate = self;
            
            //选择性别
            //为了避免和系统生成的自动伸缩的约束不冲突 一般加上这句
            self.pickerView.translatesAutoresizingMaskIntoConstraints = NO;
            [popMenu.containView addSubview:self.pickerView];
            self.pickerView.tag = indexPath.row;
            
            //添加约束
            [self addConstraintWith:self.pickerView ToFartherView:popMenu.containView];
            
        }else if(indexPath.row == 3){
            // 1.弹出蒙版.占据整个屏幕,不允许与用户交互
            [HYRCover show];
            
            // 2.添加popMenu
            HYRPopDatePickerMenu *popMenu = [HYRPopDatePickerMenu showDatePicker];
            popMenu.delegate = self;
            
            //日期选择器 选择生日
            //为了避免和系统生成的自动伸缩的约束不冲突 一般加上这句
            self.datePick.translatesAutoresizingMaskIntoConstraints = NO;
            [popMenu.containView addSubview:self.datePick];
            self.datePick.tag = indexPath.row;
            
            //添加约束
            [self addConstraintWith:self.datePick ToFartherView:popMenu.containView];
            
        }
    }
    
    
    
}



#pragma mark - HYRPopDatePickerMenuDelegate
//选择性别或者生日 完成后调用
-(void)popMenuDidCloseBtn:(HYRPopDatePickerMenu *)popMenu{
    void(^completion)() =^(){
        // 2.移除蒙版
        // 当动画执行完毕的时候移除蒙版
        [HYRCover hide];
    };
    
    // 隐藏popMenu
    [popMenu hideCompletion:completion];
    
#pragma mark -刷新列表 其实应该只刷新一行就够了
    //[self.tableView reloadData];
    [self.tableView setNeedsDisplay];
}




//日期选择器的懒加载
-(UIDatePicker *)datePick{
    if (_datePick == nil) {
        UIDatePicker *datePick = [[UIDatePicker alloc] init];
        //修改datePick日期模式
        datePick.datePickerMode = UIDatePickerModeDate;
        datePick.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        
        //监听日期改变
        [datePick addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
        
        self.datePick = datePick;
        
    }
    return _datePick;
}


//当日期改变的时候会调用
- (void)dateChange:(UIDatePicker *)datePick{
    
    //把当前的日期给文本框赋值
    //获取当前选中的日期
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    //把当前日期转成字符串
    NSString *selectBirthdayStr = [fmt stringFromDate:datePick.date];
    NSLog(@"选择了----%@",selectBirthdayStr);
    
    //修改列表中的数据源 此时数据源应该是行对象
    NSArray *items = self.groups[0];
    MyInfoItem *item = items[self.datePick.tag];
    item.subTitle = selectBirthdayStr;
    
    //生日同时也保存在对象中 返回给服务器
    self.item.brithday = selectBirthdayStr;
    
    [self.tableView reloadData];
}


//选择性别的 UIPickerView 懒加载
-(UIPickerView *)pickerView{
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
    }
    return _pickerView;
}

//懒加载
-(NSArray *)dataArray{
    
    if (_dataArray == nil) {
        _dataArray = @[@"男",@"女",@"不男不女"];
    }
    
    return _dataArray;
}



#pragma mark - UIPickerViewDataSource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataArray.count;
}


//每一行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 80;
}


//每行展示什么内容
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.dataArray[row];
}

//当前选中的是哪一列的哪一行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
 
    NSString *selectSexStr = self.dataArray[row];
    NSLog(@"您的性别是：%@",selectSexStr);
    
    //修改列表中的数据源 此时数据源应该是 行对象
    NSArray *items = self.groups[0];
    MyInfoItem *item = items[self.pickerView.tag];
    item.subTitle = selectSexStr;
    //刷新列表
    [self.tableView reloadData];
    
    //修改性别 同时也保存在对象中 返回给服务器
    self.item.sex = selectSexStr;
}




#pragma mark - 纯代码自动布局  给弹出菜单添加约束
-(void)addConstraintWith:(UIView*)subView ToFartherView:(UIView*)fartherView{
    
    // 间距约束（添加到self.view身上）
    CGFloat margin = 0;
    [fartherView addConstraints:@[
                                // 上边
                                [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:fartherView attribute:NSLayoutAttributeTop multiplier:1.0 constant:margin],
                                // 左边
                                [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:fartherView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:margin],
                                
                                // 右边
                                [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:fartherView attribute:NSLayoutAttributeRight multiplier:1.0 constant: margin],

                                // 底部
                                [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:fartherView attribute:NSLayoutAttributeBottom multiplier:1.0 constant: margin]
                                
                                ]];
    
}




#pragma mark - UIImagePickerControllerDelegate
//取消选择照片
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"取消保存");
    [self dismissViewControllerAnimated:YES completion:nil];
}
//当选择某一张照片 或者拍照完毕选择图片的时候 会调用这个方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSLog(@"info:%@",info);
    
    UIImage *selectImage = info[UIImagePickerControllerOriginalImage];
    NSData *data = UIImageJPEGRepresentation(selectImage, 1);
    BOOL successful = [data writeToFile:@"/Users/huangyongrui/Desktop/test.png" atomically:YES];
    if (successful) {
        NSLog(@"选择照片保存成功");
    }else{
        NSLog(@"保存失败");
    }
    
    //剪切成圆形
    selectImage = [UIImage imageWithBorder:5 color:[UIColor greenColor] image:selectImage];
    //修改列表中的数据源 此时数据源应该是 行对象
    NSArray *items = self.groups[0];
    MyInfoItem *item = items[0];
    item.userHeaderImage = selectImage;
    
    //保存图片到相册
    //UIImageWriteToSavedPhotosAlbum(selectImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //刷新列表
    [self.tableView reloadData];
    
    
}

//图片到相册 保存完毕时候调用
-(void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    if(error == nil){
        NSLog(@"相片已经保存到相册库了");
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end





