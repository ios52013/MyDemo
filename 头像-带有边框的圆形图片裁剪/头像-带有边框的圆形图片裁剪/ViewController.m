//
//  ViewController.m
//  头像-带有边框的圆形图片裁剪
//
//  Created by 黄永锐 on 2017/5/2.
//  Copyright © 2017年 LoveQi. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+image.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.imageView.image = [UIImage imageWithBorder:5 color:[UIColor purpleColor] image:[UIImage imageNamed:@"小清新"]];
    
}


@end
