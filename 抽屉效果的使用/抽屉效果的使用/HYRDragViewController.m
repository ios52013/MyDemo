//
//  HYRDragViewController.m
//  抽屉效果
//
//  Created by 黄永锐 on 2017/4/25.
//  Copyright © 2017年 LoveQi. All rights reserved.
//

#define DragScreenW [UIScreen mainScreen].bounds.size.width
#define DragScreenH [UIScreen mainScreen].bounds.size.height


#import "HYRDragViewController.h"

@interface HYRDragViewController ()
//

@end

@implementation HYRDragViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加子控件
    [self setUp];
    
    //添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.mainV addGestureRecognizer:pan];
    
    
    //给控制器的view添加点按手势  mainV复位还原
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];
}

#pragma mark - mainV复位
-(void)tap:(UITapGestureRecognizer *)tap {
    //让mainV复位
    [UIView animateWithDuration:0.5 animations:^{
        //
        self.mainV.frame = self.view.bounds;
    }];
}





//自动定位的值
#define targetR 275
#define targetL -275


#pragma mark - 添加手势
-(void)pan:(UIPanGestureRecognizer* )pan{
    // 1、获取偏移量
    CGPoint transP = [pan translationInView:self.mainV];
    // 2、修改形变 -只能修改x、y，不能达到修改高度
    //self.mainV.transform = CGAffineTransformTranslate(self.mainV.transform, transP.x, 0);
    
    
    //NSLog(@"%f",transP.x);
#pragma mark - 不能向左滑动
    if (transP.x < 0) {
        transP.x = 0;
    }
    
    // 修改frame
    self.mainV.frame = [self frameWithOffsetX:transP.x];
    
    //判断拖动的方向
    if (self.mainV.frame.origin.x > 0) {
        //向右拖  显示左边的内容 那就要隐藏右边的内容(因为先添加左边的视图 后添加右边的视图)
        self.rightV.hidden = YES;
        
    }else if (self.mainV.frame.origin.x < 0) {
        //向左
        //self.rightV.hidden = NO;
    }
    
    //当手指松开的时候 自定定位
    CGFloat target = 0;
    //判断手指的状态
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        if (self.mainV.frame.origin.x >  DragScreenW * 0.5) {
            
            //1、判断在右侧
            // 怎么知道定位在右侧？那就根据x是否大于屏幕宽度的一半
            target = targetR;
            
        }else if (CGRectGetMaxX(self.mainV.frame) < DragScreenW * 0.5){
            
            //2、判断在左侧
            //当前view的 最大的x值 是否小于 屏幕宽度的一半
            target = targetL;
        }
        
        //计算当前mainV的frame
        //当前mainV的x与target的相差的距离 就是偏移量。根据偏移量 我们可以算出frame
        CGFloat offset = target - self.mainV.frame.origin.x;
        [UIView animateWithDuration:0.5 animations:^{
            //
            self.mainV.frame = [self frameWithOffsetX:offset];

        }];
        
    }
    
    
    
    // 3、复位
    [pan setTranslation:CGPointZero inView:self.mainV];
    
}



//y的最大值
#define maxY 100

#pragma mark -根据偏移量 求出 mainV的frame
-(CGRect)frameWithOffsetX:(CGFloat)offsetX {
    CGRect frame = self.mainV.frame;
    frame.origin.x += offsetX;
    
    //y值什么时候才能达到最大值？就是拖动x滑动到屏幕宽度的时候
    //因为向左的时候x是负值
    //对计算的结果取绝对值
    CGFloat y = fabs(frame.origin.x * maxY / DragScreenW);
    frame.origin.y = y;
    
    //计算高度:屏幕的高度-2倍的y
    frame.size.height = DragScreenH - 2*y;
    
    return frame;
}


#pragma mark - 添加子控件
- (void)setUp {
    //leftV
    UIView *leftV = [[UIView alloc] initWithFrame:self.view.bounds];
    leftV.backgroundColor = [UIColor whiteColor];
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

@end
