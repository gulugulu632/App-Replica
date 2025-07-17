//
//  OtherCell.m
//  网易云音乐
//
//  Created by mac on 2025/7/15.
//

#import "OtherCell.h"

@implementation OtherCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleThemeChange:) name:@"SwitchChange" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleThemeChange:) name:@"SwitchChanged" object:nil];
//
//                // 初始化时主动设置主题颜色
//                BOOL isDark = [[NSUserDefaults standardUserDefaults] boolForKey:@"NightMode"];
//                [self handleThemeChange:[NSNotification notificationWithName:@"SwitchChanged" object:nil userInfo:@{@"switch": @(isDark)}]];
        [self setupFavoriteSongs];
    }
    return self;
}


- (void)handleThemeChange:(NSNotification *)notification {
    BOOL isDark = [notification.userInfo[@"switch"] boolValue];
    if (isDark) {
        self.contentView.backgroundColor = [UIColor grayColor];
        self.backgroundColor = [UIColor grayColor];
    } else {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupFavoriteSongs {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame = CGRectMake(15, 10, screenWidth - 30, 30);
    self.titleLabel.text = @"根据你喜爱的歌曲推荐";
    self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.contentView addSubview:self.titleLabel];
    //一个NSArray包含五个字典
    NSArray *songs = @[
      @{@"title": @"三年二班", @"artist": @"白景屹", @"image": @"cover1", @"collected": @NO},
      @{@"title": @"我们的明天", @"artist": @"鹿晗", @"image": @"cover2", @"collected": @NO},
      @{@"title": @"杨过", @"artist": @"Vinz-T", @"image": @"cover3", @"collected": @NO},
      @{@"title": @"Head In The Clouds", @"artist": @"Hayd-Changes-EP", @"image": @"cover4", @"collected": @NO},
      @{@"title": @"青火", @"artist": @"黄子弘凡", @"image": @"cover5", @"collected": @NO}
    ];
    for (int i = 0; i < 5; i++) {
        NSDictionary *song = songs[i];
        UIView *songView = [[UIView alloc] initWithFrame:CGRectMake(0, 50 + i * 80, screenWidth, 80)];
        UIImageView *cover = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 60, 60)];
        cover.image = [UIImage imageNamed:song[@"image"]];
        cover.layer.cornerRadius = 4;
        cover.clipsToBounds = YES;
        [songView addSubview:cover];//超出被裁
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(85, 15, screenWidth - 150, 22)];
        title.text = song[@"title"];
        title.font = [UIFont boldSystemFontOfSize:14];
        [songView addSubview:title];
        UILabel *artist = [[UILabel alloc] initWithFrame:CGRectMake(85, 38, screenWidth - 150, 20)];
        artist.text = song[@"artist"];
        artist.textColor = [UIColor grayColor];
        artist.font = [UIFont systemFontOfSize:12];
        [songView addSubview:artist];
        UIButton *heartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        heartButton.frame = CGRectMake(screenWidth - 40, 25, 24, 24);
        [heartButton setImage:[UIImage imageNamed:@"不喜欢.png"] forState:UIControlStateNormal];
        [heartButton setImage:[UIImage imageNamed:@"喜欢.png"] forState:UIControlStateSelected];
        heartButton.tag = i;//方便索引用户点的第几首歌
        [heartButton addTarget:self action:@selector(toggleFavorite:) forControlEvents:UIControlEventTouchUpInside];
        [songView addSubview:heartButton];
        [self.contentView addSubview:songView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
}

//点击红心按钮会调用
- (void)toggleFavorite:(UIButton *)sender {
    sender.selected = !sender.selected;
}

@end
