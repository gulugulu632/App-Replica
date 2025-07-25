//
//  SettingViewController.h
//  3GShare
//
//  Created by mac on 2025/7/24.
//

#import <UIKit/UIKit.h>
#import "ProfileViewController.h"
#import "PasswordChangeViewController.h"
#import "NewsSettingViewController.h"

@interface SettingViewController : UIViewController

@property(nonatomic, strong) ProfileViewController *profileVC;
@property(nonatomic, strong) PasswordChangeViewController *passwordChangeVC;
@property(nonatomic, strong) NewsSettingViewController *newsSettingVC;

@end
