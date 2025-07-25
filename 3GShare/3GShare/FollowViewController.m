//
//  FollowViewController.m
//  3GShare
//
//  Created by mac on 2025/7/24.
//

#import "FollowViewController.h"

@interface FollowViewController ()<UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation FollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, [UIScreen mainScreen].bounds.size.height - 46) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.showsHorizontalScrollIndicator = YES;
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    [self.view addSubview:self.tableView];
    
    UINavigationBarAppearance *FollowAppearance = [[UINavigationBarAppearance alloc] init];
    FollowAppearance.backgroundColor = [UIColor colorWithRed:79/225.0f green:141/225.0f blue:198/225.0f alpha:1];
    FollowAppearance.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:24]};
    self.navigationController.navigationBar.scrollEdgeAppearance = FollowAppearance;
    self.navigationController.navigationBar.standardAppearance = FollowAppearance;
    
    UIBarButtonItem *btnLeft = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(pressLeft)];
    self.navigationItem.leftBarButtonItem = btnLeft;
    
    NSArray *follows = @[@{@"title":@"share小格", @"image":@"WechatIMG1.jpg"},
                         @{@"title":@"share小兰", @"image":@"WechatIMG2.jpg"},
                         @{@"title":@"share小雪", @"image":@"WechatIMG3.jpg"},
                         @{@"title":@"share小草", @"image":@"WechatIMG4.jpg"},
                         @{@"title":@"share小猪", @"image":@"WechatIMG5.jpg"},
                         @{@"title":@"share小花", @"image":@"WechatIMG6.jpg"}];
    
    for (int i = 0; i < 6; i++) {
        NSDictionary *followsDict = follows[i];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, i * 100, screenWidth, 90)];
        view.backgroundColor = [UIColor whiteColor];
        
        UIImage *image = [UIImage imageNamed:followsDict[@"image"]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(20, 14, 70, 70);
        [view addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 35, 100, 20)];
        label.text = followsDict[@"title"];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:18];
        [view addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(screenWidth - 120, 25, 100, 40);
        [button setImage:[UIImage imageNamed:@"未关注.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"已关注.png"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        [self.tableView addSubview:view];
    }
}

-(void)pressLeft {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)pressBtn:(UIButton*) button {
    button.selected = !button.selected;
}

@end
