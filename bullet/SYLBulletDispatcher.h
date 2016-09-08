//
//  SYBulletDispatcher.h
//  bullet
//
//  Created by Yue Shen on 16/9/7.
//  Copyright © 2016年 Yue Shen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SYLBulletView.h"
#import "SYLBulletTrajectory.h"
@interface SYLBulletDispatcher : NSObject
@property (nonatomic,assign)Boolean isRunning;
+ (instancetype)sharedInstance;
- (void)setBulletView:(SYLBulletView *)bulletView;
- (void)addBullet:(SYLBullet*)bullet;
@end
