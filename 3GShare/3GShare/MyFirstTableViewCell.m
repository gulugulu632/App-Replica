//
//  MyFirstTableViewCell.m
//  3GShare
//
//  Created by mac on 2025/7/24.
//

#import "MyFirstTableViewCell.h"

@implementation MyFirstTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupMy];
    }
    return self;
}

-(void)setupMy {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    UIView *cardView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 180)];
    UIImageView *cardImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 160, 160)];
    cardImageView.image = [UIImage imageNamed:@"假日"];
    cardImageView.clipsToBounds = YES;
    [cardView addSubview:cardImageView];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(180, 25, 100, 30)];
    title.text = @"share小刘";
    title.font = [UIFont boldSystemFontOfSize:18];
    [cardView addSubview:title];
    
    UILabel *author = [[UILabel alloc] initWithFrame:CGRectMake(180, 65, 120, 20)];
    author.text = @"数媒/设计爱好者";
    author.font = [UIFont systemFontOfSize:16];
    [cardView addSubview:author];
    
    UILabel *tip = [[UILabel alloc] initWithFrame:CGRectMake(180, 95, screenWidth / 2, 30)];
    tip.text = @"开心了就笑，不开心了就过会儿再笑";
    tip.font = [UIFont systemFontOfSize:12];
    [cardView addSubview:tip];

    UIButton *articleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    articleButton.frame = CGRectMake(180, 135, 14, 14);
    [articleButton setImage:[UIImage imageNamed:@"发表文章.png"] forState:UIControlStateNormal];
    articleButton.selected = NO;
    [cardView addSubview:articleButton];
    
    UILabel *articleLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 135, 30, 14)];
    articleLabel.text = @"64";
    articleLabel.font = [UIFont systemFontOfSize:14];
    [cardView addSubview:articleLabel];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(235, 135, 14, 14);
    [shareButton setImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal];
    [cardView addSubview:shareButton];
    
    UILabel *likeLabel = [[UILabel alloc] initWithFrame:CGRectMake(255, 135, 30, 14)];
    likeLabel.text = @"32";
    likeLabel.font = [UIFont systemFontOfSize:14];
    [cardView addSubview:likeLabel];
    
    UIButton *viewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    viewButton.frame = CGRectMake(290, 135, 18, 14);
    [viewButton setImage:[UIImage imageNamed:@"view.png"] forState:UIControlStateNormal];
    [cardView addSubview:viewButton];
    
    UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(310, 135, 30, 14)];
    view.text = @"825";
    view.font = [UIFont systemFontOfSize:14];
    [cardView addSubview:view];
    
    [self.contentView addSubview:cardView];
}

@end
