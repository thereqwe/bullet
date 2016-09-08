//
//  SYLBulletTrajectory.h
//  bullet
//
//  Created by Yue Shen on 16/9/7.
//  Copyright © 2016年 Yue Shen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYLBullet.h"
@interface SYLBulletTrajectory : NSObject
@property (nonatomic,weak)   SYLBullet *bullet;
@property (nonatomic,assign) BulletPosition postion;
@property (nonatomic,assign) Boolean isReady;
@property (nonatomic,assign) CGFloat topY;
@property (nonatomic,strong) NSString *identifier;
@end
