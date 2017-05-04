//
//  MyTableViewController.m
//  相机与相册
//
//  Created by 黄永锐 on 2017/5/3.
//  Copyright © 2017年 LoveQi. All rights reserved.
//

#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif


#import "MyTableViewController.h"

@interface MyTableViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation MyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.navigationItem.title = @"相册与相机";
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    if (0 == indexPath.row) {
        cell.textLabel.text = @"系统相册";
    }else if (1 == indexPath.row){
        cell.textLabel.text = @"调用相机";
    }else{
        cell.textLabel.text = @"库";
    }
    
    return cell;
}


#pragma mark -UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UIImagePickerController *pickerVC = [[UIImagePickerController alloc] init];
    
    if (0 == indexPath.row) {
        //从系统相册中选择一张图片
        //弹出系统相册
        
        //设置照片的来源
        pickerVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
       
    }else if (1 == indexPath.row){
        //调用相机
        //设置照片的来源
        
        //判断是真机 还是 模拟器
        if (TARGET_IPHONE_SIMULATOR) {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"该设备不支持相机功能" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //
                NSLog(@"点击了确定按钮");
            }]];
            
            [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //
                NSLog(@"点击了取消按钮");
            }]];
            
            //
            [self presentViewController:alertVC animated:YES completion:nil];
            

        }else{
        
           //如果是真机 就设置照片的来源
            pickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        
        
    }else {
        //设置照片的来源
        pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    }
    
    pickerVC.delegate = self;
    //modal出系统相册
    [self presentViewController:pickerVC animated:YES completion:nil];
    
}


#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"取消保存");
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    NSLog(@"info:%@",info);
    
    UIImage *selectImage = info[UIImagePickerControllerOriginalImage];
    NSData *data = UIImageJPEGRepresentation(selectImage, 1);
    BOOL successful = [data writeToFile:@"/Users/huangyongrui/Desktop/test.png" atomically:YES];
    if (successful) {
        NSLog(@"选择照片保存成功");
    }else{
        NSLog(@"保存失败");
    }
    
    //保存图片到相册
    //UIImageWriteToSavedPhotosAlbum(selectImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    [self dismissViewControllerAnimated:YES completion:nil];
}

//保存完毕时候调用
-(void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    if(error == nil){
        NSLog(@"相片已经保存到相册库了");
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo{
//    NSLog(@"过期的方法---%s---%d",__FUNCTION__,__LINE__);
//}

/*

-(UIView *)findView:(UIView *)aView withName:(NSString *)name{
    Class cl = [aView class];
    NSString *desc = [cl description];
    
    if ([name isEqualToString:desc])
        return aView;
    
    for (NSUInteger i = 0; i < [aView.subviews count]; i++)
    {
        UIView *subView = [aView.subviews objectAtIndex:i];
        subView = [self findView:subView withName:name];
        if (subView)
            return subView;
    }
    return nil;
}
-(void)addSomeElements:(UIViewController *)viewController{
    
    
    UIView *PLCameraView=[self findView:viewController.view withName:@"PLCameraView"];
    UIView *bottomBar=[self findView:PLCameraView withName:@"PLCropOverlayBottomBar"];
    UIImageView *bottomBarImageForSave = [bottomBar.subviews objectAtIndex:0];
    UIButton *retakeButton=[bottomBarImageForSave.subviews objectAtIndex:0];
    [retakeButton setTitle:@"重拍" forState:UIControlStateNormal];  //左下角按钮
    UIButton *useButton=[bottomBarImageForSave.subviews objectAtIndex:1];
    [useButton setTitle:@"上传" forState:UIControlStateNormal];  //右下角按钮
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    [self addSomeElements:viewController];
}
 
 */



@end





