//
//  MoreCell.m
//  网易云音乐
//
//  Created by mac on 2025/7/17.
//

#import "MoreCell.h"

@implementation MoreCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, screenWidth - 32, 48)];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.titleLabel];
        self._switch = [[UISwitch alloc] initWithFrame:CGRectZero];
        self._switch.onTintColor = [UIColor redColor];
        self._switch.thumbTintColor = [UIColor whiteColor];
        self._switch.hidden = YES;
        [self.contentView addSubview:self._switch];
    }
    return self;
}


@end
