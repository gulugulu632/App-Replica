//
//  PhotoChangeViewController.m
//  3GShare
//
//  Created by mac on 2025/7/23.
//

#import "PhotoChangeViewController.h"

@interface PhotoChangeViewController ()

@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, assign) NSInteger selectCount;

@end

@implementation PhotoChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.contentSize = CGSizeMake(screenWidth, 930);
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    self.selectCount = 0;
    
    self.title = @"选择图片";
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"返回.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(pressLeft)];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStyleDone target:self action:@selector(pressRight)];
    [rightBtn setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    self.photoArr = [NSMutableArray array];
    for (int i = 0; i < 36; i++) {
        NSString *imageName = [NSString stringWithFormat:@"WechatIMG%d.jpg", i + 1];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(8 + (i % 4) * 100, 10 + (i / 4) * 100, (screenWidth - 50) / 4, (screenWidth - 50) / 4);
        imageView.userInteractionEnabled = YES;
        imageView.tag = i + 1;
        imageView.layer.borderWidth = 5;
        [self.scrollView addSubview:imageView];
        
        UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        photoBtn.frame = imageView.bounds;
        photoBtn.backgroundColor = [UIColor clearColor];
        photoBtn.tag = i + 1;
        [photoBtn addTarget:self action:@selector(pressPhotobtn:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:photoBtn];
    }
}

-(void)pressLeft {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)pressRight {
    if (self.selectCount > 0) {
        NSString *firstPhoto = self.photoArr.firstObject;
        UIImage *image = [UIImage imageNamed:firstPhoto];
        UIAlertController *elertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定所选内容" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
            [self.delegate PhotoChange:image andCount:self.selectCount];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [elertView addAction:action];
        [self presentViewController:elertView animated:YES completion:nil];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您并为选择图片" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
- (void)pressPhotobtn:(UIButton*)button {
    button.selected = !button.selected;
    NSString *imgName = [NSString stringWithFormat:@"WechatIMG%d.jpg", (int)button.tag];
    
    if (button.selected) {
        if (self.selectCount > 8) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"所选照片不得超过9张" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [self.navigationController presentViewController:alert animated:YES completion:nil];
        } else  {
            self.selectCount++;
            [self.photoArr addObject:imgName];
            UIImageView *existingCheck = [button.superview viewWithTag:9999];
            if (!existingCheck) {
                UIImage *ConfirmImage = [UIImage imageNamed:@"确定.png"];
                UIImageView *ConfirmImageView = [[UIImageView alloc] initWithImage:ConfirmImage];
                ConfirmImageView.tag = 9999;
                ConfirmImageView.frame = CGRectMake(button.bounds.size.width - 25, 5, 20, 20);
                [button.superview addSubview:ConfirmImageView];
            }
        }
    } else {
        if (self.selectCount > 8) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"所选照片不得超过9张" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [self.navigationController presentViewController:alert animated:YES completion:nil];
        } else {
            self.selectCount--;
            [self.photoArr removeObject:imgName];
            UIImageView *existingCheck = [button.superview viewWithTag:9999];
            if (existingCheck) {
                [existingCheck removeFromSuperview];
            }
        }
    }
}

@end
