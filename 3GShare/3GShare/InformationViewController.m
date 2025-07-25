//
//  InformationViewController.m
//  3GShare
//
//  Created by mac on 2025/7/24.
//

#import "InformationViewController.h"
#import "MessageViewController.h"

@interface InformationViewController ()<UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, [UIScreen mainScreen].bounds.size.height - 46) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.showsHorizontalScrollIndicator = YES;
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    [self.view addSubview:self.tableView];
    
    UINavigationBarAppearance *InformationAppearance = [[UINavigationBarAppearance alloc] init];
    InformationAppearance.backgroundColor = [UIColor colorWithRed:79/225.0f green:141/225.0f blue:198/225.0f alpha:1];
    InformationAppearance.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:24]};
    self.navigationController.navigationBar.scrollEdgeAppearance = InformationAppearance;
    self.navigationController.navigationBar.standardAppearance = InformationAppearance;
    
    UIBarButtonItem *btnLeft = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(pressLeft)];
    self.navigationItem.leftBarButtonItem = btnLeft;
    
    NSArray *informations = @[@{@"title":@"评论", @"count":@(7), @"button":@"进入.png"},
                          @{@"title":@"推荐我的", @"count":@(9), @"button":@"进入.png"},
                          @{@"title":@"新关注的", @"count":@(5), @"button":@"进入.png"},
                          @{@"title":@"私信", @"count":@(4), @"button":@"进入.png"},
                          @{@"title":@"活动通知", @"count":@(1), @"button":@"进入.png"}];
    
    for (int i = 0; i < 5; i++) {
        NSDictionary *informationsDict = informations[i];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, i * 60, screenWidth, 50)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 15, 100, 20)];
        label.text = informationsDict[@"title"];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:18];
        [view addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(screenWidth - 100, 14, 20, 20);
        [button setImage:[UIImage imageNamed:informationsDict[@"button"]] forState:UIControlStateNormal];
        [view addSubview:button];
        
        UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth - 50, 14, 20, 20)];
        countLabel.text = [informationsDict[@"count"] stringValue];
        countLabel.textColor = [UIColor colorWithRed:79/225.0f green:141/225.0f blue:198/225.0f alpha:1];
        countLabel.font = [UIFont systemFontOfSize:18];
        [view addSubview:countLabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressTap:)];
        view.tag = i;
        [view addGestureRecognizer:tap];
        
        [self.tableView addSubview:view];
    }
}

-(void)pressLeft {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)pressTap:(UITapGestureRecognizer*)tap {
    UIView *view = tap.view;
    if (view.tag == 2) {
        if (!self.followVC) {
            self.followVC = [[FollowViewController alloc] init];
            self.followVC.title = @"新关注的";
        }
        [self.navigationController pushViewController:self.followVC animated:YES];
    } else if (view.tag == 3) {
        MessageViewController *messageVC = [[MessageViewController alloc] init];
        messageVC.title = @"私信";
        [self.navigationController pushViewController:messageVC animated:YES];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"目前没有新内容！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
