//
//  HomeHeaderCell.m
//  网易云音乐
//
//  Created by mac on 2025/7/15.
//

#import "HomeHeaderCell.h"

@interface HomeHeaderCell () <UIScrollViewDelegate>

@end

@implementation HomeHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupPhotoScrollView];
        [self setupButtons];
        [self setupPlaylist];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleThemeChange:) name:@"SwitchChanged" object:nil];
        [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(autoScrollCarousel) userInfo:nil repeats:YES];
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

- (void)setupPhotoScrollView {
    CGFloat photoHeight = 200;
    NSInteger screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.photoScrollView = [[UIScrollView alloc] init];
    self.photoScrollView.frame = CGRectMake(0, 10, screenWidth, photoHeight);
    self.photoScrollView.pagingEnabled = YES;
    self.photoScrollView.scrollEnabled = YES;
    self.photoScrollView.showsHorizontalScrollIndicator = NO;
    self.photoScrollView.delegate = self;
    self.photoScrollView.contentSize = CGSizeMake(screenWidth * 9, photoHeight);
    for (int i = 0; i < 9; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%d.jpg", (i % 7) + 1];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        if (i > 8) {
            imageView.frame = CGRectMake(0, 0, screenWidth, photoHeight);
        } else {
            imageView.frame = CGRectMake(i * screenWidth, 0, screenWidth, photoHeight);
        }
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [self.photoScrollView addSubview:imageView];
    }
    [self.photoScrollView setContentOffset:CGPointMake(screenWidth, 0) animated:NO];
    [self.contentView addSubview:self.photoScrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat width = scrollView.frame.size.width;
    CGFloat totalWidth = scrollView.contentSize.width;
    if (offsetX >= totalWidth - width) {
        [scrollView setContentOffset:CGPointMake(width, 0) animated:NO];
    } else if (offsetX < width - scrollView.frame.size.width) {
        [scrollView setContentOffset:CGPointMake(totalWidth - 2 * width, 0) animated:NO];
    }
}

- (void)setupButtons {
    self.buttonTitles = @[@"推荐", @"音乐", @"排行榜", @"播客", @"听书"];
    UIScrollView *buttonScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 210, [UIScreen mainScreen].bounds.size.width, 100)];
    buttonScroll.showsHorizontalScrollIndicator = NO;
    for (int i = 0; i < 5; i++) {
        NSString *title = self.buttonTitles[i];
        UIButtonConfiguration *config = [UIButtonConfiguration plainButtonConfiguration];
        config.attributedTitle = [[NSAttributedString alloc] initWithString:title];
        config.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", title]];
        config.imagePlacement = NSDirectionalRectEdgeTop;
        config.imagePadding = 8;
        config.buttonSize = UIButtonConfigurationSizeMini;
        config.baseForegroundColor = [UIColor blackColor];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.configuration = config;
        btn.frame = CGRectMake(i * 100, 0, 100, 100);
        [buttonScroll addSubview:btn];
    }
    buttonScroll.contentSize = CGSizeMake(100 * 5, 100);
    [self.contentView addSubview:buttonScroll];
}

- (void)setupPlaylist {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat playHeight = 100;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 310, screenWidth - 30, 30)];
    label.text = @"Daaannna的雷达歌单";
    label.font = [UIFont boldSystemFontOfSize:18];
    [self.contentView addSubview:label];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 350, screenWidth, playHeight)];
    scrollView.showsHorizontalScrollIndicator = NO;
    CGFloat buttonWidth = screenWidth / 4;
    NSArray *titles = @[@"华语雷达", @"私人雷达", @"宝藏雷达", @"新歌雷达", @"黑胶专属"];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(buttonWidth * 5, playHeight);
    for (int i = 0; i < titles.count; i++) {
        UIView *container = [[UIView alloc] initWithFrame:CGRectMake(i * buttonWidth, 0, buttonWidth, 100)];//卡片
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, buttonWidth - 20, buttonWidth - 20)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", titles[i]]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;//裁掉图片超出圆角框部分
        imageView.layer.cornerRadius = 8;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(imageView.frame) + 5, buttonWidth - 10, 10)];
        label.text = titles[i];
        label.font = [UIFont systemFontOfSize:12];
        label.lineBreakMode = NSLineBreakByWordWrapping;//默认尾部省略
        label.numberOfLines = 3;
        label.textAlignment = NSTextAlignmentCenter;
        [container addSubview:imageView];
        [container addSubview:label];
        [scrollView addSubview:container];
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:scrollView];
}

-(void)autoScrollCarousel {
    CGFloat currentX = self.photoScrollView.contentOffset.x;
    CGFloat width = self.photoScrollView.frame.size.width;
    [self.photoScrollView setContentOffset:CGPointMake(currentX + width, 0) animated:YES];
}


- (void)pressMore {
    NSLog(@"More pressed");
}

- (void)pressMusic {
    NSLog(@"Music pressed");
}

@end

