//
//  HYRMyInfoTableViewCell.h
//  我的信息
//
//  Created by 黄永锐 on 2017/5/3.
//  Copyright © 2017年 LoveQi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyInfoItem.h"

@interface HYRMyInfoTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/** 行模型 */
@property (nonatomic, strong) MyInfoItem *item;

@end
