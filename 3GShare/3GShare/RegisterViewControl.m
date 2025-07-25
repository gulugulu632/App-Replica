//
//  RegisterViewControl.m
//  3GShare
//
//  Created by mac on 2025/7/21.
//

#import "RegisterViewControl.h"
#import "LoginViewControl.h"
//导入正则表达式
#import <Foundation/Foundation.h>

@interface RegisterViewControl ()<UITextFieldDelegate>
@property(nonatomic, strong) UIScrollView *scrollView;
@end

@implementation RegisterViewControl

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.view.backgroundColor = [UIColor colorWithRed:79/225.0f green:141/225.0f blue:198/225.0f alpha:1];
    
    self.dictionary = [[NSMutableDictionary alloc] init];
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.contentSize = CGSizeMake(screenWidth, 1000);
    self.scrollView.scrollEnabled = YES;

    UIImage *shareImage = [[UIImage alloc] init];
    shareImage = [UIImage imageNamed:@"share logo.png"];
    UIImageView *shareImageView = [[UIImageView alloc] initWithImage:shareImage];
    shareImageView.frame = CGRectMake(screenWidth / 2 - 75, 130, 150, 150);
    shareImageView.layer.cornerRadius = 75;
    shareImageView.clipsToBounds = YES;

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth / 2 - 70, 270, 140, 70)];
    titleLabel.text = @"SHARE";
    titleLabel.font = [UIFont boldSystemFontOfSize:42];
    titleLabel.textColor = [UIColor whiteColor];

    self.EmailText = [[UITextField alloc] initWithFrame:CGRectMake(screenWidth / 2 - 150, 400, 300, 40)];
    UIImage *emailImage = [UIImage imageNamed:@"邮箱.png"];
    UIImageView *emailImageView = [[UIImageView alloc] initWithImage:emailImage];
    emailImageView.frame = CGRectMake(0, 0, 10, 10);
    self.EmailText.backgroundColor = [UIColor whiteColor];
    self.EmailText.leftView = emailImageView;
    self.EmailText.leftViewMode = UITextFieldViewModeAlways;
    
    self.UserNameText = [[UITextField alloc] initWithFrame:CGRectMake(screenWidth / 2 - 150, 450, 300, 40)];
    UIImage *userImage = [UIImage imageNamed:@"账号.png"];
    UIImageView *userImageView = [[UIImageView alloc] initWithImage:userImage];
    userImageView.frame = CGRectMake(0, 0, 10, 10);
    self.UserNameText.backgroundColor = [UIColor whiteColor];
    self.UserNameText.leftView = userImageView;
    self.UserNameText.leftViewMode = UITextFieldViewModeAlways;
    
    self.PassWordText = [[UITextField alloc] initWithFrame:CGRectMake(screenWidth / 2 - 150, 500, 300, 40)];
    UIImage *passwordImage = [UIImage imageNamed:@"密码.png"];
    UIImageView *passwordImageView = [[UIImageView alloc] initWithImage:passwordImage];
    passwordImageView.frame = CGRectMake(0, 0, 10, 10);
    self.PassWordText.backgroundColor = [UIColor whiteColor];
    self.PassWordText.leftView = passwordImageView;
    self.PassWordText.leftViewMode = UITextFieldViewModeAlways;
    
    self.ConfirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.ConfirmButton setTitle:@"确 认 注 册" forState:UIControlStateNormal];
    self.ConfirmButton.frame = CGRectMake(screenWidth / 2 - 70, 580, 140, 50);
    self.ConfirmButton.layer.borderWidth = 0.8f;
    self.ConfirmButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.ConfirmButton.layer.cornerRadius = 10;
    [self.ConfirmButton addTarget:self action:@selector(pressConfirm) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.scrollView addGestureRecognizer:tap];
    
    self.EmailText.delegate = self;
    self.UserNameText.delegate = self;
    self.PassWordText.delegate = self;
    
    [self.scrollView addSubview:shareImageView];
    [self.scrollView addSubview:titleLabel];
    [self.scrollView addSubview:self.EmailText];
    [self.scrollView addSubview:self.UserNameText];
    [self.scrollView addSubview:self.PassWordText];
    [self.scrollView addSubview:self.ConfirmButton];
    [self.view addSubview:self.scrollView];
}

-(void)dissmissKeyboard {
    [self.EmailText resignFirstResponder];
    [self.UserNameText resignFirstResponder];
    [self.PassWordText resignFirstResponder];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.scrollView setContentOffset:CGPointMake(0, 100) animated:YES];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

-(void)pressConfirm {
    if ([self.UserNameText.text isEqual:@" "] || [self.PassWordText.text isEqual:@" "] || self.UserNameText.text.length == 0 || self.PassWordText.text.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注册失败" message:@"账号或密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:confirm];
        [self presentViewController:alert animated:YES completion:nil];
    } else if (![self isValidEmail:self.EmailText.text]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注册失败" message:@"邮箱格式不正确" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:confirm];
        [self presentViewController:alert animated:YES completion:nil];
    }  else if (self.UserNameText.text.length < 6 || self.PassWordText.text.length < 6) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"账号或密码不得小于6位" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        NSString *UserName = self.UserNameText.text;
        NSString *PassWord = self.PassWordText.text;
        NSDictionary *dict = [NSDictionary dictionaryWithObject:PassWord forKey:UserName];
        [self.dictionary addEntriesFromDictionary:dict];
        //self.dictionary交给代理对象self.dictDelegate执行方法setupInformation
        [self.dictDelegate setupInformation:self.dictionary];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(BOOL)isValidEmail:(NSString*)email {
    //[A-Z0-9a-z._%+-]:用户名部分
    //+:表示至少出现1次
    //@:邮箱中的@
    //[A-Za-z0-9.-]:域名(qq）
    //\.[A-Za-z]{2,}:后缀(.com）
    //\.:实际的点(.)
    //[A-Za-z]{2,}:表示至少2个字母
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}";
    //NSPredicate:Foundation框架中匹配正则的类
    //SELF:传入的邮箱字符串
    //MATCHES:正则表达式匹配
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailPredicate evaluateWithObject:email];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (text.length > 20) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"输入不能超过20位" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
