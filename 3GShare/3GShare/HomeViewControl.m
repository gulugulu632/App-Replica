//
//  HomeViewControl.m
//  3GShare
//
//  Created by mac on 2025/7/21.
//

#import "HomeViewControl.h"
#import "HomeTableViewCell.h"
#import "FirstViewController.h"

@interface HomeViewControl ()<UITableViewDelegate, UITableViewDataSource, FirstViewControllerDelegate>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation HomeViewControl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UINavigationBarAppearance *homeAppearance = [[UINavigationBarAppearance alloc] init];
    homeAppearance.backgroundColor = [UIColor colorWithRed:79/225.0f green:141/225.0f blue:198/225.0f alpha:1];
    homeAppearance.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:24]};
    self.navigationController.navigationBar.scrollEdgeAppearance = homeAppearance;//滚动状态下样式
    self.navigationController.navigationBar.standardAppearance = homeAppearance;//正常状态下样式
    
    self.likeStates = [NSMutableArray arrayWithArray:@[@(NO), @(NO), @(NO), @(NO)]];
    self.likeCounts = [NSMutableArray arrayWithArray:@[@(32), @(102), @(43), @(453)]];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsHorizontalScrollIndicator = YES;
    
    [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"HomeTableViewCell"];
    
    [self.view addSubview:self.tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 1000;
}

//block回调
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCell" forIndexPath:indexPath];
    
    cell.likehomeCounts[0] = self.likeCounts[0];
    UILabel *label = cell.likehomeLabels[0];
    label.text = [NSString stringWithFormat:@"%ld", (long)[self.likeCounts[0] integerValue]];
    
    //点赞按钮回调
    cell.likeButtonChangedBlock = ^(NSInteger index, BOOL liked, NSInteger count) {
        self.likeCounts[index] = @(count);
        self.likeStates[index] = @(liked);
        //同步更新主页按钮
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection: 0];
        HomeTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        UILabel *likeLabel = cell.likehomeLabels[0];
        likeLabel.text = [NSString stringWithFormat:@"%ld", (long)count];
        UIButton *likeButton = cell.likehomeButtons[0];
        likeButton.selected = liked;
    };
    cell.pressFirst = ^{
        FirstViewController *firstVC = [[FirstViewController alloc] init];
        firstVC.delegate = self;
        //传入当前状态和数量
        firstVC.liked = [self.likeStates[0] boolValue];
        firstVC.likeCount = [self.likeCounts[0] integerValue];
        [self.navigationController pushViewController:firstVC animated:YES];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)UpdateLikeStates:(BOOL)liked count:(NSInteger)count {
    //更新数据
    self.likeStates[0] = @(liked);
    self.likeCounts[0] = @(count);
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    HomeTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.likeButtons[0].selected = liked;
    cell.likehomeCounts[0] = @(count);
    UILabel *label = cell.likehomeLabels[0];
    label.text = [NSString stringWithFormat:@"%ld", (long)count];
}

@end
