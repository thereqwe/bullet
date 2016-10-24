//
//  SYBulletDispatcher.m
//  bullet 调度器控制弹幕在幕墙上的显示~在此完成弹幕的操作逻辑
//
//  Created by Yue Shen on 16/9/7.
//  Copyright © 2016年 Yue Shen. All rights reserved.
//

#import "SYLBulletDispatcher.h"


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kBulletHeight 20
#define kBulletDuration  (arc4random() % 4 + 6)

@interface SYLBulletDispatcher()
@property (nonatomic,strong) NSMutableArray<SYLBullet*> *bulletPoolArray; //弹幕池
@property (nonatomic,strong) SYLBulletView *bulletView; //显示弹幕的view
@property (nonatomic,strong) NSMutableArray<SYLBulletTrajectory*> *bulletTrajectoryArray; //弹道
@end

@implementation SYLBulletDispatcher
{
    NSTimer *scanBulletTimer;
}
static id __singleton__ = nil;
+ (instancetype)sharedInstance
{
    if(__singleton__==nil){
        __singleton__ = [[self alloc]init];
    }
    return __singleton__;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isRunning = YES;
        [self start];
    }
    return self;
}

- (void)setBulletView:(SYLBulletView *)bulletView {
    _bulletView = bulletView;
    [self setupBulletTrajectory];
}


//新增弹幕
- (void)addBullet:(SYLBullet*)bullet {
    if(_bulletPoolArray==nil){
        _bulletPoolArray = [NSMutableArray new];
    }
    [_bulletPoolArray addObject:bullet];
}

//扫描弹幕池并发射由nstimer重复执行
- (void)scanBulletPool{
    if(_isRunning==NO){
        return;
    }
    if([_bulletPoolArray firstObject]==nil){
        return;
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^(){
        SYLBullet *bullet = [_bulletPoolArray firstObject];
        for (SYLBulletTrajectory *bulletTrajectory in _bulletTrajectoryArray) {
            if(bulletTrajectory.isReady == YES&&bulletTrajectory.postion==bullet.positon) {
                bulletTrajectory.isReady = NO;
                NSLog(@"%@ is in use",bulletTrajectory.identifier);
                [_bulletPoolArray removeObjectAtIndex:0];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self shootBullet:bullet andWithBulletTrajectory:bulletTrajectory];
                });
                break;
            }
        }
    });
}

//发射弹幕
- (void)shootBullet:(SYLBullet*)bullet  andWithBulletTrajectory:(SYLBulletTrajectory*)bulletTrajectory{
    bulletTrajectory.bullet = bullet;
    bullet.animationFinishedBlock = ^{
        bulletTrajectory.isReady = YES;
        NSLog(@"%@ is ready",bulletTrajectory.identifier);
    };
    [_bulletView addSubview:bullet];
    [bullet createTime];
    switch (bullet.positon) {
        case topRightToLeft:{
            NSLog(@"bullet buration %d",kBulletDuration);
            bullet.frame = (CGRect){kScreenWidth,bulletTrajectory.topY,bullet.frame.size.width,bullet.frame.size.height};
            [UIView animateWithDuration:(kBulletDuration) animations:^{
                bullet.frame = (CGRect){0-100,bulletTrajectory.topY,bullet.frame.size.width,bullet.frame.size.height};
            } completion:^(BOOL finished) {
                [bullet removeFromSuperview];
            }];
            break;
        }
        case bottomFixPosition:{
            bullet.frame = (CGRect){0,bulletTrajectory.topY,bullet.frame.size.width,bullet.frame.size.height};
            bullet.center = CGPointMake(_bulletView.center.x, bullet.center.y);
            [UIView animateWithDuration:kBulletDuration animations:^{
                bullet.alpha = 0;
            } completion:^(BOOL finished) {
                [bullet removeFromSuperview];
            }];
            break;
        }
        default:
            break;
    }
}


//准备弹道(根据显示弹幕的view决定生成弹道)
-(void)setupBulletTrajectory {
    if(_bulletView==nil){
        NSLog(@"no view");
        return;
    }
    int trajectoryNum = ceil(_bulletView.frame.size.height/kBulletHeight);
    //trajectoryNum = 1;
    _bulletTrajectoryArray = [NSMutableArray new];
    //顶部弹道
    for(int i=0;i<trajectoryNum;i++){
        if (kBulletHeight*i>kScreenHeight*0.7) {
            break;
        }
        SYLBulletTrajectory *bulletTrajectory=[SYLBulletTrajectory new];
        bulletTrajectory.topY = i*kBulletHeight;
        bulletTrajectory.postion = topRightToLeft;
        bulletTrajectory.identifier = [NSString stringWithFormat:@"top_%d",i];
        [_bulletTrajectoryArray addObject:bulletTrajectory];
    }
    //底部弹道 3个位置
    for(int i=0;i<3;i++){
        SYLBulletTrajectory *bulletTrajectory=[SYLBulletTrajectory new];
        bulletTrajectory.topY = kScreenHeight - (3-i)* kBulletHeight;
        bulletTrajectory.postion = bottomFixPosition;
        bulletTrajectory.identifier = [NSString stringWithFormat:@"bottom_%d",i];
        [_bulletTrajectoryArray addObject:bulletTrajectory];
    }
}

- (void)stop {
    if(scanBulletTimer!=nil){
        [scanBulletTimer invalidate];
        scanBulletTimer = nil;
    }
}

- (void)start {
    scanBulletTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(scanBulletPool) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:scanBulletTimer forMode:NSRunLoopCommonModes];
}
@end
