//
//  SettingViewController.m
//  3GShare
//
//  Created by mac on 2025/7/24.
//

#import "SettingViewController.h"

@interface SettingViewController ()<UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, screenWidth, [UIScreen mainScreen].bounds.size.height - 170) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsHorizontalScrollIndicator = YES;
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    [self.view addSubview:self.tableView];
    
    UINavigationBarAppearance *SettingAppearance = [[UINavigationBarAppearance alloc] init];
    SettingAppearance.backgroundColor = [UIColor colorWithRed:79/225.0f green:141/225.0f blue:198/225.0f alpha:1];
    SettingAppearance.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:24]};
    self.navigationController.navigationBar.scrollEdgeAppearance = SettingAppearance;
    self.navigationController.navigationBar.standardAppearance = SettingAppearance;
    
    UIBarButtonItem *btnLeft = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(pressLeft)];
    self.navigationItem.leftBarButtonItem = btnLeft;
    
    NSArray *title = @[@"基本资料", @"修改密码", @"消息设置", @"关于SHARE", @"消息缓存"];
    
    for (int i = 0; i < 5; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, i * 60, screenWidth, 50)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 15, 100, 20)];
        label.text = title[i];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:18];
        [view addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(screenWidth - 100, 14, 20, 20);
        [button setImage:[UIImage imageNamed:@"进入.png"] forState:UIControlStateNormal];
        [view addSubview:button];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressTap:)];
        view.tag = i;
        [view addGestureRecognizer:tap];
        
        [self.tableView addSubview:view];
    }
}

-(void)pressLeft {
    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden = NO;
}

-(void)pressTap:(UITapGestureRecognizer*)tap {
    UIView *view = tap.view;
    if (view.tag == 0) {
        self.profileVC = [[ProfileViewController alloc] init];
        self.profileVC.title = @"基本资料";
        [self.navigationController pushViewController:self.profileVC animated:YES];
    } else if (view.tag == 1) {
        self.passwordChangeVC = [[PasswordChangeViewController alloc] init];
        self.passwordChangeVC.title = @"修改密码";
        [self.navigationController pushViewController:self.passwordChangeVC animated:YES];
    } else if (view.tag == 2) {
        if (!self.newsSettingVC) {
            self.newsSettingVC = [[NewsSettingViewController alloc] init];
            self.newsSettingVC.title = @"消息设置";
        }
        [self.navigationController pushViewController:self.newsSettingVC animated:YES];
    } else if (view.tag == 4) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"缓存已清除" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(updateTimer:) userInfo:nil repeats:NO];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"目前没有新内容！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

-(void)updateTimer:(NSTimer*)timer {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
