//
//  SYLBulletTrajectory.m
//  bullet
//
//  Created by Yue Shen on 16/9/7.
//  Copyright © 2016年 Yue Shen. All rights reserved.
//

#import "SYLBulletTrajectory.h"

@implementation SYLBulletTrajectory
- (instancetype)init
{
    self = [super init];
    if (self) {
        _isReady = YES;
        _topY = 0;
        _postion = topRightToLeft;
    }
    return self;
}
@end
