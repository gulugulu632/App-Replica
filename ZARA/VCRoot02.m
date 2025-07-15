//
//  VCRoot02.m
//  ZARA
//
//  Created by mac on 2025/7/15.
//

#import "VCRoot02.h"

@interface VCRoot02 ()<UIScrollViewDelegate>

@end

@implementation VCRoot02

- (void)viewDidLoad {
    [super viewDidLoad];
    UITabBarItem *taBarItem = [[UITabBarItem alloc] initWithTitle:@"Shopping" image:[UIImage systemImageNamed:@"cart.fill"] tag:1];
    self.titles = @[@"女士", @"男士", @"儿童"];
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:self.titles];
    self.segmentedControl.selectedSegmentIndex = 0;
    [self.segmentedControl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segmentedControl];
    //不自动转换为auto layout，由纯代码手动布局
    self.segmentedControl.translatesAutoresizingMaskIntoConstraints = NO;
    //自动布局
    [NSLayoutConstraint activateConstraints:@[
        [self.segmentedControl.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.segmentedControl.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:20],
        //固定宽高
        [self.segmentedControl.widthAnchor constraintEqualToConstant:300],
        [self.segmentedControl.heightAnchor constraintEqualToConstant:40]
    ]];
    //滚动视图
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.scrollView.topAnchor constraintEqualToAnchor:self.segmentedControl.bottomAnchor constant:20],
        [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
    for (int i = 0; i < 3; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * self.view.bounds.size.width, 0, self.view.bounds.size.width, self.scrollView.bounds.size.height)];
        [self.scrollView addSubview:view];
    }
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 3, self.scrollView.bounds.size.height);
    NSArray *imageNames = @[@"2.jpg", @"3.jpg", @"4.jpg"];
    for (int i = 0; i < 3; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height - 300)];
        view.backgroundColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:view.bounds];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.image = [UIImage imageNamed:imageNames[i]];
        [view addSubview:imageView];
        [self.scrollView addSubview:view];
    }
}

- (void)segmentChanged:(UISegmentedControl *)sender {
    CGFloat offsetX = sender.selectedSegmentIndex * self.scrollView.bounds.size.width;
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger pageIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
    self.segmentedControl.selectedSegmentIndex = pageIndex;
}

@end

