//
//  MoreView.m
//  网易云音乐
//
//  Created by mac on 2025/7/17.
//

#import "MoreView.h"
#import "MoreCell.h"
#import "MusicCell.h"
#import "PostCell.h"
#import "NoteCell.h"

@interface MoreView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation MoreView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.switchOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"NightMode"];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[MoreCell class] forCellReuseIdentifier:@"MoreCell"];
    self.tableView.backgroundColor = [UIColor whiteColor];
    if (self.switchOn) {
        self.tableView.backgroundColor = [UIColor grayColor];
    } else {
        self.tableView.backgroundColor = [UIColor whiteColor];
    }
    [self.view addSubview:self.tableView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 5;
    } else if (section == 2) {
        return 1;
    } else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 50);
    return view;
}

NSArray *labels = @[@"音乐卡片", @"编辑资料", @"更换封面", @"隐私设置", @"分享"];
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoreCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        cell.titleLabel.text = @"Dannnaaa";
        cell.titleLabel.font = [UIFont boldSystemFontOfSize:24];
    } else if (indexPath.section == 1) {
        cell.titleLabel.text = labels[indexPath.row];
        cell.titleLabel.font = [UIFont systemFontOfSize:16];
        cell.titleLabel.textAlignment = NSTextAlignmentLeft;
    } else if (indexPath.section == 2 ) {
        cell.titleLabel.text = @"夜间模式";
        cell.titleLabel.font = [UIFont systemFontOfSize:16];
        cell.titleLabel.textAlignment = NSTextAlignmentLeft;
        cell._switch.hidden = NO;
        [cell._switch setOn:self.switchOn];
        [cell._switch addTarget:self action:@selector(pressSwitch:) forControlEvents:UIControlEventValueChanged];
        CGFloat switchWidth = cell._switch.bounds.size.width;
        CGFloat switchHeight = cell._switch.bounds.size.height;
        CGFloat cellHeight = tableView.rowHeight;
        cell._switch.frame = CGRectMake(tableView.bounds.size.width - switchWidth - 15, (cellHeight - switchHeight) / 2 + 25, switchWidth, switchHeight);
    } else {
        cell._switch.hidden = YES;
        cell.titleLabel.text = @"已经到底啦";
        cell.titleLabel.font = [UIFont systemFontOfSize:12];
        cell.titleLabel.textAlignment = NSTextAlignmentCenter;
        BOOL isNight = [[NSUserDefaults standardUserDefaults] boolForKey:@"NightMode"];
        [cell._switch setOn:isNight animated:NO];
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

//点击事件,点击时调用
-(void)pressSwitch:(UISwitch*)sw {
    self.switchOn = sw.isOn;
    NSDictionary *dict = @{@"switch": @(self.switchOn)};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SwitchChanged" object:nil userInfo:dict];
    BOOL YoN = self.switchOn;//当前开关状态
    
//    通知传值
//    "switch"是传值时的key,其他界面用该key读取
     
    //保存到磁盘,次打开app仍然存在(保存状态)
    //[[NSUserDefaults standardUserDefaults] setBool:YoN forKey:@"NightMode"];
    //搭配使用:BOOL isNight = [[NSUserDefaults standardUserDefaults] boolForKey:@"NightMode"];
    
    //当前app运行时的广播消息,临时关闭app后失效(通知其他对象)
//    通过通知中心发出通知
//    参数1:通知名称(其中包含传值的字典dict) 参数2:可以发放通知的对象 参数3:用于传值的
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"SwitchChanged" object:nil userInfo:dict];
    //搭配使用:[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleThemeChange:) name:kNightModeChangedNotification object:nil];
    
    [[NSUserDefaults standardUserDefaults] setBool:YoN forKey:@"NightMode"];
    
    if (self.switchOn) {
        [self.tableView reloadData];
        self.view.backgroundColor = [UIColor grayColor];
        self.tableView.backgroundColor = [UIColor grayColor];
        self.tabBarController.tabBar.backgroundColor = [UIColor grayColor];
        self.tabBarController.tabBar.barTintColor = [UIColor grayColor];
        self.tabBarController.tabBar.tintColor = [UIColor grayColor];
    }
    else {
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tabBarController.tabBar.backgroundColor = [UIColor whiteColor];
        self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
        self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
        [self.tableView reloadData];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
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
