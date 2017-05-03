//
//  MyTableViewController.m
//  我的信息
//
//  Created by 黄永锐 on 2017/5/2.
//  Copyright © 2017年 LoveQi. All rights reserved.
//

#import "MyTableViewController.h"
#import "UIImage+image.h"

@interface MyTableViewController ()
/** 数组总数 */
@property (nonatomic, strong) NSMutableArray *groups;

@end

@implementation MyTableViewController

- (NSMutableArray *)groups{
    if (!_groups) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

//
- (void)viewDidLoad {
    [super viewDidLoad];
    //
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }else{
        
        return 2;
    }
}

//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"userInfo" ofType:@"plist"];
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text = @"头像";
                //
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
                //
                UIImage *image = [UIImage imageWithBorder:1 color:[UIColor lightGrayColor] image:[UIImage imageNamed:dict[@"headerImageName"]]];
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, 40, 40)];
                imageView.image = image;
                //
                [view addSubview:imageView];
                //
                UIImageView *iv2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
                iv2.frame = CGRectMake(50, 14, iv2.bounds.size.width, iv2.bounds.size.height);
                [view addSubview:iv2];
                
                cell.accessoryView = view;
                break;
            }
            case 1:
                cell.textLabel.text = @"昵称";
                cell.detailTextLabel.text = dict[@"nickName"];
                break;
            case 2:
                cell.textLabel.text = @"性别";
                cell.detailTextLabel.text = dict[@"sex"];
                break;
            case 3:
                cell.textLabel.text = @"生日";
                cell.detailTextLabel.text = dict[@"birthday"];
                break;
            case 4:
                cell.textLabel.text = @"修改密码";
                break;
                
            default:
                break;
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        NSLog(@"======%@",NSStringFromCGRect(cell.accessoryView.frame));
    
        
        
    }else{
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"wx"];
            cell.textLabel.text = @"微信";
            
        }else{
            cell.imageView.image = [UIImage imageNamed:@"QQ"];
            cell.textLabel.text = @"QQ";
        }
    }
    
    
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
