//
//  AvatarChangeController.h
//  网易云音乐
//
//  Created by mac on 2025/7/15.
//

#import <UIKit/UIKit.h>

//更换头像页面协议
@protocol AvatarDelegate <NSObject>
- (void)ChangePhoto:(UIImage *)image;
@end

@interface AvatarChangeController : UIViewController
@property (nonatomic, weak) id<AvatarDelegate> delegate;
@end


