//
//  MyCell.m
//  网易云音乐
//
//  Created by mac on 2025/7/15.
//

#import "MyCell.h"

@implementation MyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(autoScrollCarousel) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)changeAvatar {
    //安全调用,检验是否把当前cell对象传给控制器
    //如果代理实现就会执行后面的方法
    if ([self.delegate respondsToSelector:@selector(didTapAvatarInCell:)]) {
        [self.delegate didTapAvatarInCell:self];
    }
}

@end
