//
//  EditViewControl.h
//  3GShare
//
//  Created by mac on 2025/7/23.
//

#import <UIKit/UIKit.h>

@class EditViewControl;

@protocol EditViewDelegate <NSObject>

-(void)didTapPhotoView:(EditViewControl*)photo;

@end

@interface EditViewControl : UIViewController

@property(nonatomic, strong) NSMutableArray *cellArr;
@property(nonatomic, strong) UIButton *cellBtn;
@property(nonatomic, strong) UILabel *countLabel;

@property(nonatomic, weak) id<EditViewDelegate>delegate;

@end
