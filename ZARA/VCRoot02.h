//
//  VCRoot02.h
//  ZARA
//
//  Created by mac on 2025/7/15.
//

#import <UIKit/UIKit.h>

@interface VCRoot02 : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *titles;

@end

