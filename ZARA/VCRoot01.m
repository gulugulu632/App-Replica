//
//  VCRoot01.m
//  ZARA
//
//  Created by mac on 2025/7/15.
//

#import "VCRoot01.h"
#import <UIKit/UIKit.h>

@interface VCRoot01 () <UIScrollViewDelegate>

@end

@implementation VCRoot01

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    UILabel *zaraLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth / 2, 200)];
    zaraLabel.text = @"ZARA";
    zaraLabel.textColor = [UIColor blackColor];
    zaraLabel.font = [UIFont fontWithName:@"Didot-Bold" size:48]; //字体名称
    zaraLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:zaraLabel];
    //无限轮播图
    CGFloat photoHeight = 600;
    self.photoScrollView = [[UIScrollView alloc] init];
    self.photoScrollView.frame = CGRectMake(0, 150, screenWidth, photoHeight);
    self.photoScrollView.pagingEnabled = YES;
    self.photoScrollView.scrollEnabled = YES;
    self.photoScrollView.showsHorizontalScrollIndicator = NO;
    self.photoScrollView.delegate = self;
    self.photoScrollView.contentSize = CGSizeMake(screenWidth * 5, photoHeight);
    for (int i = 0; i <= 5; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%d.jpg", (i % 3) + 1];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        // 特殊处理第一张假图
        if (i == 5) {
            imageView.frame = CGRectMake(0, 0, screenWidth, photoHeight);
        } else {
            imageView.frame = CGRectMake((i + 1) * screenWidth, 0, screenWidth, photoHeight);
        }
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [self.photoScrollView addSubview:imageView];
    }
    [self.photoScrollView setContentOffset:CGPointMake(screenWidth, 0) animated:NO];
    [self.view addSubview:self.photoScrollView];
    //自动轮播定时器
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(autoScrollCarousel) userInfo:nil repeats:YES];
}

-(void)autoScrollCarousel {
    CGFloat currentX = self.photoScrollView.contentOffset.x;
    CGFloat width = self.photoScrollView.frame.size.width;
    [self.photoScrollView setContentOffset:CGPointMake(currentX + width, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat width = scrollView.frame.size.width;
    CGFloat totalWidth = scrollView.contentSize.width;
    
    if (offsetX >= totalWidth - width) {
        [scrollView setContentOffset:CGPointMake(width, 0) animated:NO];
    } else if (offsetX < width - scrollView.frame.size.width) {
        [scrollView setContentOffset:CGPointMake(totalWidth - 2 * width, 0) animated:NO];
    }
}

@end

