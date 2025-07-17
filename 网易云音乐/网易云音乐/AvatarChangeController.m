//
//  AvatarChangeController.m
//  网易云音乐
//
//  Created by mac on 2025/7/15.
//

#import "AvatarChangeController.h"

@interface AvatarChangeController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger selectedCount;
@end

@implementation AvatarChangeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更换头像";
    self.view.backgroundColor = [UIColor whiteColor];
    self.selectedCount = 0;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.contentSize = CGSizeMake(screenWidth, 900);
    [self.view addSubview:self.scrollView];
    for (int i = 0; i < 9; i++) {
        NSString *imageName = [NSString stringWithFormat:@"avatar%d.jpg", i + 1];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(10 + (i % 3) * 125, (i / 3) * 165 + 20, 110, 110);
        imageView.userInteractionEnabled = YES;
        imageView.tag = 101 + i;
        imageView.layer.borderWidth = 0;

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressTap:)];
        [imageView addGestureRecognizer:tap];
        [self.scrollView addSubview:imageView];
    }
    UIBarButtonItem *confirm = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStyleDone target:self action:@selector(pressConfirm)];
    self.navigationItem.rightBarButtonItem = confirm;
}


- (void)pressTap:(UITapGestureRecognizer *)tap {
    UIImageView *imageView = (UIImageView *)tap.view;
    if (imageView.layer.borderWidth == 2) {
        imageView.layer.borderWidth = 0;
        imageView.layer.borderColor = nil;
        self.selectedCount--;
    } else {
        imageView.layer.borderWidth = 2;
        imageView.layer.borderColor = [UIColor blueColor].CGColor;
        self.selectedCount++;
    }
}

- (void)pressConfirm {
    if (self.selectedCount == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"请选择一张图片更换" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    } else if (self.selectedCount == 1) {
        for (UIView *subView in self.scrollView.subviews) {
            if ([subView isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView = (UIImageView *)subView;
                if (imageView.layer.borderWidth == 2) {
                    if ([self.delegate respondsToSelector:@selector(ChangePhoto:)]) {
                        [self.delegate ChangePhoto:imageView.image];
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                    break;
                }
            }
        }
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"禁止选择多张照片进行更换" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

