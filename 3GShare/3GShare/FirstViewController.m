//
//  FirstViewController.m
//  3GShare
//
//  Created by mac on 2025/7/22.
//

#import "FirstViewController.h"
#import "FirstTableViewCell.h"
#import "SecondTableViewCell.h"

@interface FirstViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"SHARE";
    UINavigationBarAppearance *firstAppearance = [[UINavigationBarAppearance alloc] init];
    firstAppearance.backgroundColor = [UIColor colorWithRed:79/225.0f green:141/225.0f blue:198/225.0f alpha:1];
    firstAppearance.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:24]};
    self.navigationController.navigationBar.scrollEdgeAppearance = firstAppearance;
    self.navigationController.navigationBar.standardAppearance = firstAppearance;
    UIBarButtonItem *btnleft = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(pressBack)];
    self.navigationItem.leftBarButtonItem = btnleft;
    
    self.FirstCountArray = [NSMutableArray arrayWithObject:@(32)];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsHorizontalScrollIndicator = YES;
    [self.tableView registerClass:[FirstTableViewCell class] forCellReuseIdentifier:@"FirstTableViewCell"];
    [self.tableView registerClass:[SecondTableViewCell class] forCellReuseIdentifier:@"SecondTableViewCell"];
    [self.view addSubview:self.tableView];
}

-(void)pressBack {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    } else {
        return 1200;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        FirstTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"FirstTableViewCell" forIndexPath:indexPath];
        
        cell.likeviewCounts[0] = @(self.likeCount);
        UILabel *label = cell.likeviewLabels[0];
        label.text = [NSString stringWithFormat:@"%ld", (long)self.likeCount];
        cell.likeButton.selected = self.liked;
        
        cell.likeStatesChangeBlock = ^(BOOL liked, NSInteger count) {
            self.liked = liked;
            self.likeCount = count;
            [self.delegate UpdateLikeStates:liked count:count];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        SecondTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SecondTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

@end
