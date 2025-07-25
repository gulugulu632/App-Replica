//
//  NewsSettingViewController.m
//  3GShare
//
//  Created by mac on 2025/7/25.
//

#import "NewsSettingViewController.h"

@interface NewsSettingViewController ()<UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation NewsSettingViewController

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
    
    NSArray *title = @[@"接收新消息通知", @"通知显示栏", @"声音", @"振动", @"关注更新"];
    
    for (int i = 0; i < 5; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, i * 60, screenWidth, 50)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 150, 20)];
        label.text = title[i];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:18];
        [view addSubview:label];
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.frame = CGRectMake(screenWidth - 100, 14, 20, 20);
        [self.button setImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
        [self.button setImage:[UIImage imageNamed:@"选中.png"] forState:UIControlStateSelected];
        [self.button addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:self.button];
        
        [self.tableView addSubview:view];
    }
}

-(void)pressLeft {
    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden = NO;
}

-(void)pressBtn:(UIButton*) button {
    button.selected = !button.selected;
}

@end
