//
//  ArticleViewControl.h
//  3GShare
//
//  Created by mac on 2025/7/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArticleViewControl : UIViewController

@property(nonatomic, strong) UISegmentedControl *segmentedControl;
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) NSArray *titles;

@property(nonatomic, strong) UIButton *likeButton1;
@property(nonatomic, strong) NSMutableArray<UILabel*> *likeLabels1;
@property(nonatomic, strong) NSMutableArray<NSNumber*> *likeCounts1;
@property(nonatomic, strong) UIButton *likeButton2;
@property(nonatomic, strong) NSMutableArray<UILabel*> *likeLabels2;
@property(nonatomic, strong) NSMutableArray<NSNumber*> *likeCounts2;
@property(nonatomic, strong) UIButton *likeButton3;
@property(nonatomic, strong) NSMutableArray<UILabel*> *likeLabels3;
@property(nonatomic, strong) NSMutableArray<NSNumber*> *likeCounts3;

@end

NS_ASSUME_NONNULL_END
