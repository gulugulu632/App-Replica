//
//  RecommendViewController.h
//  3GShare
//
//  Created by mac on 2025/7/24.
//

#import <UIKit/UIKit.h>

@interface RecommendViewController : UIViewController

@property(nonatomic, strong) NSMutableArray<UILabel*> *likeLabels;
@property(nonatomic, strong) NSMutableArray<NSNumber*> *likeCounts;
@property(nonatomic, strong) UIButton *likeButton;

@end
