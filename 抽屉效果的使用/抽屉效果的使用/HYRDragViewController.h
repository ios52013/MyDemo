//
//  HYRDragViewController.h
//  抽屉效果
//
//  Created by 黄永锐 on 2017/4/25.
//  Copyright © 2017年 LoveQi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYRDragViewController : UIViewController
/** 左中右视图 **/
@property (nonatomic, weak ,readonly)UIView *leftV;
@property (nonatomic, weak ,readonly)UIView *rightV;
@property (nonatomic, weak ,readonly)UIView *mainV;

@end
