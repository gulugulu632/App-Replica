//
//  ActivityViewControl.m
//  3GShare
//
//  Created by mac on 2025/7/21.
//

#import "ActivityViewControl.h"

@interface ActivityViewControl ()<UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation ActivityViewControl

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, [UIScreen mainScreen].bounds.size.height - 46) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.showsHorizontalScrollIndicator = YES;
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    [self.view addSubview:self.tableView];
    
    UINavigationBarAppearance *activityAppearance = [[UINavigationBarAppearance alloc] init];
    activityAppearance.backgroundColor = [UIColor colorWithRed:79/225.0f green:141/225.0f blue:198/225.0f alpha:1];
    activityAppearance.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:24]};
    self.navigationController.navigationBar.scrollEdgeAppearance = activityAppearance;
    self.navigationController.navigationBar.standardAppearance = activityAppearance;
    
    UIBarButtonItem *btnLeft = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(pressLeft)];
    self.navigationItem.leftBarButtonItem = btnLeft;
    
    for (int i = 0; i < 3; i++) {
        NSString *imageName = [NSString stringWithFormat:@"活动%d.png", i + 1];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(10, 10 + i * 210, screenWidth - 20, 200);
        [self.tableView addSubview:imageView];
    }
}

-(void)pressLeft {
    
}

@end
