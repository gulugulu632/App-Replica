//
//  PhotoChangeViewController.h
//  3GShare
//
//  Created by mac on 2025/7/23.
//

#import <UIKit/UIKit.h>

@protocol PhotoDelegate <NSObject>

-(void)PhotoChange:(UIImage*)image andCount:(NSInteger)count;

@end

@interface PhotoChangeViewController : UIViewController

@property(nonatomic, assign) NSInteger selectedCount;
@property(nonatomic, strong) NSMutableArray *photoArr;

@property(nonatomic, weak) id<PhotoDelegate> delegate;

@end
