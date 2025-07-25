//
//  MyViewControl.m
//  3GShare
//
//  Created by mac on 2025/7/21.
//

#import "MyViewControl.h"
#import "MyFirstTableViewCell.h"
#import "MySecondTableViewCell.h"
#import "SendViewController.h"
#import "RecommendViewController.h"
#import "SettingViewController.h"
#import "InformationViewController.h"

@interface MyViewControl ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation MyViewControl

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, [UIScreen mainScreen].bounds.size.height - 46) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsHorizontalScrollIndicator = YES;
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    [self.view addSubview:self.tableView];
    
    UINavigationBarAppearance *myAppearance = [[UINavigationBarAppearance alloc] init];
    myAppearance.backgroundColor = [UIColor colorWithRed:79/225.0f green:141/225.0f blue:198/225.0f alpha:1];
    myAppearance.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:24]};
    self.navigationController.navigationBar.scrollEdgeAppearance = myAppearance;
    self.navigationController.navigationBar.standardAppearance = myAppearance;
    
    UIBarButtonItem *btnLeft = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(pressLeft)];
    self.navigationItem.leftBarButtonItem = btnLeft;
    
    [self.tableView registerClass:[MyFirstTableViewCell class] forCellReuseIdentifier:@"MyFirstTableViewCell"];
    [self.tableView registerClass:[MySecondTableViewCell class] forCellReuseIdentifier:@"MySecondTableViewCell"];
}

-(void)pressLeft {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 180;
    } else {
        return 500;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10)];
        return view;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 5;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MyFirstTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MyFirstTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        MySecondTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MySecondTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.SendBlock = ^{
            SendViewController *sendVC = [[SendViewController alloc] init];
            sendVC.title = @"我的上传";
            [self.navigationController pushViewController:sendVC animated:YES];
        };
        
        cell.InformationBlock = ^{
            InformationViewController *informationVC= [[InformationViewController alloc] init];
            informationVC.title = @"我的信息";
            [self.navigationController pushViewController:informationVC animated:YES];
        };
        
        cell.RecommendBlock = ^{
            RecommendViewController *recommendVC = [[RecommendViewController alloc] init];
            recommendVC.title = @"我推荐的";
            [self.navigationController pushViewController:recommendVC animated:YES];
        };
        
        cell.SettingBlock = ^{
            SettingViewController *settingVC = [[SettingViewController alloc] init];
            settingVC.title = @"设置";
            [self.navigationController pushViewController:settingVC animated:YES];
        };
        
        cell.AlertBlock = ^{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"目前没有新内容！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        };
        
        return cell;
    }
}

@end
