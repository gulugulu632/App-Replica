//
//  FirstTableViewCell.m
//  3GShare
//
//  Created by mac on 2025/7/22.
//

#import "FirstTableViewCell.h"

@implementation FirstTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.likeviewCounts = [NSMutableArray array];
        [self setupShare];
    }
    return self;
}

-(void)setupShare {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    UIView *cardView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 100)];
    UIImageView *cardImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    cardImageView.image = [UIImage imageNamed:@"假日"];
    cardImageView.clipsToBounds = YES;
    [cardView addSubview:cardImageView];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 100, 40)];
    title.text = @"假日";
    title.font = [UIFont boldSystemFontOfSize:24];
    [cardView addSubview:title];
    
    UILabel *author = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 100, 40)];
    author.text = @"share小刘";
    author.font = [UIFont systemFontOfSize:18];
    [cardView addSubview:author];
    
    UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth - 100, 15, 100, 30)];
    time.text = @"15分钟前";
    time.font = [UIFont systemFontOfSize:14];
    [cardView addSubview:time];

    UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    likeButton.frame = CGRectMake(screenWidth - 180, 65, 14, 14);
    [likeButton setImage:[UIImage imageNamed:@"dislike.png"] forState:UIControlStateNormal];
    [likeButton setImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateSelected];
    [likeButton addTarget:self action:@selector(pressLike:) forControlEvents:UIControlEventTouchUpInside];
    likeButton.selected = NO;
    [cardView addSubview:likeButton];
    self.likeButton = likeButton;
    
    UILabel *likeLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth - 160, 65, 30, 14)];
    likeLabel.text = @"32";
    likeLabel.font = [UIFont systemFontOfSize:14];
    [cardView addSubview:likeLabel];
    
    self.likeviewLabels = [NSMutableArray array];
    [self.likeviewLabels addObject:likeLabel];
    [self.likeviewCounts addObject:@(32)];
    
    UIButton *viewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    viewButton.frame = CGRectMake(screenWidth - 125, 65, 18, 14);
    [viewButton setImage:[UIImage imageNamed:@"view.png"] forState:UIControlStateNormal];
    [cardView addSubview:viewButton];
    
    UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth  - 105, 65, 30, 14)];
    view.text = @"825";
    view.font = [UIFont systemFontOfSize:14];
    [cardView addSubview:view];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(screenWidth - 70, 65, 14, 14);
    [shareButton setImage:[UIImage imageNamed:@"share.png"] forState:UIControlStateNormal];
    [cardView addSubview:shareButton];
    
    UILabel *share = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth - 50, 65, 30, 14)];
    share.text = @"64";
    share.font = [UIFont systemFontOfSize:14];
    [cardView addSubview:share];
    
    [self.contentView addSubview:cardView];
}

-(void)pressLike:(UIButton*)button {
    button.selected = !button.selected;
    
    NSInteger index = button.tag;
    
    NSInteger count = [self.likeviewCounts[0] integerValue];
    if (button.selected) {
        count++;
    } else {
        count--;
    }
    self.likeviewCounts[index] = @(count);
    UILabel *likeLabel = self.likeviewLabels[index];
    likeLabel.text = [NSString stringWithFormat:@"%ld", (long)count];
    self.likeStatesChangeBlock(button.selected, count);
}

@end
