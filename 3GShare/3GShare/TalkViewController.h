//
//  TalkViewController.h
//  3GShare
//
//  Created by mac on 2025/7/25.
//

#import <UIKit/UIKit.h>

@interface TalkViewController : UIViewController

@property(nonatomic, strong) UITextField *textField;
@property(nonatomic, strong) UIButton *sendBtn;
@property(nonatomic, strong) NSMutableArray *talkArray;
@property(nonatomic, strong) NSMutableArray *heightArray;
@property(nonatomic, strong) NSNumber* height;

@end
