//
//  HomeHeaderCell.h
//  网易云音乐
//
//  Created by mac on 2025/7/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeHeaderCell : UITableViewCell
@property(nonatomic, strong)UIScrollView *photoScrollView;
@property(nonatomic, strong)NSArray *buttonTitles;
@property(nonatomic, strong)NSArray *buttonNames;
@end

NS_ASSUME_NONNULL_END
