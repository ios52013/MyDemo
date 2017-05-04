//
//  MyInfoItem.h
//  我的信息
//
//  Created by 黄永锐 on 2017/5/3.
//  Copyright © 2017年 LoveQi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "userInfo.h"


@interface MyInfoItem : NSObject
/** 左侧图片 */
@property (nonatomic, strong) UIImage *icon;
/** 右侧用户头像 */
@property (nonatomic, strong) UIImage *userHeaderImage;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 标题 */
@property (nonatomic, copy) NSString *subTitle;

/** 目标控制器 */
@property (nonatomic, assign) Class desVC;




+ (instancetype)itemWithIcon:(UIImage *)icon andTitle:(NSString *)title andSubTitle:(NSString *)subTitle;
//用户头像
+ (instancetype)itemWithUserHeaderImage:(UIImage *)headerImage andTitle:(NSString *)title;
//
+ (instancetype)itemWithTitle:(NSString *)title andSubTitle:(NSString *)subTitle;

@end
