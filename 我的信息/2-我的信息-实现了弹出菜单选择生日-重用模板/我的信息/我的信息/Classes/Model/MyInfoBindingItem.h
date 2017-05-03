//
//  MyInfoBangdingItem.h
//  我的信息
//
//  Created by 黄永锐 on 2017/5/3.
//  Copyright © 2017年 LoveQi. All rights reserved.
//

#import "MyInfoItem.h"

@interface MyInfoBindingItem : MyInfoItem
/*** 按钮的标题 ***/
@property (nonatomic, copy) NSString * btnTitle;

/*** 是否绑定 ***/
@property (nonatomic, assign, getter=isBinding) BOOL  binding;


@end
