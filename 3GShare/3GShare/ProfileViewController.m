//
//  ProfileViewController.m
//  3GShare
//
//  Created by mac on 2025/7/25.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()<UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation ProfileViewController

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
    
    NSArray *profiles = @[@{@"title":@"头像", @"tip":@" "},
                          @{@"title":@"昵称", @"tip":@"share小刘"},
                          @{@"title":@"签名", @"tip":@"开心了就笑，不开心了就过会儿再笑"},
                          @{@"title":@"性别", @"tip":@" "},
                          @{@"title":@"邮箱", @"tip":@"186####3@qq.com"}];
    
    for (int i = 0; i < 5; i++) {
        NSDictionary *profilesDict = profiles[i];
        
        if (i == 0) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 100)];
            view.backgroundColor = [UIColor whiteColor];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 45, 100, 20)];
            label.text = profilesDict[@"title"];
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:18];
            [view addSubview:label];
            
            UIImage *image = [UIImage imageNamed:@"假日.png"];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            imageView.frame = CGRectMake(screenWidth - 280, 10, 80, 80);
            [view addSubview:imageView];
            
            [self.tableView addSubview:view];
        } else if (i == 3) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 50 + i * 60, screenWidth, 50)];
            view.backgroundColor = [UIColor whiteColor];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 15, 100, 20)];
            label.text = profilesDict[@"title"];
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:18];
            [view addSubview:label];
            
            self.maleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.maleBtn setImage:[UIImage imageNamed:@"上.png"] forState:UIControlStateNormal];
            [self.maleBtn setImage:[UIImage imageNamed:@"下.png"] forState:UIControlStateSelected];
            self.maleBtn.frame = CGRectMake(screenWidth - 280, 15, 20, 20);
            self.maleBtn.tag = 0;
            [self.maleBtn addTarget:self action:@selector(pressBtn) forControlEvents:UIControlEventTouchUpInside];
            UILabel *male = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth - 250, 15, 30, 20)];
            male.text = @"男";
            male.textColor = [UIColor blackColor];
            male.font = [UIFont systemFontOfSize:16];
            
            [view addSubview:self.maleBtn];
            [view addSubview:male];
            
            self.femaleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.femaleBtn setImage:[UIImage imageNamed:@"下.png"] forState:UIControlStateNormal];
            [self.femaleBtn setImage:[UIImage imageNamed:@"上.png"] forState:UIControlStateSelected];
            self.femaleBtn.frame = CGRectMake(screenWidth - 200, 15, 20, 20);
            self.femaleBtn.tag = 1;
            [self.femaleBtn addTarget:self action:@selector(pressBtn) forControlEvents:UIControlEventTouchUpInside];
            UILabel *female = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth - 170, 15, 30, 20)];
            female.text = @"女";
            female.textColor = [UIColor blackColor];
            female.font = [UIFont systemFontOfSize:16];
            
            [view addSubview:female];
            [view addSubview:self.femaleBtn];
            
            [self.tableView addSubview:view];
        } else {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 50 + i * 60, screenWidth, 50)];
            view.backgroundColor = [UIColor whiteColor];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 15, 100, 20)];
            label.text = profilesDict[@"title"];
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:18];
            [view addSubview:label];
            
            UILabel *tip = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth - 280, 15, 280, 20)];
            tip.text = profilesDict[@"tip"];
            tip.textColor = [UIColor blackColor];
            tip.font = [UIFont systemFontOfSize:16];
            [view addSubview:tip];
            
            [self.tableView addSubview:view];
        }
    }
}

-(void)pressLeft {
    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden = NO;
}

-(void)pressBtn {
    self.maleBtn.selected = !self.maleBtn.selected;
    self.femaleBtn.selected = !self.femaleBtn.selected;
}

@end
