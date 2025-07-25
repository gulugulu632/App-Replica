//
//  SendViewController.m
//  3GShare
//
//  Created by mac on 2025/7/24.
//

#import "SendViewController.h"

@interface SendViewController ()<UITableViewDelegate, UIScrollViewDelegate>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation SendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, [UIScreen mainScreen].bounds.size.height - 46) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.showsHorizontalScrollIndicator = YES;
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    [self.view addSubview:self.tableView];
    
    UINavigationBarAppearance *sendAppearance = [[UINavigationBarAppearance alloc] init];
    sendAppearance.backgroundColor = [UIColor colorWithRed:79/225.0f green:141/225.0f blue:198/225.0f alpha:1];
    sendAppearance.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:24]};
    self.navigationController.navigationBar.scrollEdgeAppearance = sendAppearance;
    self.navigationController.navigationBar.standardAppearance = sendAppearance;
    
    UIBarButtonItem *btnLeft = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(pressLeft)];
    self.navigationItem.leftBarButtonItem = btnLeft;
    
    self.titles = @[@"精选文章", @"热门推荐", @"全部文章"];
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:self.titles];
    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.backgroundColor = [UIColor grayColor];
    [self.segmentedControl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    self.segmentedControl.frame = CGRectMake(0, 0, screenWidth, 50);
    NSDictionary *normalText = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:24]};
    NSDictionary *selectedText = @{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:24]};
    [self.segmentedControl setTitleTextAttributes:normalText forState:UIControlStateNormal];
    [self.segmentedControl setTitleTextAttributes:selectedText forState:UIControlStateSelected];
    [self.tableView addSubview:self.segmentedControl];
    
    for (int i = 0; i < 2; i ++) {
        UIImage *lineImage = [UIImage imageNamed:@"间隔.png"];
        UIImageView *lineImageView = [[UIImageView alloc] initWithImage:lineImage];
        lineImageView.frame = CGRectMake(screenWidth / 3 * (i + 1) - 2.5, 0, 5, 50);
        [self.segmentedControl addSubview:lineImageView];
    }
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, screenWidth, 900)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(screenWidth * 3, 900);
    [self.tableView addSubview:self.scrollView];
    
    self.likeLabels1 = [NSMutableArray array];
    self.likeCounts1 = [NSMutableArray array];
    self.likeLabels2 = [NSMutableArray array];
    self.likeCounts2 = [NSMutableArray array];
    self.likeLabels3 = [NSMutableArray array];
    self.likeCounts3 = [NSMutableArray array];
                      
    for (int i = 0; i < 3; i++) {
        UITableView *pageview = [[UITableView alloc] initWithFrame:CGRectMake(i * screenWidth, 0, screenWidth, 900)];
        [self.scrollView addSubview:pageview];
        if (i == 0) {
            NSArray *cards = @[@{@"title":@"Icon of Baymax", @"author":@"share小白", @"tip":@"原创-UI-icon", @"time":@"15分钟前", @"image":@"大白1.png" , @"like":@"102", @"view":@"26", @"share":@"20"},
            @{@"title":@"每个人都需要一个大白", @"author":@"share小王", @"tip":@"原创作品-摄影", @"time":@"1个月前", @"image":@"大白2.png" , @"like":@"85", @"view":@"35", @"share":@"3489"}];
            for (int j = 0; j < 2; j++) {
                NSDictionary *card = cards[j];
                UIView *cardView = [[UIView alloc] initWithFrame:CGRectMake(10, j * 190, screenWidth - 20, 180)];
                
                UIImageView *dabaiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, screenWidth / 2, 180)];
                dabaiImageView.image = [UIImage imageNamed:card[@"image"]];
                dabaiImageView.clipsToBounds = YES;
                [cardView addSubview:dabaiImageView];
                
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
                
                self.likeButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
                self.likeButton1.frame = CGRectMake(screenWidth / 2 + 10, 140, 14, 14);
                [self.likeButton1 setImage:[UIImage imageNamed:@"dislike.png"] forState:UIControlStateNormal];
                [self.likeButton1 setImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateSelected];
                [self.likeButton1 addTarget:self action:@selector(pressLike1:) forControlEvents:UIControlEventTouchUpInside];
                self.likeButton1.tag = i;
                self.likeButton1.selected = NO;
                [cardView addSubview:self.likeButton1];
                
                UILabel *like = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth / 2 + 30, 140, 30, 14)];
                [self.likeLabels1 addObject:like];
                NSInteger likeCount = [card[@"like"] integerValue];
                [self.likeCounts1 addObject:@(likeCount)];
                like.text = [NSString stringWithFormat:@"%ld", (long)likeCount];
                like.font = [UIFont systemFontOfSize:14];
                [cardView addSubview:like];
                
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
                
                [pageview addSubview:cardView];
            }
        }
        else {
            NSArray *cards = @[@{@"title":@"假日", @"author":@"share小刘", @"tip":@"原创-插画-练习写作", @"time":@"15分钟前", @"image":@"card1.png" , @"like":@"32", @"view":@"825", @"share":@"64"},
            @{@"title":@"国外画册欣赏", @"author":@"share小秦", @"tip":@"平面设计-画册设计", @"time":@"16分钟前", @"image":@"card2.png" , @"like":@"102", @"view":@"26", @"share":@"20"},
            @{@"title":@"collection扁平化设计", @"author":@"share小唐", @"tip":@"平面设计-海报设计", @"time":@"17分钟前", @"image":@"card3.png" , @"like":@"43", @"view":@"48", @"share":@"308"},
            @{@"title":@"版式整理术", @"author":@"share小何", @"tip":@"艺术创作", @"time":@"30分钟前", @"image":@"card4.png" , @"like":@"453", @"view":@"92", @"share":@"45"}];
            
            for (int i = 0; i < 4; i++)  {
                NSDictionary *card = cards[i];
                UIView *cardView = [[UIView alloc] initWithFrame:CGRectMake(10, i * 190, screenWidth - 20, 180)];
                
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
                
                self.likeButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
                self.likeButton2.frame = CGRectMake(screenWidth / 2 + 10, 140, 14, 14);
                [self.likeButton2 setImage:[UIImage imageNamed:@"dislike.png"] forState:UIControlStateNormal];
                [self.likeButton2 setImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateSelected];
                [self.likeButton2 addTarget:self action:@selector(pressLike2:) forControlEvents:UIControlEventTouchUpInside];
                self.likeButton2.tag = i;
                self.likeButton2.selected = NO;
                [cardView addSubview:self.likeButton2];
                
                UILabel *like = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth / 2 + 30, 140, 30, 14)];
                [self.likeLabels2 addObject:like];
                NSInteger likeCount = [card[@"like"] integerValue];
                [self.likeCounts2 addObject:@(likeCount)];
                like.text = [NSString stringWithFormat:@"%ld", (long)likeCount];
                like.font = [UIFont systemFontOfSize:14];
                [cardView addSubview:like];
                
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
                
                [pageview addSubview:cardView];
            }
        }
    }
}

-(void)pressLeft {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)segmentChanged:(UISegmentedControl*)segment {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat offsetX = segment.selectedSegmentIndex * screenWidth;
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    NSInteger pageIndex = scrollView.contentOffset.x / screenWidth;
    self.segmentedControl.selectedSegmentIndex = pageIndex;
}

-(void)pressLike1:(UIButton*) btn {
    btn.selected = !btn.selected;
    NSInteger count = [self.likeCounts1[btn.tag] integerValue];
    if (btn.selected) {
        count++;
    } else {
        count--;
    }
    self.likeCounts1[btn.tag] = @(count);
    UILabel *label = [self.likeLabels1 objectAtIndex:btn.tag];
    label.text = [NSString stringWithFormat:@"%ld", (long)count];
}

-(void)pressLike2:(UIButton*) btn {
    btn.selected = !btn.selected;
    NSInteger count = [self.likeCounts2[btn.tag] integerValue];
    if (btn.selected) {
        count++;
    } else {
        count--;
    }
    self.likeCounts2[btn.tag] = @(count);
    UILabel *label = [self.likeLabels2 objectAtIndex:btn.tag];
    label.text = [NSString stringWithFormat:@"%ld", (long)count];
}

@end

