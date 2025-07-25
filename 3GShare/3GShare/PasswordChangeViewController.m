//
//  PasswordChangeViewController.m
//  3GShare
//
//  Created by mac on 2025/7/25.
//

#import "PasswordChangeViewController.h"

@interface PasswordChangeViewController ()<UITableViewDelegate, UITextFieldDelegate>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation PasswordChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, screenWidth, [UIScreen mainScreen].bounds.size.height - 170) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsHorizontalScrollIndicator = YES;
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    [self.view addSubview:self.tableView];
    
    UINavigationBarAppearance *SettingAppearance = [[UINavigationBarAppearance alloc] init];
    SettingAppearance.backgroundColor = [UIColor colorWithRed:79/225.0f green:141/225.0f blue:198/225.0f alpha:1];
    SettingAppearance.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:24]};
    self.navigationController.navigationBar.scrollEdgeAppearance = SettingAppearance;
    self.navigationController.navigationBar.standardAppearance = SettingAppearance;
    
    UIBarButtonItem *btnLeft = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(pressLeft)];
    self.navigationItem.leftBarButtonItem = btnLeft;
    
    NSArray *title = @[@"旧密码", @"新密码", @"确认密码"];
    self.passWords = [NSMutableArray array];
    
    for (int i = 0; i < 3; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, i * 60, screenWidth, 50)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 15, 100, 20)];
        label.text = title[i];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:18];
        [view addSubview:label];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(screenWidth - 280, 15, 280, 20)];
        textField.textColor = [UIColor blackColor];
        textField.backgroundColor = [UIColor clearColor];
        if (i == 0) {
            textField.placeholder = @"6-20位英文或数字组合";
        } else if (i == 1) {
            textField.placeholder = @"6-20位英文或数字组合";
        } else {
            textField.placeholder = @"请再次确认输入密码";
        }
        textField.delegate = self;
        [view addSubview:textField];
        [self.passWords addObject:textField];
        
        [self.tableView addSubview:view];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:tap];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(screenWidth / 2 - 40, 300, 80, 40);
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(pressBtn) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.textColor = [UIColor whiteColor];
    button.backgroundColor = [UIColor blackColor];
    [self.tableView addSubview:button];
}

-(void)pressLeft {
    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden = NO;
}

-(void)dissmissKeyboard {
    [self.view endEditing:YES];
}

-(void)pressBtn {
    NSString *newPassword = self.passWords[1].text;
    NSString *confirmPassword = self.passWords[2].text;
    
    if (newPassword.length < 6 || newPassword.length > 20) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"新密码需为6-20位英文或数字组合" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    } else if (![newPassword isEqualToString:confirmPassword]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"两次输入的新密码不一致" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"修改正确" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
