//
//  HYRCover.m
//  我的信息
//
//  Created by 黄永锐 on 2017/5/3.
//  Copyright © 2017年 LoveQi. All rights reserved.
//
#define HYRKeyWindow [UIApplication sharedApplication].keyWindow

#import "HYRCover.h"

@implementation HYRCover


+ (void)show{
    // 1.创建蒙版
    
    HYRCover *cover = [[self alloc] init];
    
    // 2.添加蒙版
    // 蒙版添加到哪里
    // 添加到窗口上面
    [HYRKeyWindow addSubview:cover];
    
    // 3.设置尺寸
    cover.frame = [UIScreen mainScreen].bounds;
    cover.backgroundColor = [UIColor blackColor];
    //    cover.alpha = 0.7f;
    cover.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5f];
    
    // 父控件透明子控件也透明
    // 4.添加popMenu
    //    UIView *popMenu = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    //    [cover addSubview:popMenu];
    //    popMenu.backgroundColor = [UIColor yellowColor];
    
}


+ (void)hide{
    // 隐藏蒙版
    for (UIView *view in HYRKeyWindow.subviews) {
        if ([view isKindOfClass:[HYRCover class]]) {
            // 当前类
            [view removeFromSuperview];
            break;
        }
    }
}
@end
