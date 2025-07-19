//
//  MusicView.m
//  网易云音乐
//
//  Created by mac on 2025/7/18.
//

#import "MusicView.h"
#import "MusicCell.h"

@interface MusicView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *songs;
@end

@implementation MusicView

- (void)viewDidLoad {
    [super viewDidLoad];

    self.songs = @[
      @{@"title": @"三年二班", @"artist": @"白景屹", @"image": @"cover1", @"collected": @NO},
      @{@"title": @"我们的明天", @"artist": @"鹿晗", @"image": @"cover2", @"collected": @NO},
      @{@"title": @"杨过", @"artist": @"Vinz-T", @"image": @"cover3", @"collected": @NO},
      @{@"title": @"Head In The Clouds", @"artist": @"Hayd-Changes-EP", @"image": @"cover4", @"collected": @NO},
      @{@"title": @"青火", @"artist": @"黄子弘凡", @"image": @"cover5", @"collected": @NO}
    ];

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[MusicCell class] forCellReuseIdentifier:@"MusicCell"];
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleThemeChange:) name:@"SwitchChanged" object:nil];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MusicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicCell" forIndexPath:indexPath];
    NSDictionary *song = self.songs[indexPath.row];
    [cell setupSong:song]; 
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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

