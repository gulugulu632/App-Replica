//
//  PostView.m
//  网易云音乐
//
//  Created by mac on 2025/7/18.
//

#import "PostCell.h"
#import "PostView.h"

@interface PostView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *songs;
@end

@implementation PostView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐播客";
    self.view.backgroundColor = [UIColor whiteColor];

    self.songs = @[
        @{@"title": @"悦光讲故事之不眠之夜", @"artist": @"每晚陪你入睡的鬼故事", @"image": @"cover6", @"collected": @NO},
        @{@"title": @"搞钱学姐", @"artist": @"正在采访100个女孩的搞钱故事", @"image": @"cover7", @"collected": @NO},
        @{@"title": @"小fool人", @"artist": @"一档女脱口秀演员集体制作的播客", @"image": @"cover8", @"collected": @NO},
        @{@"title": @"焦虑自救手册", @"artist": @"不焦虑，不抑郁，不内耗！", @"image": @"cover9", @"collected": @NO}
    ];

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[PostCell class] forCellReuseIdentifier:@"PostCell"];
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleThemeChange:) name:@"SwitchChanged" object:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    NSDictionary *song = self.songs[indexPath.row];
    [cell setupPost:song];
    return cell;
}

- (void)handleThemeChange:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    BOOL isDark = [userInfo[@"switch"] boolValue];
    if (isDark) {
        self.tableView.backgroundColor = [UIColor grayColor];
    } else {
        self.tableView.backgroundColor = [UIColor whiteColor];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
