//
//  SYLBulletText.m
//  bullet
//
//  Created by Yue Shen on 16/9/7.
//  Copyright © 2016年 Yue Shen. All rights reserved.
//

#import "SYLBullet.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
@implementation SYLBullet
{
    NSTimer* timer;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor brownColor];
    }
    return self;
}

- (void)createTime{
     timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(jianCe) userInfo:nil repeats:YES];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self sizeToFit];//设置尺寸
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self sizeToFit];//设置尺寸
}

- (void) jianCe{
    CGRect rect = [[self.layer presentationLayer ]frame];  // view指你的动画中移动的view
  //  NSLog(@"箭 %f",rect.origin.x);
    if((kScreenWidth-rect.origin.x)>=self.frame.size.width){
      //  NSLog(@"启动 %f---%f",(kScreenWidth-rect.origin.x),self.frame.size.width);
        [timer invalidate];
        timer = nil;
        if(_animationFinishedBlock!=nil){
            _animationFinishedBlock();
        }else{
            NSLog(@"shit");
        }
    }
}

- (void)dealloc
{
    NSLog(@"dealloc %@",self.text);
}
@end
