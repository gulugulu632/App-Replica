//
//  EditViewControl.m
//  3GShare
//
//  Created by mac on 2025/7/23.
//

#import "EditViewControl.h"
#import "PhotoChangeViewController.h"

@interface EditViewControl ()<UITableViewDelegate, UITableViewDataSource, PhotoDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UITableView *cellTableView;

@end

@implementation EditViewControl

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    self.tableView.showsHorizontalScrollIndicator = YES;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    self.title = @"上传";
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(pressLeft)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    UIImage *photoImage = [UIImage imageNamed:@"选择照片.png"];
    UIImageView *photoImageView = [[UIImageView alloc] initWithImage:photoImage];
    photoImageView.frame = CGRectMake(10, 10, (screenWidth - 20) / 2, 130);
    photoImageView.clipsToBounds = YES;
    photoImageView.userInteractionEnabled = YES;
    photoImageView.tag = 999;
    [self.tableView addSubview:photoImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressPhoto:)];
    [photoImageView addGestureRecognizer:tap];
    
    self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth - 20) / 2 - 30, 5, 30, 30)];
    self.countLabel.backgroundColor = [UIColor redColor];
    self.countLabel.textColor = [UIColor whiteColor];
    self.countLabel.font = [UIFont boldSystemFontOfSize:14];
    self.countLabel.textAlignment = NSTextAlignmentCenter;
    self.countLabel.layer.cornerRadius = 15;
    self.countLabel.clipsToBounds = YES;
    self.countLabel.hidden = YES;
    [photoImageView addSubview:self.countLabel];
    
    UIImage *line = [UIImage imageNamed:@"灰线.png"];
    UIImageView *lineImageView = [[UIImageView alloc] initWithImage:line];
    lineImageView.frame = CGRectMake(0, 145, screenWidth, 10);
    [self.tableView addSubview:lineImageView];
    
    NSArray *buttons1 = @[@"平面设计", @"网页设计", @"UI/icon", @"绘画/手绘"];
    NSArray *buttons2 = @[@"虚拟与设计", @"影视", @"摄影", @"其他"];
    
    for (int i = 0; i < 4; i++) {
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
        if (i == 3) {
            btn1.frame = CGRectMake(10 + i * 90, 160, 100, 30);
        } else {
            btn1.frame = CGRectMake(10 + i * 90, 160, 80, 30);
        }
        [btn1 setTitle:buttons1[i] forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn1.titleLabel.font = [UIFont systemFontOfSize:18];
        btn1.backgroundColor = [UIColor whiteColor];
        [btn1 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.tableView addSubview:btn1];
    }
    
    for (int i = 0; i < 4; i++) {
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
        if (i == 0) {
            btn2.frame = CGRectMake(10, 200, 100, 30);
        } else {
            btn2.frame = CGRectMake(30 + i * 90, 200, 80, 30);
        }
        [btn2 setTitle:buttons2[i] forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn2.titleLabel.font = [UIFont systemFontOfSize:18];
        btn2.backgroundColor = [UIColor whiteColor];
        [btn2 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.tableView addSubview:btn2];
    }
    
    UITextField *nameField = [[UITextField alloc] initWithFrame:CGRectMake(10, 240, screenWidth - 20, 30)];
    nameField.text = @"作品名称";
    nameField.font = [UIFont systemFontOfSize:16];
    nameField.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    nameField.borderStyle = UITextBorderStyleRoundedRect;
    [self.tableView addSubview:nameField];
    
    UITextView *summaryView = [[UITextView alloc] initWithFrame:CGRectMake(10, 280, screenWidth - 20, 130)];
    summaryView.text = @"请添加作品说明/文章内容......";
    summaryView.font = [UIFont systemFontOfSize:16];
    summaryView.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    summaryView.textContainerInset = UIEdgeInsetsMake(8, 3, 5, 5);//内边距:(上, 左, 下, 右)
    [self.tableView addSubview:summaryView];
    
    UIButton *postBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    postBtn.backgroundColor = [UIColor colorWithRed:79/225.0f green:141/225.0f blue:198/225.0f alpha:1];
    [postBtn setTitle:@"发布" forState:UIControlStateNormal];
    [postBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    postBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    postBtn.frame = CGRectMake(10, 420, screenWidth - 20, 50);
    [postBtn addTarget:self action:@selector(pressPost) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:postBtn];
    
    UIButton *banBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [banBtn setImage:[UIImage imageNamed:@"自动未选中"] forState:UIControlStateNormal];
    [banBtn addTarget:self action:@selector(pressBan:) forControlEvents:UIControlEventTouchUpInside];
    [banBtn setImage:[UIImage imageNamed:@"自动选中"] forState:UIControlStateSelected];
    banBtn.frame = CGRectMake(10, 480, 20, 20);
    [self.tableView addSubview:banBtn];
    
    UILabel *banLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 480, 80, 20)];
    banLabel.text = @"禁止下载";
    banLabel.font = [UIFont systemFontOfSize:14];
    [self.tableView addSubview:banLabel];
    
    UIImage *image = [UIImage imageNamed:@"陕西西安.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(screenWidth - 190, 33, screenWidth / 2 - 35, 48);
    [self.tableView addSubview:imageView];
    
    self.cellTableView = [[UITableView alloc] initWithFrame:CGRectMake(screenWidth - 180, 90, 95, 30) style:UITableViewStylePlain];
    self.cellTableView.backgroundColor = [UIColor whiteColor];
    self.cellTableView.layer.borderColor = [UIColor blackColor].CGColor;
    self.cellTableView.layer.borderWidth = 1.0;
    self.cellTableView.delegate = self;
    self.cellTableView.dataSource = self;
    [self.tableView addSubview:self.cellTableView];
    
    self.cellArr = [NSMutableArray arrayWithObjects:@"原创作品", @"设计资料", @"设计观点", @"设计教程", nil];
    self.cellBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.cellBtn.frame = CGRectMake(screenWidth - 85, 90, 30, 30);
    [self.cellBtn setImage:[UIImage imageNamed:@"未展开.png"] forState:UIControlStateNormal];
    [self.cellBtn addTarget:self action:@selector(pressCell:) forControlEvents:UIControlEventTouchUpInside];
    self.cellBtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.cellBtn.layer.borderWidth = 1.0;
    self.cellBtn.tag = 0;
    if (self.cellBtn.tag == 0) {
        self.cellTableView.frame = CGRectMake(screenWidth - 180, 90, 95, 30);
    }
    [self.tableView addSubview:self.cellBtn];
}

-(void)pressLeft {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)pressBtn:(UIButton*) btn {
    if (btn.backgroundColor == [UIColor whiteColor]) {
        btn.backgroundColor = [UIColor colorWithRed:79/225.0f green:141/225.0f blue:198/225.0f alpha:1];
    } else {
        btn.backgroundColor = [UIColor whiteColor];
    }
}

-(void)pressBan:(UIButton*) banBtn {
    if (banBtn.selected == YES) {
        banBtn.selected = NO;
    } else {
        banBtn.selected = YES;
    }
}

-(void)pressCell:(UIButton*) btn {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    if (btn.tag == 0) {
        [btn setImage:[UIImage imageNamed:@"未展开.png"] forState:UIControlStateNormal];
        self.cellTableView.frame = CGRectMake(screenWidth - 180, 90, 95, 30);
        btn.tag++;
    } else {
        [btn setImage:[UIImage imageNamed:@"展开.png"] forState:UIControlStateNormal];
        self.cellTableView.frame = CGRectMake(screenWidth - 180, 90, 95, 120);
        btn.tag--;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *strID = @"id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strID];
    }
    cell.textLabel.text = [self.cellArr objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *select = self.cellArr[indexPath.row];//先保存
    [self.cellArr removeObjectAtIndex:indexPath.row];//再移除原位置
    [self.cellArr insertObject:select atIndex:0];//最后放到顶部
    [self.cellTableView reloadData];
    [self pressCell:self.cellBtn];
}

-(void)pressPhoto:(UIButton*) button {
    PhotoChangeViewController *photoVC = [[PhotoChangeViewController alloc] init];
    photoVC.delegate = self;
    [self.navigationController pushViewController:photoVC animated:YES];
}

-(void)PhotoChange:(UIImage *)image andCount:(NSInteger)count {
    if (count > 0) {
        self.countLabel.text = [NSString stringWithFormat:@"%ld", (long)count];
        self.countLabel.hidden = NO;
        UIImageView *photoImageView = [self.tableView viewWithTag:999];
        if ([photoImageView isKindOfClass:[UIImageView class]]) {
            photoImageView.image = image;
        }
    } else {
        self.countLabel.hidden = YES;
    }
}

-(void)pressPost {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您已经成功发布！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
