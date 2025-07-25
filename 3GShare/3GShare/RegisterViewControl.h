//
//  RegisterViewControl.h
//  3GShare
//
//  Created by mac on 2025/7/21.
//

#import <UIKit/UIKit.h>

@protocol InformationDelegate <NSObject>

-(void)setupInformation:(NSMutableDictionary*)dictionary;

@end

@interface RegisterViewControl : UIViewController

@property(nonatomic, strong) UITextField *EmailText;
@property(nonatomic, strong) UITextField *UserNameText;
@property(nonatomic, strong) UITextField *PassWordText;
@property(nonatomic, strong) UIButton *ConfirmButton;

@property(nonatomic, weak) id<InformationDelegate> dictDelegate;
@property(nonatomic) NSMutableDictionary *dictionary;

@end
