//
//  HYRDragViewController.m
//  抽屉效果
//
//  Created by 黄永锐 on 2017/4/25.
//  Copyright © 2017年 LoveQi. All rights reserved.
//

#import "HYRDragViewController.h"

@interface HYRDragViewController ()
//
/** <#注释#> **/
@property (nonatomic, weak)UIView *leftV;
@property (nonatomic, weak)UIView *rightV;
@property (nonatomic, weak)UIView *mainV;

@end

@implementation HYRDragViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加子控件
    [self setUp];
    
    //添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.mainV addGestureRecognizer:pan];
}

#pragma mark - 添加手势
-(void)pan:(UIPanGestureRecognizer* )pan{
    // 1、获取偏移量
    CGPoint transP = [pan translationInView:self.mainV];
    // 2、修改形变 -只能修改x、y，不能达到修改高度
    //self.mainV.transform = CGAffineTransformTranslate(self.mainV.transform, transP.x, 0);
    
    // 修改frame
    self.mainV.frame = [self frameWithOffsetX:transP.x];
    
    //判断拖动的方向
    if (self.mainV.frame.origin.x > 0) {
        //向右拖  显示左边的内容 那就要隐藏右边的内容(因为先添加左边的视图 后添加右边的视图)
        self.rightV.hidden = YES;
        
    }else if (self.mainV.frame.origin.x < 0) {
        //向左
        self.rightV.hidden = NO;
    }
    
    // 3、复位
    [pan setTranslation:CGPointZero inView:self.mainV];
    
}

#pragma mark -根据偏移量 求出 mainV的frame
-(CGRect)frameWithOffsetX:(CGFloat)offsetX {
    CGRect frame = self.mainV.frame;
    frame.origin.x += offsetX;
    return frame;
}


#pragma mark - 添加子控件
- (void)setUp {
    //leftV
    UIView *leftV = [[UIView alloc] initWithFrame:self.view.bounds];
    leftV.backgroundColor = [UIColor redColor];
    [self.view addSubview:leftV];
    _leftV = leftV;
    
    //rightV
    UIView *rightV = [[UIView alloc] initWithFrame:self.view.bounds];
    rightV.backgroundColor = [UIColor greenColor];
    [self.view addSubview:rightV];
    _rightV = rightV;
    
    //mainV
    UIView *mainV = [[UIView alloc] initWithFrame:self.view.bounds];
    mainV.backgroundColor = [UIColor blueColor];
    [self.view addSubview:mainV];
    _mainV = mainV;
    
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
