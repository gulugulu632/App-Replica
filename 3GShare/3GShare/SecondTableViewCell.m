//
//  SecondTableViewCell.m
//  3GShare
//
//  Created by mac on 2025/7/22.
//

#import "SecondTableViewCell.h"

@implementation SecondTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, screenWidth, 20)];
        self.label.text = @"多希望列车能把我带到有你的城市。";
        self.label.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.label];
        [self setupSecondView];
    }
    return self;
}

-(void)setupSecondView {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    NSArray *images = @[[UIImage imageNamed:@"假日1.png"], [UIImage imageNamed:@"假日2.png"], [UIImage imageNamed:@"假日3.png"], [UIImage imageNamed:@"假日4.png"], [UIImage imageNamed:@"假日5.png"]];
    for (int i = 0; i < 5; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:images[i]];
        imageView.frame = CGRectMake(10, 40 + i * 230, screenWidth - 20, 220);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.clipsToBounds = YES;
        [self.contentView addSubview:imageView];
    }
}

@end
