//
//  MyCell.h
//  网易云音乐
//
//  Created by mac on 2025/7/15.
//

#import <UIKit/UIKit.h>

@class MyCell; //声明类，避免头文件互引

//头像点击协议
@protocol MyCellDelegate <NSObject>
- (void)didTapAvatarInCell:(MyCell *)cell;
@end

@interface MyCell : UITableViewCell


@property (nonatomic, strong) UICollectionView *carouselView;
@property (nonatomic, strong) NSArray *carouselData;



@property(nonatomic, strong) UIButton *avatarButton;
@property(nonatomic, weak) id<MyCellDelegate> delegate;

- (void)ChangePhoto:(UIImage *)image;

@end

