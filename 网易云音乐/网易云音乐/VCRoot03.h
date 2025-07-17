//
//  VCRoot03.h
//  网易云音乐
//
//  Created by mac on 2025/7/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VCRoot03 : UIViewController
@property(nonatomic, strong) UISegmentedControl *segmentedControl;
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) NSArray *titles;
@property(nonatomic, strong) UITableView *contentView;
@property(nonatomic, strong) UITableView *musicView;
@property(nonatomic, strong) UITableView *postView;
@property(nonatomic, strong) UITableView *noteView;
@end

NS_ASSUME_NONNULL_END
