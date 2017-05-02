//
//  AppDelegate.h
//  左侧视图框架
//
//  Created by 黄永锐 on 2017/4/25.
//  Copyright © 2017年 LoveQi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDragerViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
/** 左侧视图 **/
@property (nonatomic, strong)MyDragerViewController *leftDragerVC;
@property (strong, nonatomic) UINavigationController *mainNavigationController;


@end

