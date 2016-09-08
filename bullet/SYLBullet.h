//
//  SYLBulletText.h
//  bullet
//
//  Created by Yue Shen on 16/9/7.
//  Copyright © 2016年 Yue Shen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, BulletPosition) {
    topRightToLeft,        //顶部显示(屏幕的上方显示)
    bottomFixPosition,     //底部显示(屏幕的下方固定位置)
};
typedef  void(^AnimationFinishedBlock)();
@interface SYLBullet : UILabel
@property (nonatomic,assign)BulletPosition positon;
@property (nonatomic,copy)AnimationFinishedBlock animationFinishedBlock;
- (void)createTime;
@end
