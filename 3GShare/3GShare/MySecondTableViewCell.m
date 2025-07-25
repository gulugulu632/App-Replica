//
//  MySecondTableViewCell.m
//  3GShare
//
//  Created by mac on 2025/7/24.
//

#import "MySecondTableViewCell.h"

@implementation MySecondTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSettings];
    }
    return self;
}

-(void)setupSettings {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.contentView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    
    NSArray *settings = @[@{@"title":@"我上传的", @"image":@"上传.png", @"button":@"进入.png"},
    @{@"title":@"我的信息", @"image":@"信息.png", @"button":@"进入.png"},
    @{@"title":@"我推荐的", @"image":@"like.png", @"button":@"进入.png"},
    @{@"title":@"院系通知", @"image":@"通知.png", @"button":@"进入.png"},
    @{@"title":@"设置", @"image":@"设置.png", @"button":@"进入.png"},
    @{@"title":@"退出", @"image":@"退出.png", @"button":@"进入.png"}];
    
    for (int i = 0; i < 6; i++) {
        NSDictionary *settingsDict = settings[i];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, i * 60, screenWidth, 50)];
        view.backgroundColor = [UIColor whiteColor];
        
        UIImage *image = [UIImage imageNamed:settingsDict[@"image"]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(20, 14, 20, 20);
        [view addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, 15, 100, 20)];
        label.text = settingsDict[@"title"];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:18];
        [view addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(screenWidth - 50, 14, 20, 20);
        [button setImage:[UIImage imageNamed:settingsDict[@"button"]] forState:UIControlStateNormal];
        [view addSubview:button];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressTap:)];
        view.tag = i;
        [view addGestureRecognizer:tap];
        
        [self.contentView addSubview:view];
    }
}

-(void)pressTap:(UITapGestureRecognizer*)tap {
    UIView *view = tap.view;
    if (view.tag == 0) {
        self.SendBlock();
    } else if (view.tag == 1) {
        self.InformationBlock();
    } else if (view.tag == 2) {
        self.RecommendBlock();
    } else if (view.tag == 4) {
        self.SettingBlock();
    } else {
        self.AlertBlock();
    }
}

@end
