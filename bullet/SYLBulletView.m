//
//  SYLBulletView.m
//  bullet
//
//  Created by Yue Shen on 16/9/7.
//  Copyright © 2016年 Yue Shen. All rights reserved.
//

#import "SYLBulletView.h"
#import "SYLBulletDispatcher.h"
@implementation SYLBulletView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [[SYLBulletDispatcher sharedInstance] setBulletView:self];//弹幕调度器初始化
        [self test];
    }
    return self;
}

/**
 *  接受弹幕数据,根据业务进行修改
 *
 */
- (void)receiveBullet:(NSAttributedString*)string andWithPositon:(BulletPosition)position {
    SYLBullet *bullet = [SYLBullet new];
    bullet.positon = position;
    bullet.attributedText = string;
    [[SYLBulletDispatcher sharedInstance] addBullet:bullet];
}

/**
 *  测试方法
 */
- (void)test {
   
    for (int i = 0; i<100; i++) {
        SYLBullet *bullet = [SYLBullet new];
        bullet.positon = topRightToLeft;
        int x = arc4random() % 10000;
        bullet.text = [NSString stringWithFormat:@"😊❤️💣%d",i];
        [[SYLBulletDispatcher sharedInstance] addBullet:bullet];
    }
    
    SYLBullet *bullet = [SYLBullet new];
    bullet.positon = bottomFixPosition;
    bullet.text = [NSString stringWithFormat:@"hello"];
    [[SYLBulletDispatcher sharedInstance] addBullet:bullet];
}

@end
