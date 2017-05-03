//
//  ViewController.m
//  1-UIDatePicker-日期选择器
//
//  Created by 黄永锐 on 2017/5/3.
//  Copyright © 2017年 LoveQi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
/** <#注释#> */
@property (nonatomic, strong) UIDatePicker *datePick;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

//
-(UIDatePicker *)datePick{
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
    return _datePick;
}

//
- (IBAction)selectBirthday:(UIButton *)sender {
    
    [self.view addSubview:self.datePick];
}

//当日期改变的时候会调用
- (void)dateChange:(UIDatePicker *)datePick{
    
    //把当前的日期给文本框赋值
    //获取当前选中的日期
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    //把当前日期转成字符串
    self.birthdayLabel.text = [fmt stringFromDate:datePick.date];
    
    
}




@end
