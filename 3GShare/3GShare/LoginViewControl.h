//
//  LoginViewControl.h
//  3GShare
//
//  Created by mac on 2025/7/19.
//

#import <UIKit/UIKit.h>

//TabBarDelegate协议传值传递导航栏和分栏作为首页的根视图,实现界面切换
//InformationDelegate协议传值传递注册信息给登录界面
//将账号密码数据存入字典,可类似存储信息,旧信息不被新信息覆盖

@protocol TabBarDelegate <NSObject>

-(void)tabBarMode:(UITabBarController*)taBar;

@end

@interface LoginViewControl : UIViewController

@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UITextField *UserNameText;
@property(nonatomic, strong) UITextField *PassWordText;
@property(nonatomic, strong) UIButton *Loginbt;
@property(nonatomic, strong) UIButton *Registerbt;
@property(nonatomic, strong) UIButton *Autobt;
@property(nonatomic, strong) UILabel *autoLabel;
@property(nonatomic, strong) UIImage *shareImage;
@property(nonatomic, strong) UIImageView *shareImageView;

@property(nonatomic) NSString *UserNamestr;
@property(nonatomic) NSString *PassWordstr;
@property(nonatomic) NSMutableDictionary *dict;

@property(nonatomic, weak) id<TabBarDelegate> tabDelegate;

-(void)setupInformation:(NSMutableDictionary*)dictionary;

@end
