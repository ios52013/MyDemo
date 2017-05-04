//
//  userInfo.h
//  我的信息
//
//  Created by 黄永锐 on 2017/5/2.
//  Copyright © 2017年 LoveQi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userInfo : NSObject
//
/*** <#注释#> ***/
@property (nonatomic, strong) NSString *headerImageName;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *brithday;


/** <#注释#> **/
@property (nonatomic, assign)BOOL isBandingWX;
@property (nonatomic, assign)BOOL isBandingQQ;



@end
