//
//  HYRPopDatePickerMenu.m
//  我的信息
//
//  Created by 黄永锐 on 2017/5/3.
//  Copyright © 2017年 LoveQi. All rights reserved.
//
#define HYRKeyWindow [UIApplication sharedApplication].keyWindow

#import "HYRPopDatePickerMenu.h"

@implementation HYRPopDatePickerMenu

//显示弹出菜单
+ (instancetype)showDatePicker{
    UIView *popMenu = [[NSBundle mainBundle] loadNibNamed:@"HYRPopDatePickerMenu" owner:nil options:nil][0];
    
    popMenu.frame = CGRectMake(0, HYRKeyWindow.bounds.size.height-300, HYRKeyWindow.bounds.size.width, 300);
    [HYRKeyWindow addSubview:popMenu];
    return popMenu;
}

//隐藏
- (void)hideCompletion:(MyBlock)completion{

    // 当动画执行完毕的时候移除蒙版,

 
    [UIView animateWithDuration:0.5 animations:^{
        //
        CGPoint center = CGPointMake(HYRKeyWindow.frame.size.width*0.5, HYRKeyWindow.frame.size.height+(self.bounds.size.height)*0.6);
        
        self.center = center;
        
        
    } completion:^(BOOL finished) {
        // 1.移除自己
        [self removeFromSuperview];
        
        
        // 2.移除蒙版  但是蒙版不是在这里面添加的所以不能再这里移除
        //        [HYRCover hide];
        // 1.用代理通知外界
        // 通知外界,点击了x号按钮
        //        if ([self.delegate respondsToSelector:@selector(popMenuDidCloseBtn:)]) {
        //            [self.delegate popMenuDidCloseBtn:self];
        //        }
        // block当做参数传递, 如果值为空,直接调用崩溃
        if (completion) {
            //            移除蒙版
            completion(nil);//带参数回去
        }
        
    }];
}


// 当点击按钮的时候调用
- (IBAction)Click:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            NSLog(@"您放弃了选择!");
            break;
        case 1:
            NSLog(@"恭喜您完成了");
            break;
            
        default:
            break;
    }
    
     // 通知外界,点击了x号按钮
    if ([self.delegate respondsToSelector:@selector(popMenuDidCloseBtn:)]) {
        [self.delegate popMenuDidCloseBtn:self];
    }
    
}





@end
