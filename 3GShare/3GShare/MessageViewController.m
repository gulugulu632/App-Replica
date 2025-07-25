//
//  MessageViewController.m
//  3GShare
//
//  Created by mac on 2025/7/24.
//

#import "MessageViewController.h"
#import "TalkViewController.h"

@interface MessageViewController ()<UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, [UIScreen mainScreen].bounds.size.height - 46) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.showsHorizontalScrollIndicator = YES;
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    [self.view addSubview:self.tableView];
    
    UINavigationBarAppearance *MessageAppearance = [[UINavigationBarAppearance alloc] init];
    MessageAppearance.backgroundColor = [UIColor colorWithRed:79/225.0f green:141/225.0f blue:198/225.0f alpha:1];
    MessageAppearance.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:24]};
    self.navigationController.navigationBar.scrollEdgeAppearance = MessageAppearance;
    self.navigationController.navigationBar.standardAppearance = MessageAppearance;
    
    UIBarButtonItem *btnLeft = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(pressLeft)];
    self.navigationItem.leftBarButtonItem = btnLeft;
    
    NSArray *messages = @[@{@"title":@"share小格", @"image":@"WechatIMG1.jpg", @"tip":@"你的作品我很喜欢！！", @"time":@"11-03 09:45"},
    @{@"title":@"share小雪", @"image":@"WechatIMG3.jpg", @"tip":@"谢谢，已关注你", @"time":@"11-03 10:20"},
    @{@"title":@"share小草", @"image":@"WechatIMG4.jpg", @"tip":@"为你点赞！", @"time":@"11-03 10:23"},
    @{@"title":@"share小猪", @"image":@"WechatIMG5.jpg", @"tip":@"你好可以问问你是怎么拍的吗？", @"time":@"11-03 11:20"}];
    
    for (int i = 0; i < 4; i++) {
        NSDictionary *messagesDict = messages[i];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, i * 100, screenWidth, 90)];
        view.backgroundColor = [UIColor whiteColor];
        
        UIImage *image = [UIImage imageNamed:messagesDict[@"image"]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(20, 14, 70, 70);
        [view addSubview:imageView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 100, 20)];
        titleLabel.text = messagesDict[@"title"];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:18];
        [view addSubview:titleLabel];
        
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 250, 20)];
        tipLabel.text = messagesDict[@"tip"];
        tipLabel.textColor = [UIColor colorWithRed:79/225.0f green:141/225.0f blue:198/225.0f alpha:1];
        tipLabel.font = [UIFont systemFontOfSize:16];
        [view addSubview:tipLabel];
        
        UILabel *TimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth - 120, 20, 100, 20)];
        TimeLabel.text = messagesDict[@"time"];
        TimeLabel.textColor = [UIColor grayColor];
        TimeLabel.font = [UIFont systemFontOfSize:14];
        [view addSubview:TimeLabel];
        
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
    if (view.tag == 1) {
        TalkViewController *talkVC = [[TalkViewController alloc] init];
        talkVC.title = @"与share小雪的对话";
        [self.navigationController pushViewController:talkVC animated:YES];
    }
}

@end
