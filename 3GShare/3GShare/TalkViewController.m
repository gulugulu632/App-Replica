//
//  TalkViewController.m
//  3GShare
//
//  Created by mac on 2025/7/25.
//

#import "TalkViewController.h"

@interface TalkViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation TalkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    
    self.tabBarController.tabBar.hidden = YES;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, screenWidth, [UIScreen mainScreen].bounds.size.height - 170) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsHorizontalScrollIndicator = YES;
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    [self.view addSubview:self.tableView];
    
    UINavigationBarAppearance *TalkAppearance = [[UINavigationBarAppearance alloc] init];
    TalkAppearance.backgroundColor = [UIColor colorWithRed:79/225.0f green:141/225.0f blue:198/225.0f alpha:1];
    TalkAppearance.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:24]};
    self.navigationController.navigationBar.scrollEdgeAppearance = TalkAppearance;
    self.navigationController.navigationBar.standardAppearance = TalkAppearance;
    
    UIBarButtonItem *btnLeft = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(pressLeft)];
    self.navigationItem.leftBarButtonItem = btnLeft;
    
    self.talkArray = [NSMutableArray array];
    self.heightArray = [NSMutableArray array];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 70, screenWidth, 70)];
    view.backgroundColor = [UIColor colorWithRed:79/225.0f green:141/225.0f blue:198/225.0f alpha:1];
    [self.tableView addSubview:view];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 15, screenWidth - 80, 30)];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.font = [UIFont systemFontOfSize:16];
    self.textField.backgroundColor = [UIColor whiteColor];
    self.textField.delegate = self;
    [view addSubview:self.textField];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [view addGestureRecognizer:tap];
    [self.tableView addGestureRecognizer:tap];
    
    self.sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [self.sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.sendBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.sendBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.sendBtn.layer.borderWidth = 1.0;
    self.sendBtn.backgroundColor = [UIColor colorWithRed:79/225.0f green:141/225.0f blue:198/225.0f alpha:1];
    [self.sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.sendBtn.frame = CGRectMake(screenWidth - 50, 19, 40, 20);
    [self.sendBtn addTarget:self action:@selector(pressSend) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.sendBtn];
    
    [self.view addSubview:view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)pressLeft {
    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden = NO;
}

-(void)pressSend {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    CGSize size = [self.textField.text boundingRectWithSize:CGSizeMake(screenWidth * 0.6, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
    self.height = [NSNumber numberWithInt:size.height + 10];
    [self.talkArray addObject:self.textField.text];
    [self.heightArray addObject:self.height];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.talkArray.count - 1 inSection:0];
    //在第indexPath位置插入一行新单元格
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    //[self.tableView reloadData];
    //是的tableView自动滚动底部
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    self.textField.text = @" ";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.talkArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    NSString *text = self.talkArray[indexPath.row];
    CGSize size = [text boundingRectWithSize:CGSizeMake(screenWidth, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
    return MAX(size.height + 30, 60);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    static NSString *strID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strID];
    } else {
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row % 2 != 0) {
        UIImage *otherImage = [UIImage imageNamed:@"WechatIMG2.jpg"];
        UIImageView *otherImageView = [[UIImageView alloc] initWithImage:otherImage];
        otherImageView.frame = CGRectMake(3, 15, 40, 40);
        [cell.contentView addSubview:otherImageView];
        
        UIImageView *chatBox = [[UIImageView alloc] init];
        chatBox.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.text = self.talkArray[indexPath.row];
        label.font = [UIFont systemFontOfSize:18];
        CGSize size = [label.text boundingRectWithSize:CGSizeMake(screenWidth * 0.6, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size;
        label.frame = CGRectMake(55, 20, size.width, size.height);
        chatBox.frame = CGRectMake(50, 10, size.width + 10, size.height + 20);
        [cell.contentView addSubview:chatBox];
        [cell.contentView addSubview:label];
    } else {
        UIImage *selfImage = [UIImage imageNamed:@"假日.png"];
        UIImageView *selfImageView = [[UIImageView alloc] initWithImage:selfImage];
        selfImageView.frame = CGRectMake(360, 15, 40, 40);
        [cell.contentView addSubview:selfImageView];
        
        UIImageView *chatBox = [[UIImageView alloc] init];
        chatBox.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.text = self.talkArray[indexPath.row];
        label.font = [UIFont systemFontOfSize:18];
        CGSize size = [label.text boundingRectWithSize:CGSizeMake(screenWidth * 0.6, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size;
        label.frame = CGRectMake(screenWidth - size.width - 55, 20, size.width, size.height);
        chatBox.frame = CGRectMake(screenWidth - size.width - 60, 10, size.width + 10, size.height + 20);
        [cell.contentView addSubview:chatBox];
        [cell.contentView addSubview:label];
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(void)dissmissKeyboard {
    [self.textField resignFirstResponder];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.tableView setContentOffset:CGPointMake(0, 100) animated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}

-(void)keyboardWillShow:(NSNotification*)notification {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardHeight = keyboardFrame.size.height;
    if (self.view.frame.origin.y == 0) {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.frame = CGRectMake(0, -keyboardHeight, screenWidth, screenHeight);
        }];
    }
}

-(void)keyboardWillHide:(NSNotification*)notification {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    [UIView animateWithDuration:0.3 animations:^{
            self.view.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    }];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
