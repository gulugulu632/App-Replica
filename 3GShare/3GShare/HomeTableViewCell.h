//
//  HomeTableViewCell.h
//  3GShare
//
//  Created by mac on 2025/7/21.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewCell : UITableViewCell

- (void)updateLikeButtonState:(BOOL)liked count:(NSInteger)count;

@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, strong) NSMutableArray<UILabel*> *likehomeLabels;
@property(nonatomic, strong) NSMutableArray<NSNumber*> *likehomeCounts;
@property(nonatomic, strong) NSMutableArray<UIButton*> *likehomeButtons;
@property(nonatomic, strong) UIButton *likeButton;
@property(nonatomic, strong) NSMutableArray<UIButton*> *likeButtons;
//返回类型:void
//参数:void
//block名称:pressFirst
@property(nonatomic, copy) void (^pressFirst)(void);

@property(nonatomic, copy) void(^likeButtonChangedBlock)(NSInteger index, BOOL liked, NSInteger count);

@end
