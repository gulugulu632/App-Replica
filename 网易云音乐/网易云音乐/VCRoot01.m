//
//  VCRoot01.m
//  网易云音乐
//
//  Created by mac on 2025/7/15.
//

#import "VCRoot01.h"
#import "HomeHeaderCell.h"
#import "OtherCell.h"
@interface VCRoot01 ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UISearchBar *searchBar;
@property(nonatomic, assign) BOOL isNight;
@end

@implementation VCRoot01

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    UIView *navBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 60)];
    navBarView.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *moreItem = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"line.3.horizontal"] style:UIBarButtonItemStylePlain target:self action:@selector(pressMore)];
    moreItem.tintColor = [UIColor redColor];
    self.navigationItem.leftBarButtonItem = moreItem;
    UIBarButtonItem *micItem = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"mic.fill"] style:UIBarButtonItemStylePlain target:self action:@selector(pressMusic)];
    micItem.tintColor = [UIColor redColor];
    self.navigationItem.rightBarButtonItem = micItem;
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 120, 36)];
    self.searchBar.placeholder = @"top barry";
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    UIView *searchTextField = [self.searchBar valueForKey:@"searchField"];
    if ([searchTextField isKindOfClass:[UITextField class]]) {
        UITextField *textField = (UITextField *)searchTextField;
        textField.backgroundColor = [UIColor whiteColor];
        textField.layer.cornerRadius = 8;
        textField.layer.masksToBounds = YES;
    }
    self.navigationItem.titleView = self.searchBar;
    //收起键盘
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmissKeyboard)];
    tap.cancelsTouchesInView = NO;//不影响其他点击事件
    [self.view addGestureRecognizer:tap];
    //方法一:添加点击手势识别器
    //全局有效，点击任意非 UISearchBar 区域都能收起键盘
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmissKeyboard)];
//    tap.cancelsTouchesInView = NO; ⚠️
//    [self.view addGestureRecognizer:tap];
//    -(void)dissmissKeyboard {
//        [self.searchBar resignFirstResponder];
//    }
    //方法二:重写 touchesBegan: 方法
    //不适用于 UIScrollView 或 UITableView 中，因为它们本身会拦截 touchesBegan:，导致这个方法不执行
//    - (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//        [super touchesBegan:touches withEvent:event];
//        UITouch* touch = [touches anyObject];
//        if (![touch.view isDescendantOfView:self.searchBar]) {
//            [self.searchBar resignFirstResponder];
//        }
//    }
    //方法三:使用 UISearchBarDelegate
    //针对点击 搜索按钮 或 取消按钮 时自动关闭键盘 适合配合方法一或方法二一起使用，补充行为
//    self.searchBar.delegate = self;
//
//    - (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
//        [searchBar resignFirstResponder];
//    }
//
//    - (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
//        [searchBar resignFirstResponder];
//    }
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[HomeHeaderCell class] forCellReuseIdentifier:@"HomeHeaderCell"];
    [self.tableView registerClass:[OtherCell class] forCellReuseIdentifier:@"OtherCell"];
    [self.view addSubview:self.tableView];
    //通知传值需要在每个页面监听这个通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleThemeChange:) name:@"SwitchChanged" object:nil];
}

-(void)handleThemeChange:(NSNotification*)notification {
    NSDictionary *userInfo = notification.userInfo;
    BOOL isDark = [userInfo[@"switch"] boolValue];
    if (isDark) {
        self.view.backgroundColor = [UIColor grayColor];
        self.tableView.backgroundColor = [UIColor grayColor];
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
        self.tableView.backgroundColor = [UIColor whiteColor];
    }
    [self.tableView reloadData];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)dissmissKeyboard {
    [self.searchBar resignFirstResponder];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 460;
    } else if (indexPath.section == 1) {
        return 500;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        HomeHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeHeaderCell" forIndexPath:indexPath];
        return cell;
    } else {
        OtherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OtherCell" forIndexPath:indexPath];
        return cell;
    }
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
