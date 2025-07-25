//
//  SearchViewControl.m
//  3GShare
//
//  Created by mac on 2025/7/22.
//

#import "SearchViewControl.h"
#import "EditViewControl.h"

@interface SearchViewControl ()<UITableViewDelegate, UITextFieldDelegate, UISearchBarDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UITableView *resultView;

@end

@implementation SearchViewControl

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 145, screenWidth, [UIScreen mainScreen].bounds.size.height - 46) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.showsHorizontalScrollIndicator = YES;
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    [self.view addSubview:self.tableView];
    
    UINavigationBarAppearance *searchAppearance = [[UINavigationBarAppearance alloc] init];
    searchAppearance.backgroundColor = [UIColor colorWithRed:79/225.0f green:141/225.0f blue:198/225.0f alpha:1];
    searchAppearance.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:24]};
    self.navigationController.navigationBar.scrollEdgeAppearance = searchAppearance;
    self.navigationController.navigationBar.standardAppearance = searchAppearance;
    
    UIBarButtonItem *btnLeft = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(pressLeft)];
    UIBarButtonItem *btnRight = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"搜索右.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(pressRight)];
    self.navigationItem.leftBarButtonItem = btnLeft;
    self.navigationItem.rightBarButtonItem = btnRight;
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 110, screenWidth - 20, 36)];
    self.searchBar.placeholder = @"搜索 用户名 作品分类 文章";
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchBar.delegate = self;
    UIView *searchTextField = [self.searchBar valueForKey:@"searchField"];
    if ([searchTextField isKindOfClass:[UITextField class]]) {
        UITextField *textField = (UITextField*)searchTextField;
        textField.layer.cornerRadius = 4;
        textField.layer.masksToBounds = YES;
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.searchBar.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
        textField.returnKeyType = UIReturnKeySearch;
        textField.delegate = self;
    }
    [self.view addSubview:self.searchBar];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
    NSArray *tips = @[@{@"title":@"分类", @"image":@"标签.png"}, @{@"title":@"推荐", @"image":@"标签.png"}, @{@"title":@"时间", @"image":@"标签.png"}];
    NSArray *buttons1 = @[@"平面设计", @"网页设计", @"UI/icon", @"绘画/手绘"];
    NSArray *buttons2 = @[@"虚拟与设计", @"影视", @"摄影", @"其他"];
    NSArray *buttons3 = @[@"人气最高", @"收藏最多", @"评论最多", @"编辑精选"];
    NSArray *buttons4 = @[@"30分钟前", @"1小时前", @"1月前", @"1年前"];
    
    for (int i = 0; i < 3; i++) {
        NSDictionary *tipDict = tips[i];
        UIButton *tip = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *line = [UIImage imageNamed:@"蓝线"];
        UIImageView *lineImageView = [[UIImageView alloc] initWithImage:line];
        if (i == 0) {
            tip.frame = CGRectMake(10, 20, 75, 25);
            lineImageView.frame = CGRectMake(10, 45, screenWidth - 20, 3);
        } else if (i == 1) {
            tip.frame = CGRectMake(10, 150, 75, 25);
            lineImageView.frame = CGRectMake(10, 175, screenWidth - 20, 3);
        } else {
            tip.frame = CGRectMake(10, 240, 75, 25);
            lineImageView.frame = CGRectMake(10, 265, screenWidth - 20, 3);
        }
        [tip setTitle:tipDict[@"title"] forState:UIControlStateNormal];
        [tip setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        tip.titleLabel.font = [UIFont systemFontOfSize:20];
        UIImage *image = [UIImage imageNamed:tipDict[@"image"]];
        [tip setImage:image forState:UIControlStateNormal];
        tip.backgroundColor = [UIColor colorWithRed:79/225.0f green:141/225.0f blue:198/225.0f alpha:1];
        
        [self.tableView addSubview:lineImageView];
        [self.tableView addSubview:tip];
    }
    
    for (int i = 0; i < 4; i++) {
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
        if (i == 3) {
            btn1.frame = CGRectMake(10 + i * 90, 60, 100, 30);
        } else {
            btn1.frame = CGRectMake(10 + i * 90, 60, 80, 30);
        }
        [btn1 setTitle:buttons1[i] forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn1.titleLabel.font = [UIFont systemFontOfSize:20];
        btn1.backgroundColor = [UIColor whiteColor];
        [btn1 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.tableView addSubview:btn1];
    }
    
    for (int i = 0; i < 4; i++) {
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
        if (i == 0) {
            btn2.frame = CGRectMake(10, 100, 100, 30);
        } else {
            btn2.frame = CGRectMake(30 + i * 90, 100, 80, 30);
        }
        [btn2 setTitle:buttons2[i] forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn2.titleLabel.font = [UIFont systemFontOfSize:20];
        btn2.backgroundColor = [UIColor whiteColor];
        [btn2 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.tableView addSubview:btn2];
    }
    
    for (int i = 0; i < 4; i++) {
        UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeSystem];
        btn3.frame = CGRectMake(10 + i * 100, 190, 80, 30);
        [btn3 setTitle:buttons3[i] forState:UIControlStateNormal];
        [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn3.titleLabel.font = [UIFont systemFontOfSize:20];
        btn3.backgroundColor = [UIColor whiteColor];
        [btn3 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.tableView addSubview:btn3];
    }
    
    for (int i = 0; i < 4; i++) {
        UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeSystem];
        if (i == 0) {
            btn4.frame = CGRectMake(10, 270, 90, 30);
        } else {
            btn4.frame = CGRectMake(10 + i * 100, 270, 80, 30);
        }
        [btn4 setTitle:buttons4[i] forState:UIControlStateNormal];
        [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn4.titleLabel.font = [UIFont systemFontOfSize:20];
        btn4.backgroundColor = [UIColor whiteColor];
        [btn4 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.tableView addSubview:btn4];
    }
    
    self.resultView = [[UITableView alloc] initWithFrame:CGRectMake(0, 150, screenWidth, [UIScreen mainScreen].bounds.size.height - 46) style:UITableViewStylePlain];
    self.resultView.backgroundColor = [UIColor redColor];
    self.resultView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    self.resultView.delegate = self;
    self.resultView.hidden = YES;
    [self.view addSubview:self.resultView];
    
    NSArray *cards = @[@{@"title":@"Icon of Baymax", @"author":@"share小白", @"tip":@"原创-UI-icon", @"time":@"15分钟前", @"image":@"大白1.png" , @"like":@"102", @"view":@"26", @"share":@"20"},
    @{@"title":@"每个人都需要一个大白", @"author":@"share小王", @"tip":@"原创作品-摄影", @"time":@"1个月前", @"image":@"大白2.png" , @"like":@"85", @"view":@"35", @"share":@"3489"}];
    
    self.likeLabels = [NSMutableArray array];
    self.likeCounts = [NSMutableArray array];
                        
    for (int i = 0; i < 2; i++) {
        NSDictionary *card = cards[i];
        UIView *cardView = [[UIView alloc] initWithFrame:CGRectMake(10, i * 190, screenWidth - 20, 180)];
        
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
        
        [self.resultView addSubview:cardView];
    }
}

-(void)pressLeft {
    self.resultView.hidden = YES;
}

-(void)pressRight {
    EditViewControl *editVC = [[EditViewControl alloc] init];
    [self.navigationController pushViewController:editVC animated:YES];
}

-(void)dissmissKeyboard {
    [self.searchBar resignFirstResponder];
}

-(void)pressBtn:(UIButton*) btn {
    if (btn.backgroundColor == [UIColor whiteColor]) {
        btn.backgroundColor = [UIColor colorWithRed:79/225.0f green:141/225.0f blue:198/225.0f alpha:1];
    } else {
        btn.backgroundColor = [UIColor whiteColor];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.text.length > 0 && [textField.text isEqualToString:@"大白"]) {
        self.resultView.hidden = NO;
    } else {
        self.resultView.hidden = YES;
    }
    [textField resignFirstResponder];
    return YES;
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
