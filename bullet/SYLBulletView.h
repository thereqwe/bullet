//
//  SYLBulletView.h
//  弹幕的显示容器~
//
//  Created by Yue Shen on 16/9/7.
//  Copyright © 2016年 Yue Shen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYLBullet.h"
@interface SYLBulletView : UIView
- (void)receiveBullet:(NSAttributedString*)string andWithPositon:(BulletPosition)position;
@end
