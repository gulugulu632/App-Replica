//
//  LoginViewControl.m
//  3GShare
//
//  Created by mac on 2025/7/19.
//

#import "LoginViewControl.h"
#import "RegisterViewControl.h"
#import "HomeViewControl.h"
#import "SearchViewControl.h"
#import "ArticleViewControl.h"
#import "ActivityViewControl.h"
#import "MyViewControl.h"

@interface LoginViewControl ()<UITextFieldDelegate, UITabBarDelegate, InformationDelegate>
@property(nonatomic, strong) UIScrollView *scrollView;
@end

@implementation LoginViewControl

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.view.backgroundColor = [UIColor colorWithRed:79/225.0f green:141/225.0f blue:198/225.0f alpha:1];

    self.dict = [[NSMutableDictionary alloc] init];
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.contentSize = CGSizeMake(screenWidth, 1000);
    self.scrollView.scrollEnabled = YES;

    self.shareImage = [UIImage imageNamed:@"share logo.png"];
    self.shareImageView = [[UIImageView alloc] initWithImage:self.shareImage];
    self.shareImageView.frame = CGRectMake(screenWidth / 2 - 75, 130, 150, 150);
    self.shareImageView.layer.cornerRadius = 75;
    self.shareImageView.clipsToBounds = YES;

    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth / 2 - 70, 270, 140, 70)];
    self.titleLabel.text = @"SHARE";
    self.titleLabel.font = [UIFont boldSystemFontOfSize:42];
    self.titleLabel.textColor = [UIColor whiteColor];

    self.UserNameText = [[UITextField alloc] initWithFrame:CGRectMake(screenWidth / 2 - 150, 400, 300, 40)];
    UIImage *userImage = [UIImage imageNamed:@"账号.png"];
    UIImageView *userImageView = [[UIImageView alloc] initWithImage:userImage];
    userImageView.frame = CGRectMake(0, 0, 10, 10);
    self.UserNameText.backgroundColor = [UIColor whiteColor];
    self.UserNameText.leftView = userImageView;
    self.UserNameText.leftViewMode = UITextFieldViewModeAlways;
    //UITextFieldViewModeNever        // 从不显示
    //UITextFieldViewModeWhileEditing // 编辑时显示
    //UITextFieldViewModeUnlessEditing// 非编辑时显示
    //UITextFieldViewModeAlways        // 一直显示

    self.PassWordText = [[UITextField alloc] initWithFrame:CGRectMake(screenWidth / 2 - 150, 450, 300, 40)];
    UIImage *passImage = [UIImage imageNamed:@"密码.png"];
    UIImageView *passImageView = [[UIImageView alloc] initWithImage:passImage];
    passImageView.frame = CGRectMake(0, 0, 10, 10);
    self.PassWordText.backgroundColor = [UIColor whiteColor];
    self.PassWordText.leftView = passImageView;
    self.PassWordText.leftViewMode = UITextFieldViewModeAlways;

    self.Loginbt = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.Loginbt setTitle:@"登 陆" forState:UIControlStateNormal];
    self.Loginbt.frame = CGRectMake(screenWidth / 4 - 28, 520, 100, 40);
    self.Loginbt.layer.borderWidth = 0.8f;
    self.Loginbt.layer.borderColor = [UIColor whiteColor].CGColor;
    self.Loginbt.layer.cornerRadius = 10;
    [self.Loginbt addTarget:self action:@selector(pressLogin) forControlEvents:UIControlEventTouchUpInside];

    self.Registerbt = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.Registerbt setTitle:@"注 册" forState:UIControlStateNormal];
    self.Registerbt.frame = CGRectMake(screenWidth / 4 + 120, 520, 100, 40);
    self.Registerbt.layer.borderWidth = 0.8f;
    self.Registerbt.layer.borderColor = [UIColor whiteColor].CGColor;
    self.Registerbt.layer.cornerRadius = 10;
    [self.Registerbt addTarget:self action:@selector(pressRegister) forControlEvents:UIControlEventTouchUpInside];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.scrollView addGestureRecognizer:tap];
    
    self.UserNameText.delegate = self;
    self.PassWordText.delegate = self;
    
    self.Autobt = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.Autobt setImage:[UIImage imageNamed:@"自动未选中.png"] forState:UIControlStateNormal];
    [self.Autobt addTarget:self action:@selector(pressAuto) forControlEvents:UIControlEventTouchUpInside];
    [self.Autobt setImage:[UIImage imageNamed:@"自动选中"] forState:UIControlStateSelected];
    self.Autobt.frame = CGRectMake(50, 580, 20, 20);
    self.autoLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 580, 80, 20)];
    self.autoLabel.text = @"自动登录";
    self.autoLabel.font = [UIFont systemFontOfSize:14];

    [self.scrollView addSubview:self.shareImageView];
    [self.scrollView addSubview:self.titleLabel];
    [self.scrollView addSubview:self.UserNameText];
    [self.scrollView addSubview:self.PassWordText];
    [self.scrollView addSubview:self.Loginbt];
    [self.scrollView addSubview:self.Registerbt];
    [self.scrollView addSubview:self.autoLabel];
    [self.scrollView addSubview:self.Autobt];
    [self.view addSubview:self.scrollView];
}

