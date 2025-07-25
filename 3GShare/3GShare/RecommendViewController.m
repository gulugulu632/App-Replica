//
//  RecommendViewController.m
//  3GShare
//
//  Created by mac on 2025/7/24.
//

#import "RecommendViewController.h"

@interface RecommendViewController ()<UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, screenWidth, [UIScreen mainScreen].bounds.size.height - 170) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsHorizontalScrollIndicator = YES;
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    [self.view addSubview:self.tableView];
    
    UINavigationBarAppearance *TalkAppearance = [[UINavigationBarAppearance alloc] init];
    TalkAppearance.backgroundColor = [UIColor colorWithRed:79/225.0f green:141/225.0f blue:198/225.0f alpha:1];
    TalkAppearance.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:24]};
    self.navigationController.navigationBar.scrollEdgeAppearance = TalkAppearance;
    self.navigationController.navigationBar.standardAppearance = TalkAppearance;
    
    UIBarButtonItem *btnLeft = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(pressLeft)];
    self.navigationItem.leftBarButtonItem = btnLeft;
    
    self.likeLabels = [NSMutableArray array];
    self.likeCounts = [NSMutableArray array];
    
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
        
        self.likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.likeButton.frame = CGRectMake(screenWidth / 2 + 10, 140, 14, 14);
        [self.likeButton setImage:[UIImage imageNamed:@"dislike.png"] forState:UIControlStateNormal];
        [self.likeButton setImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateSelected];
        [self.likeButton addTarget:self action:@selector(pressLike:) forControlEvents:UIControlEventTouchUpInside];
        self.likeButton.tag = i;
        self.likeButton.selected = NO;
        [cardView addSubview:self.likeButton];
        
        UILabel *like = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth / 2 + 30, 140, 30, 14)];
        [self.likeLabels addObject:like];
        NSInteger likeCount = [card[@"like"] integerValue];
        [self.likeCounts addObject:@(likeCount)];
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
        
        [self.tableView addSubview:cardView];
    }
}

-(void)pressLeft {
    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden = NO;
}

-(void)pressLike:(UIButton*) btn {
    btn.selected = !btn.selected;
    NSInteger count = [self.likeCounts[btn.tag] integerValue];
    if (btn.selected) {
        count++;
    } else {
        count--;
    }
    self.likeCounts[btn.tag] = @(count);
    UILabel *label = [self.likeLabels objectAtIndex:btn.tag];
    label.text = [NSString stringWithFormat:@"%ld", (long)count];
}

@end
