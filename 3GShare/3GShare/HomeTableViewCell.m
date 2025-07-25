//
//  HomeTableViewCell.m
//  3GShare
//
//  Created by mac on 2025/7/21.
//

#import "HomeTableViewCell.h"

@interface HomeTableViewCell()<UIScrollViewDelegate>
@property(nonatomic, strong) UIScrollView *photoScrollView;
@end

@implementation HomeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupPhotoScrollView];
        [self startAutoScroll];
        [self setupCard];
    }
    return self;
}

-(void)setupPhotoScrollView {
    CGFloat photoHeight = 200;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat photoWidth = screenWidth - 20;
    self.photoScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, photoHeight)];
    self.photoScrollView.pagingEnabled = YES;
    self.photoScrollView.scrollEnabled = YES;
    self.photoScrollView.showsHorizontalScrollIndicator = NO;
    self.photoScrollView.delegate = self;
    self.photoScrollView.contentSize = CGSizeMake(screenWidth * 6, photoHeight);
    for (int i = 0; i < 6; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%d.png", (i % 4) + 1];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        if (i > 5) {
            imageView.frame = CGRectMake(10, 0, photoWidth, photoHeight);
        } else {
            imageView.frame = CGRectMake(10 + i * screenWidth, 0, photoWidth, photoHeight);
        }
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [self.photoScrollView addSubview:imageView];
    }
    [self.photoScrollView setContentOffset:CGPointMake(screenWidth, 0) animated:NO];
    [self.contentView addSubview:self.photoScrollView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;//当前滚动位置
    CGFloat width = scrollView.frame.size.width;//一个页面宽度
    CGFloat totalWidth = scrollView.contentSize.width;//整个滚动视图宽度
    if (offsetX >= totalWidth - width) {
        [scrollView setContentOffset:CGPointMake(width, 0) animated:NO];
    } else if (offsetX < width - scrollView.frame.size.width) {
        [scrollView setContentOffset:CGPointMake(totalWidth - 2 * width, 0) animated:NO];
    }
}

-(void)startAutoScroll {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(autoScrollCarousel) userInfo:nil repeats:YES];
    //当开始拖动时停止定时器，结束拖动时创建定时器，并将定时器添加到runloop中
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)stopAutoScroll {
    [self.timer invalidate];//停止定时器
    self.timer = nil;//释放定时器
}

-(void)autoScrollCarousel {
    CGFloat currentX = self.photoScrollView.contentOffset.x;
    CGFloat width = self.photoScrollView.frame.size.width;
    [self.photoScrollView setContentOffset:CGPointMake(currentX + width, 0) animated:YES];
}

//拖动时暂停自动轮播
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopAutoScroll];
}

//松手恢复自动轮播
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startAutoScroll];
}

