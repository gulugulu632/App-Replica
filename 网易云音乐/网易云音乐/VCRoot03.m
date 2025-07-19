//
//  VCRoot03.m
//  网易云音乐
//
//  Created by mac on 2025/7/15.
//

#import "VCRoot03.h"
#import "MyCell.h"
#import "AvatarChangeController.h"
#import "MoreView.h"
#import "MusicCell.h"
#import "NoteCell.h"
#import "PostCell.h"
#import "MusicView.h"
#import "PostView.h"
#import "NoteView.h"

@interface VCRoot03 ()<UITableViewDelegate, UITableViewDataSource, AvatarDelegate, MyCellDelegate, UIScrollViewDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIImageView *bgImageView;
@property(nonatomic, strong) UIButton *avatarButton;
@property(nonatomic, strong) UISegmentedControl *segmentedControl;
@property(nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) MusicCell *musicCell;
@property (nonatomic, strong) PostCell *postCell;
@property (nonatomic, strong) NoteCell *noteCell;

@end

@implementation VCRoot03

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    UIBarButtonItem *moreItem = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"line.3.horizontal"] style:UIBarButtonItemStylePlain target:self action:@selector(pressMore)];
    moreItem.tintColor = [UIColor redColor];
    self.navigationItem.leftBarButtonItem = moreItem;
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"搜索.png"] style:UIBarButtonItemStylePlain target:self action:@selector(pressSearch)];
    searchItem.tintColor = [UIColor redColor];
    UIBarButtonItem *AdditonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"更多.png"] style:UIBarButtonItemStylePlain target:self action:@selector(pressMore)];
    AdditonItem.tintColor = [UIColor redColor];
    self.navigationItem.rightBarButtonItems = @[searchItem, AdditonItem];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[MyCell class] forCellReuseIdentifier:@"MyCell"];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    
    //放到一个容器里
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 900)];
    headerView.backgroundColor = [UIColor clearColor];
    
    self.bgImageView = [[UIImageView alloc] initWithFrame:headerView.bounds];
    self.bgImageView.image = [UIImage imageNamed:@"背景.jpg"];
    self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.bgImageView.clipsToBounds = YES;
    [headerView addSubview:self.bgImageView];
    
    self.avatarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.avatarButton.frame = CGRectMake(screenWidth/2 - 40, 50, 80, 80);
    [self.avatarButton setImage:[UIImage imageNamed:@"头像.jpg"] forState:UIControlStateNormal];
    self.avatarButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.avatarButton.layer.cornerRadius = 40;
    self.avatarButton.clipsToBounds = YES;
    [self.avatarButton addTarget:self action:@selector(pressAvatar) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:self.avatarButton];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, screenWidth, 30)];
    nameLabel.text = @"Daaannna";
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = [UIFont boldSystemFontOfSize:18];
    nameLabel.textColor = [UIColor whiteColor];
    [headerView addSubview:nameLabel];
    
    NSArray *arr = @[@"26", @"关注", @"20", @"粉丝", @"Lv.8", @"940", @"小时"];
    UIFont *boldFont = [UIFont boldSystemFontOfSize:16];
    UIFont *normalFont = [UIFont systemFontOfSize:14];
    for (int i = 0; i < 7; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.text = arr[i];
        label.textColor = [UIColor whiteColor];
        if (i == 0 || i == 2 || i == 4 || i == 5) {
            label.font = boldFont;
        } else {
            label.font = normalFont;
        }
        [label sizeToFit];
        label.frame = CGRectMake(70 + i * 40, 150, screenWidth, 20);
        [headerView addSubview:label];
    }
    
    NSArray *titles = @[@"最近", @"本地", @"网盘", @"装扮", @"更多"];
    NSArray *icons = @[@"最近.png", @"本地.png", @"网盘.png", @"装扮.png", @"更多主页.png"];
    for (int i = 0; i < 5; i++) {
        UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(10 + i * 80, 180, 60, 70)];
        btnView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.15];
        btnView.layer.cornerRadius = 10;
        UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(18, 10, 24, 24)];
        iconView.image = [UIImage imageNamed:icons[i]];
        iconView.tintColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 38, 60, 20)];
        label.text = titles[i];
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        [btnView addSubview:iconView];
        [btnView addSubview:label];
        [headerView addSubview:btnView];
    }
    
    self.titles = @[@"音乐", @"播客", @"笔记"];
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:self.titles];
    self.segmentedControl.selectedSegmentIndex = 0;
    [self.segmentedControl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    self.segmentedControl.frame = CGRectMake(0, headerView.frame.size.height - 650, screenWidth, 40);
    [headerView addSubview:self.segmentedControl];
    
    [self.tableView registerClass:[MusicCell class] forCellReuseIdentifier:@"MusicCell"];
    [self.tableView registerClass:[PostCell class] forCellReuseIdentifier:@"PostCell"];
    [self.tableView registerClass:[NoteCell class] forCellReuseIdentifier:@"NoteCell"];
    
    //预加载
    self.musicCell = [[MusicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MusicCell"];
    self.postCell = [[PostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PostCell"];
    self.noteCell = [[NoteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NoteCell"];
    
    CGRect headerFrame = headerView.frame;//获取当前的
    headerView.frame = CGRectMake(0, 0, screenWidth, 850);
    headerView.frame = headerFrame;//修改后的赋给当前的
    self.bgImageView.frame = headerView.bounds;

    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 300, screenWidth, 900)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(screenWidth * 3, 900);
    [headerView addSubview:self.scrollView];

    MusicView *musicVC = [[MusicView alloc] init];
    [self addChildViewController:musicVC];
    musicVC.view.frame = CGRectMake(0, 0, screenWidth, 900);
    [self.scrollView addSubview:musicVC.view];

    PostView *postVC = [[PostView alloc] init];
    [self addChildViewController:postVC];
    postVC.view.frame = CGRectMake(screenWidth, 0, screenWidth, 900);
    [self.scrollView addSubview:postVC.view];

    NoteView *noteVC = [[NoteView alloc] init];
    [self addChildViewController:noteVC];
    noteVC.view.frame = CGRectMake(screenWidth * 2, 0, screenWidth, 900);
    [self.scrollView addSubview:noteVC.view];

    self.tableView.tableHeaderView = headerView;

    
    headerView.userInteractionEnabled = YES;
    self.scrollView.userInteractionEnabled = YES;

    //立刻执行刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleThemeChange:) name:@"SwitchChanged" object:nil];
}

-(void)handleThemeChange:(NSNotification*)notification {
    NSDictionary *userInfo = notification.userInfo;
    BOOL isDark = [userInfo[@"switch"] boolValue];
    if (isDark) {
        self.view.backgroundColor = [UIColor grayColor];
        self.tableView.backgroundColor = [UIColor grayColor];
//        MoreView *mv = [[MoreView alloc] init];
//        mv.switchOn = YES;
//        [self presentViewController:mv animated:YES completion:nil];
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
        self.tableView.backgroundColor = [UIColor whiteColor];
//        MoreView *mv = [[MoreView alloc] init];
//        mv.switchOn = NO;
//        [self presentViewController:mv animated:YES completion:nil];
    }
    [self.tableView reloadData];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.translucent = YES;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < 0) {
        CGFloat scale = fabs(offsetY);//表格滚动的垂直偏移量
        CGRect frame = self.bgImageView.frame;//当前背景大小
        frame.origin.y = offsetY;
        frame.size.height = 250 + scale;
        self.bgImageView.frame = frame;
    }
}

//MyCellDelegate
- (void)didTapAvatarInCell:(MyCell *)cell {
    AvatarChangeController *ac = [[AvatarChangeController alloc] init];
    ac.delegate = self;
    [self.navigationController pushViewController:ac animated:YES];
}

- (void)ChangePhoto:(UIImage *)image {
    [self.avatarButton setImage:image forState:UIControlStateNormal];
}

//AvatarDelegate
- (void)pressAvatar {
    AvatarChangeController *ac = [[AvatarChangeController alloc] init];
    ac.delegate = self;
    [self.navigationController pushViewController:ac animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        return 1;
    } else if (self.segmentedControl.selectedSegmentIndex == 1) {
        return 2;
    } else if (self.segmentedControl.selectedSegmentIndex == 2) {
        return 1;
    } else {
        return 0;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.segmentedControl.selectedSegmentIndex) {
        case 0: {
            return self.musicCell;
        }
        case 1: {
            return self.postCell;
        }
        case 2: {
            return self.noteCell;
        }
        default:
            return [[UITableViewCell alloc] init];
    }
}

- (void)segmentChanged:(UISegmentedControl *)sender {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    NSInteger index = sender.selectedSegmentIndex;
    CGPoint offset = CGPointMake(index * screenWidth, 0);
    [self.scrollView setContentOffset:offset animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    NSInteger index = scrollView.contentOffset.x / screenWidth;
    self.segmentedControl.selectedSegmentIndex = index;
}

-(void)pressMore {
    MoreView *mv = [[MoreView alloc] init];
//    if (mv.view.backgroundColor = [UIColor grayColor]) {
//        mv.switchOn = YES;
//    } else {
//        mv.switchOn = NO;
//    }
//    BOOL isNight = [[NSUserDefaults standardUserDefaults] boolForKey:@"NightMode"];
//    if (!isNight) {
//        mv.switchOn = NO;
//    } else {
//        mv.switchOn = YES;
//    }
//    [self.tableView reloadData];
    [self presentViewController:mv animated:YES completion:nil];
}

- (void)toggleFavorite:(UIButton *)sender {
    sender.selected = !sender.selected;
}

-(void)pressSearch {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 */
@end
