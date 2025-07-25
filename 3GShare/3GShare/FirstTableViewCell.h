//
//  FirstTableViewCell.h
//  3GShare
//
//  Created by mac on 2025/7/22.
//

#import <UIKit/UIKit.h>

@interface FirstTableViewCell : UITableViewCell

@property(nonatomic, strong) NSMutableArray<UILabel*> *likeviewLabels;
@property(nonatomic, strong) NSMutableArray<NSNumber*> *likeviewCounts;

@property(nonatomic, copy) void(^likeStatesChangeBlock)(BOOL liked, NSInteger count);

@property(nonatomic, weak) UIButton *likeButton;//避免循环引用

@end
