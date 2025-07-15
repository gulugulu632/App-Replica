//
//  UserCell.m
//  ZARA
//
//  Created by mac on 2025/7/15.
//

#import "UserCell.h"

@implementation UserCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageView2 = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.imageView2.layer.cornerRadius = 8;
        self.imageView2.clipsToBounds = YES;
        [self.contentView addSubview:self.imageView2];
        
        self.label1 = [[UILabel alloc] initWithFrame:CGRectZero];
        self.label1.font = [UIFont boldSystemFontOfSize:20];
        [self.contentView addSubview:self.label1];
        
        self.label2 = [[UILabel alloc] initWithFrame:CGRectZero];
        self.label2.font = [UIFont systemFontOfSize:14];
        self.label2.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.label2];
    }
    return self;
}

@end