-(void)setupCard {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    NSArray *cards = @[@{@"title":@"假日", @"author":@"share小刘", @"tip":@"原创-插画-练习写作", @"time":@"15分钟前", @"image":@"card1.png" , @"like":@"32", @"view":@"825", @"share":@"64"},
    @{@"title":@"国外画册欣赏", @"author":@"share小秦", @"tip":@"平面设计-画册设计", @"time":@"16分钟前", @"image":@"card2.png" , @"like":@"102", @"view":@"26", @"share":@"20"},
    @{@"title":@"collection扁平化设计", @"author":@"share小唐", @"tip":@"平面设计-海报设计", @"time":@"17分钟前", @"image":@"card3.png" , @"like":@"43", @"view":@"48", @"share":@"308"},
    @{@"title":@"版式整理术", @"author":@"share小何", @"tip":@"艺术创作", @"time":@"30分钟前", @"image":@"card4.png" , @"like":@"453", @"view":@"92", @"share":@"45"}];
    
    self.likehomeLabels = [NSMutableArray array];
    self.likehomeCounts = [NSMutableArray array];
    self.likeButtons = [NSMutableArray array];
    
    for (int i = 0; i < 4; i++)  {
        NSDictionary *card = cards[i];
        UIView *cardView = [[UIView alloc] initWithFrame:CGRectMake(10, 210 + i * 190, screenWidth - 20, 180)];
        
        UIImageView *cardImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth / 2, 180)];
        cardImageView.image = [UIImage imageNamed:card[@"image"]];
        cardImageView.clipsToBounds = YES;
        [cardView addSubview:cardImageView];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth / 2 + 10, 20, screenWidth / 2, 30)];
        title.text = card[@"title"];
        title.font = [UIFont boldSystemFontOfSize:18];
        [cardView addSubview:title];
        
        UILabel *author = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth / 2 + 10, 50, screenWidth / 2, 30)];
        author.text = card[@"author"];
        author.font = [UIFont systemFontOfSize:16];
        [cardView addSubview:author];
        
        UILabel *tip = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth / 2 + 10, 80, screenWidth / 2, 30)];
        tip.text = card[@"tip"];
        tip.font = [UIFont systemFontOfSize:14];
        [cardView addSubview:tip];
        
        UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth / 2 + 10, 110, screenWidth / 2, 30)];
        time.text = card[@"time"];
        time.font = [UIFont systemFontOfSize:14];
        [cardView addSubview:time];
        
        self.likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.likeButton.frame = CGRectMake(screenWidth / 2 + 10, 140, 14, 14);
        [self.likeButton setImage:[UIImage imageNamed:@"dislike.png"] forState:UIControlStateNormal];
        [self.likeButton setImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateSelected];
        [self.likeButton addTarget:self action:@selector(pressLike:) forControlEvents:UIControlEventTouchUpInside];
        self.likeButton.tag = i;
        self.likeButton.selected = NO;
        [self.likeButtons addObject:self.likeButton];
        [cardView addSubview:self.likeButton];
        
        UILabel *likeLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth / 2 + 30, 140, 30, 14)];
        [self.likehomeLabels addObject:likeLabel];
        NSInteger likeCount = [card[@"like"] integerValue];
        [self.likehomeCounts addObject:@(likeCount)];
        likeLabel.text = [NSString stringWithFormat:@"%ld", (long)likeCount];
        likeLabel.font = [UIFont systemFontOfSize:14];
        [cardView addSubview:likeLabel];
        
        UIButton *viewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        viewButton.frame = CGRectMake(screenWidth / 2 + 60, 140, 18, 14);
        [viewButton setImage:[UIImage imageNamed:@"view.png"] forState:UIControlStateNormal];
        [cardView addSubview:viewButton];
        
        UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth / 2 + 80, 140, 30, 14)];
        view.text = card[@"view"];
        view.font = [UIFont systemFontOfSize:14];
        [cardView addSubview:view];
        
        UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        shareButton.frame = CGRectMake(screenWidth / 2 + 110, 140, 14, 14);
        [shareButton setImage:[UIImage imageNamed:@"share.png"] forState:UIControlStateNormal];
        [cardView addSubview:shareButton];
        
        UILabel *share = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth / 2 + 130, 140, 30, 14)];
        share.text = card[@"share"];
        share.font = [UIFont systemFontOfSize:14];
        [cardView addSubview:share];
        
        [self.contentView addSubview:cardView];
        
        if (i == 0) {
            cardView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressFirstView)];
            [cardView addGestureRecognizer:tap];
        }
    }
}

-(void)pressLike:(UIButton*) button {
    button.selected = !button.selected;
    NSInteger count = [self.likehomeCounts[button.tag] integerValue];
    if (button.selected) {
        count++;
    } else {
        count--;
    }
    self.likehomeCounts[button.tag] = @(count);
    UILabel *likeLabel = self.likehomeLabels[button.tag];
    likeLabel.text = [NSString stringWithFormat:@"%ld", (long)count];
    self.likeButtonChangedBlock(button.tag, button.selected, count);
}

-(void)pressFirstView {
    self.pressFirst();
}

- (void)updateLikeButtonState:(BOOL)liked count:(NSInteger)count {
}

@end
