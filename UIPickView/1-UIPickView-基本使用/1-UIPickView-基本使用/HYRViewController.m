//
//  HYRViewController.m
//  1-UIPickView-基本使用
//
//  Created by 黄永锐 on 2017/5/3.
//  Copyright © 2017年 LoveQi. All rights reserved.
//

#import "HYRViewController.h"

@interface HYRViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
/*** UIPickerView ***/
@property (nonatomic, strong) UIPickerView * pickerView;

@end



@implementation HYRViewController

-(UIPickerView *)pickerView{
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.frame = CGRectMake(0, (self.view.bounds.size.height-200)*0.5, self.view.bounds.size.width, 200);
        [self.view addSubview:_pickerView];
    }
    return _pickerView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    //
    //1.设置数据源
    self.pickerView.dataSource = self;
    //2.设置代理
    self.pickerView.delegate = self;
}

#pragma mark - UIPickerViewDataSource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 10;
}

//每一列的宽度
//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
//}
//每一行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 50;
}


//每行展示什么内容
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component == 0){
        return [NSString stringWithFormat:@"锐%ld",row];
    }else{
        return [NSString stringWithFormat:@"哥%ld",row];
    }
    
}


//每行展示什么内容,带有属性的字符串,(大小,颜色,阴影,描边)
//- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
//
//}

//每一行展示什么视图
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view{
//    
//    return  [UIButton buttonWithType:UIButtonTypeContactAdd];
//}



//当前选中的是哪一列的哪一行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"component=%ld--row-%ld",component,row);
}

@end




