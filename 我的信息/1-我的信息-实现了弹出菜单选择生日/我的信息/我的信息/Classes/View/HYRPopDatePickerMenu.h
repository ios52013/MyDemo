//
//  HYRPopDatePickerMenu.h
//  我的信息
//
//  Created by 黄永锐 on 2017/5/3.
//  Copyright © 2017年 LoveQi. All rights reserved.
//


// MyBlock 的类型 void(^)()
typedef void(^MyBlock)(id obj);

#import <UIKit/UIKit.h>


@class HYRPopDatePickerMenu;
//协议
@protocol HYRPopDatePickerMenuDelegate <NSObject>
- (void)popMenuDidCloseBtn:(HYRPopDatePickerMenu *)popMenu;
@end



//
@interface HYRPopDatePickerMenu : UIView
+ (instancetype)showDatePicker;
- (void)hideInCenter:(CGPoint)center completion:(MyBlock)completion;
//代理
@property (nonatomic, weak) id<HYRPopDatePickerMenuDelegate> delegate;

@end
