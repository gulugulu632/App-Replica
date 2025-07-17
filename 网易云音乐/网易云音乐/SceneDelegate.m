//
//  SceneDelegate.m
//  网易云音乐
//
//  Created by mac on 2025/7/15.
//

#import "SceneDelegate.h"
#import "VCRoot01.h"
#import "VCRoot02.h"
#import "VCRoot03.h"

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
    VCRoot01 *vc1 = [[VCRoot01 alloc] init];
    vc1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"推荐" image:[UIImage imageNamed:@"每日推荐.png"] tag:0];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    VCRoot02 *vc2 = [[VCRoot02 alloc] init];
    vc2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:[UIImage imageNamed:@"发现.png"] tag:1];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    VCRoot03 *vc3 = [[VCRoot03 alloc] init];
    vc3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"账号" image:[UIImage systemImageNamed:@"person.crop.circle"] tag:2];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[nav1, nav2, nav3];
    tabBarController.tabBar.tintColor = [UIColor redColor];
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
}

@end

