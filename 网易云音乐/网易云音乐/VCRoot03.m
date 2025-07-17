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

@interface VCRoot03 ()<UITableViewDelegate, UITableViewDataSource, AvatarDelegate, MyCellDelegate, UIScrollViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIImageView *bgImageView;
@property(nonatomic, strong) UIButton *avatarButton;
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
    //headerView:用来放置整个表格顶部的整体视图,固定在最上方的自定义view
    self.tableView.tableHeaderView = headerView;
    self.titles = @[@"音乐", @"播客", @"笔记"];
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:self.titles];
    self.segmentedControl.selectedSegmentIndex = 0;
    [self.segmentedControl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    self.segmentedControl.frame = CGRectMake(0, headerView.frame.size.height - 650, screenWidth, 40);
    [headerView addSubview:self.segmentedControl];
    

    
    CGFloat songListTop = CGRectGetMaxY(self.segmentedControl.frame) + 10;
    NSArray *songs = @[
      @{@"title": @"三年二班", @"artist": @"白景屹", @"image": @"cover1", @"collected": @NO},
      @{@"title": @"我们的明天", @"artist": @"鹿晗", @"image": @"cover2", @"collected": @NO},
      @{@"title": @"杨过", @"artist": @"Vinz-T", @"image": @"cover3", @"collected": @NO},
      @{@"title": @"Head In The Clouds", @"artist": @"Hayd-Changes-EP", @"image": @"cover4", @"collected": @NO},
      @{@"title": @"青火", @"artist": @"黄子弘凡", @"image": @"cover5", @"collected": @NO}
    ];
    CGFloat songViewHeight = 80;
    for (int i = 0; i < songs.count; i++) {
        NSDictionary *song = songs[i];
        UIView *songView = [[UIView alloc] initWithFrame:CGRectMake(0, songListTop + i * songViewHeight, screenWidth, songViewHeight)];
        UIImageView *cover = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 60, 60)];
        cover.image = [UIImage imageNamed:song[@"image"]];
        cover.layer.cornerRadius = 4;
        cover.clipsToBounds = YES;
        [songView addSubview:cover];
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(85, 15, screenWidth - 150, 22)];
        title.text = song[@"title"];
        title.font = [UIFont boldSystemFontOfSize:14];
        title.textColor = [UIColor whiteColor];
        [songView addSubview:title];
        UILabel *artist = [[UILabel alloc] initWithFrame:CGRectMake(85, 38, screenWidth - 150, 20)];
        artist.text = song[@"artist"];
        artist.textColor = [UIColor lightGrayColor];
        artist.font = [UIFont systemFontOfSize:12];
        [songView addSubview:artist];
        UIButton *heartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        heartButton.frame = CGRectMake(screenWidth - 40, 28, 24, 24);
        [heartButton setImage:[UIImage imageNamed:@"不喜欢.png"] forState:UIControlStateNormal];
        [heartButton setImage:[UIImage imageNamed:@"喜欢.png"] forState:UIControlStateSelected];
        heartButton.tag = i;
        [heartButton addTarget:self action:@selector(toggleFavorite:) forControlEvents:UIControlEventTouchUpInside];
        [songView addSubview:heartButton];
        
        [headerView addSubview:songView];
    }
    CGFloat totalSongListHeight = songListTop + songs.count * songViewHeight + 20;
    CGRect headerFrame = headerView.frame;
    headerFrame.size.height = totalSongListHeight;
    headerView.frame = headerFrame;
    self.bgImageView.frame = headerView.bounds;

    
    
    //立刻执行刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleThemeChange:) name:@"SwitchChanged" object:nil];
}

-(void)handleThemeChange:(NSNotification*)notification {
    NSDictionary *userInfo = notification.userInfo;
    BOOL isDark = [userInfo[@"switch"] boolValue];
    if (isDark) {
        self.view.backgroundColor = [UIColor grayColor];
        self.tableView.backgroundColor = [UIColor grayColor];
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
        self.tableView.backgroundColor = [UIColor whiteColor];
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
    if (tableView == self.musicView) {
        return 5;
    } else if (tableView == self.postView) {
        return 6;
    }
    else if (tableView == self.noteView) {
        return 7;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 1000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"MyCell";
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    return cell;
}


- (void)segmentChanged:(UISegmentedControl *)seg {
    switch (seg.selectedSegmentIndex) {
        case 0:
            self.contentView = self.musicView;
            break;
        case 1:
            self.contentView = self.postView;
            break;
        case 2:
            self.contentView = self.noteView;
            break;
    }
    [self.tableView reloadData];
}

-(void)pressMore {
    MoreView *mv = [[MoreView alloc] init];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 */
@end