-(void)setupInformation:(NSMutableDictionary*)dictionary {
    [self.dict addEntriesFromDictionary:dictionary];
}

-(void)dissmissKeyboard {
    [self.UserNameText resignFirstResponder];
    [self.PassWordText resignFirstResponder];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.scrollView setContentOffset:CGPointMake(0, 100) animated:YES];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

//翻页时显示，避免影响其他页面
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

-(void)pressLogin {
    self.PassWordstr = [self.dict valueForKey:self.UserNameText.text];
    if ((self.PassWordstr != nil) && ([self.PassWordText.text isEqual:self.PassWordstr])) {
        HomeViewControl *homeVC = [[HomeViewControl alloc] init];
        homeVC.title = @"SHARE";
        homeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"主页.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"主页选中.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
        
        SearchViewControl *searchVC = [[SearchViewControl alloc] init];
        searchVC.title = @"搜索";
        searchVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"搜索.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"搜索选中.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        UINavigationController *searchNav = [[UINavigationController alloc] initWithRootViewController:searchVC];
    
        ArticleViewControl *articleVC = [[ArticleViewControl alloc] init];
        articleVC.title = @"文章";
        articleVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"文章.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"文章选中.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        UINavigationController *articleNav = [[UINavigationController alloc] initWithRootViewController:articleVC];
        
        ActivityViewControl *activityVC = [[ActivityViewControl alloc] init];
        activityVC.title = @"活动";
        activityVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"活动.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"活动选中.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        UINavigationController *activityNav = [[UINavigationController alloc] initWithRootViewController:activityVC];
        
        MyViewControl *myVC = [[MyViewControl alloc] init];
        myVC.title = @"个人信息";
        myVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"我的.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"我的选中.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        UINavigationController *myNav = [[UINavigationController alloc] initWithRootViewController:myVC];
        
        UITabBarController *tab = [[UITabBarController alloc] init];
        tab.tabBar.tintColor = [UIColor colorWithRed:79/225.0f green:141/225.0f blue:198/225.0f alpha:1];
        tab.tabBar.backgroundColor = [UIColor blackColor];
        tab.viewControllers = @[homeNav, searchNav, articleNav, activityNav, myNav];
        [self.tabDelegate tabBarMode:tab];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"登录失败" message:@"账号或密码错误，请重试" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:confirm];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

-(void)pressRegister {
    RegisterViewControl *registerVC = [[RegisterViewControl alloc] init];
    registerVC.dictDelegate = self;
    [self.navigationController pushViewController:registerVC animated:YES];
}

-(void)pressAuto {
    if (self.Autobt.selected == NO) {
        self.Autobt.selected = YES;
    } else {
        self.Autobt.selected = NO;
    }
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
