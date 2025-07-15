//
//  VCRoot03.m
//  ZARA
//
//  Created by mac on 2025/7/15.
//

#import "VCRoot03.h"
#import "UserCell.h"
#import "UserInfoViewController.h"

@interface VCRoot03 ()

@end

@implementation VCRoot03

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人主页";
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"User" image:[UIImage systemImageNamed:@"person.circle"] tag:2];
    
    self.tableView.backgroundColor = [UIColor systemGroupedBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [self.tableView registerClass:[UserCell class] forCellReuseIdentifier:@"userInfo"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.menuItems = @[@"服务", @"收藏", @"朋友圈", @"卡包", @"设置"];
    self.menuIcons = @[
        [[UIImage systemImageNamed:@"checkmark.circle"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
        [[UIImage systemImageNamed:@"cube.box"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
        [[UIImage systemImageNamed:@"photo.on.rectangle"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
        [[UIImage systemImageNamed:@"creditcard"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
        [[UIImage systemImageNamed:@"gear"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
    ];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (section == 0) ? 1 : self.menuItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.section == 0) ? 100.0 : 50.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return (section == 1) ? 20.0 : 20.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *spacerView = [[UIView alloc] initWithFrame:CGRectZero];
        spacerView.backgroundColor = [UIColor systemGroupedBackgroundColor];
        return spacerView;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userInfo"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.imageView2.image = [UIImage imageNamed:@"头像.jpg"];
        cell.imageView2.frame = CGRectMake(20, 10, 80, 80);
        
        cell.label1.text = @"咕噜咕噜";
        cell.label1.frame = CGRectMake(110, 20, 200, 30);
        
        cell.label2.text = @"微信号：123456789";
        cell.label2.frame = CGRectMake(110, 55, 200, 20);
        
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.textLabel.text = self.menuItems[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIImage *icon = self.menuIcons[indexPath.row];
        CGSize itemSize = CGSizeMake(26, 26);
        UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0);
        [icon drawInRect:CGRectMake(0, 0, itemSize.width, itemSize.height)];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 0 && indexPath.row == 0) {
        UserInfoViewController *infoVC = [[UserInfoViewController alloc] init];
        [self.navigationController pushViewController:infoVC animated:YES];
    }
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
