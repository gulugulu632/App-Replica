//
//  FirstViewController.h
//  3GShare
//
//  Created by mac on 2025/7/22.
//

#import <UIKit/UIKit.h>

@protocol FirstViewControllerDelegate <NSObject>

-(void)UpdateLikeStates:(BOOL)liked count:(NSInteger)count;

@end

@interface FirstViewController : UIViewController

@property(nonatomic, strong) NSMutableArray<NSNumber*> *FirstCountArray;

@property(nonatomic, assign) BOOL liked;
@property(nonatomic, assign) NSInteger likeCount; //当前点赞数量

@property(nonatomic, weak) id<FirstViewControllerDelegate> delegate;

@end
