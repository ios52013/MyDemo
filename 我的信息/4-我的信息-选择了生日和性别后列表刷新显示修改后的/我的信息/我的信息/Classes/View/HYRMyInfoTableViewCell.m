//
//  HYRMyInfoTableViewCell.m
//  我的信息
//
//  Created by 黄永锐 on 2017/5/3.
//  Copyright © 2017年 LoveQi. All rights reserved.
//

#import "HYRMyInfoTableViewCell.h"
#import "MyInfoBindingItem.h"


@implementation HYRMyInfoTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell";
    
    HYRMyInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[HYRMyInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}


- (void)setItem:(MyInfoItem *)item{
    _item = item;
    
    // 1.设置数据
    self.imageView.image = item.icon;
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subTitle;
    // 2.设置右侧视图
    [self setupRightView];
}

- (void)setupRightView{
    
    if ([_item isKindOfClass:[MyInfoBindingItem class]]){
        MyInfoBindingItem *btnItem = (MyInfoBindingItem *)_item;
        
        // 右侧视图是按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(0, 2, 80, 40);
        [button setBackgroundColor:[UIColor lightGrayColor]];
        NSString *btnTitle = btnItem.isBinding ? @"已绑定" : @"未绑定";
        [button setTitle:btnTitle forState:UIControlStateNormal];
        //self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.accessoryView = button;
        
        
    }else if ([_item isKindOfClass:[MyInfoItem class]]) {
        // 右侧视图是箭头
        if(_item.userHeaderImage){
            //
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
            //
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, 40, 40)];
            imageView.image = _item.userHeaderImage;
            //
            [view addSubview:imageView];
            //
            UIImageView *iv2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
            iv2.frame = CGRectMake(50, 14, iv2.bounds.size.width, iv2.bounds.size.height);
            [view addSubview:iv2];
            
            self.accessoryView = view;
            
        }else{
        
            self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
        }
        
    }
    
    
}







- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
