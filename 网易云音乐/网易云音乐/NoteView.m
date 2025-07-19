//
//  NoteView.m
//  网易云音乐
//
//  Created by mac on 2025/7/18.
//

#import "NoteView.h"
#import "NoteCell.h"

@interface NoteView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *songs;
@end

@implementation NoteView

- (void)viewDidLoad {
    [super viewDidLoad];

    self.songs = @[
      @{@"title": @"三年二班", @"artist": @"白景屹", @"image": @"cover1", @"collected": @NO},
      @{@"title": @"我们的明天", @"artist": @"鹿晗", @"image": @"cover2", @"collected": @NO}
    ];

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[NoteCell class] forCellReuseIdentifier:@"NoteCell"];
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleThemeChange:) name:@"SwitchChanged" object:nil];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NoteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoteCell" forIndexPath:indexPath];
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


