//
//  SceneDelegate.m
//  ZARA
//
//  Created by mac on 2025/7/15.
//

#import "SceneDelegate.h"
#import "VCRoot01.h"
#import "VCRoot02.h"
#import "VCRoot03.h"

@implementation SceneDelegate

// SceneDelegate.m
- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    VCRoot01 *vc1 = [[VCRoot01 alloc] init];
    vc1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Home" image:[UIImage systemImageNamed:@"house.fill"] tag:0];

    VCRoot02 *vc2 = [[VCRoot02 alloc] init];
    vc2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Shopping" image:[UIImage systemImageNamed:@"cart.fill"] tag:1];

    VCRoot03 *vc3 = [[VCRoot03 alloc] init];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    nav3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"User" image:[UIImage systemImageNamed:@"person.crop.circle"] tag:2];

    UITabBarController *tbc = [[UITabBarController alloc] init];
    tbc.viewControllers = @[vc1, vc2, nav3];
    tbc.tabBar.tintColor = [UIColor blueColor];

    self.window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
    self.window.rootViewController = tbc;
    [self.window makeKeyAndVisible];
}

@end
