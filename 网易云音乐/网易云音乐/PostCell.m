//
//  PostCell.m
//  网易云音乐
//
//  Created by mac on 2025/7/18.
//

#import "PostCell.h"

@interface PostCell ()
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *artistLabel;
@property (nonatomic, strong) UIButton *heartButton;
@end

@implementation PostCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;

        self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 60, 60)];
        self.coverImageView.layer.cornerRadius = 4;
        self.coverImageView.clipsToBounds = YES;
        [self.contentView addSubview:self.coverImageView];

        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 15, screenWidth - 150, 22)];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        self.titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.titleLabel];

        self.artistLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 38, screenWidth - 150, 20)];
        self.artistLabel.font = [UIFont systemFontOfSize:12];
        self.artistLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.artistLabel];

        self.heartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.heartButton.frame = CGRectMake(screenWidth - 40, 25, 24, 24);
        [self.heartButton setImage:[UIImage imageNamed:@"不喜欢.png"] forState:UIControlStateNormal];
        [self.heartButton setImage:[UIImage imageNamed:@"喜欢.png"] forState:UIControlStateSelected];
        [self.heartButton addTarget:self action:@selector(toggleHeart:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.heartButton];

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleThemeChange:) name:@"SwitchChanged" object:nil];
    }
    return self;
}

- (void)setupPost:(NSDictionary *)song {
    self.coverImageView.image = [UIImage imageNamed:song[@"image"]];
    self.titleLabel.text = song[@"title"];
    self.artistLabel.text = song[@"artist"];
    self.heartButton.selected = [song[@"collected"] boolValue];
}

- (void)toggleHeart:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (void)handleThemeChange:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    BOOL isDark = [userInfo[@"switch"] boolValue];
    if (isDark) {
        self.contentView.backgroundColor = [UIColor grayColor];
    } else {
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
