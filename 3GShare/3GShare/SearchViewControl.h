//
//  SearchViewControl.h
//  3GShare
//
//  Created by mac on 2025/7/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchViewControl : UIViewController

@property(nonatomic, strong) UISearchBar *searchBar;
@property(nonatomic, strong) UIButton *likeButton;
@property(nonatomic, strong) NSMutableArray<UILabel*> *likeLabels;
@property(nonatomic, strong) NSMutableArray<NSNumber*> *likeCounts;

@end

NS_ASSUME_NONNULL_END
