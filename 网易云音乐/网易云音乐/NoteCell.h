//
//  NoteCell.h
//  网易云音乐
//
//  Created by mac on 2025/7/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NoteCell : UITableViewCell
- (void)setupSong:(NSDictionary *)song;
@end

NS_ASSUME_NONNULL_END
