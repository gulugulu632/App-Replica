//
//  MySecondTableViewCell.h
//  3GShare
//
//  Created by mac on 2025/7/24.
//

#import <UIKit/UIKit.h>

@interface MySecondTableViewCell : UITableViewCell

@property(nonatomic, strong) NSArray<UIImage*> *images;
@property(nonatomic, strong) NSArray<UILabel*> *labels;
@property(nonatomic, strong) UIButton *btn;

@property(nonatomic, copy) void (^SendBlock)(void);
@property(nonatomic, copy) void (^RecommendBlock)(void);
@property(nonatomic, copy) void (^SettingBlock)(void);
@property(nonatomic, copy) void (^InformationBlock)(void);
@property(nonatomic, copy) void (^AlertBlock)(void);

@end
