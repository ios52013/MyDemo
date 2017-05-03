//
//  MyInfoItem.m
//  我的信息
//
//  Created by 黄永锐 on 2017/5/3.
//  Copyright © 2017年 LoveQi. All rights reserved.
//

#import "MyInfoItem.h"

@implementation MyInfoItem

+ (instancetype)itemWithIcon:(UIImage *)icon andTitle:(NSString *)title andSubTitle:(NSString *)subTitle {
    MyInfoItem *item = [[self alloc] init];
    
    item.icon = icon;
    
    item.title = title;
    item.subTitle = subTitle;
    
    return item;
}

//用户头像
+ (instancetype)itemWithUserHeaderImage:(UIImage *)headerImage andTitle:(NSString *)title{
    MyInfoItem *item = [[self alloc] init];
    item.title = title;
    item.userHeaderImage = headerImage;
    return item;
}

//
+ (instancetype)itemWithTitle:(NSString *)title andSubTitle:(NSString *)subTitle{
    MyInfoItem *item = [[self alloc] init];
    item.title = title;
    item.subTitle = subTitle;
    
    return item;
}


@end
