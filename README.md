# 弹幕快速
IOS快速弹幕开发一点通
弹幕文字看了不少,在此写一篇简单易懂的弹幕开发介绍

构思:
在一个view上有规律地将uilabel 显示出来,那么关键就是uilabel被如何控制出场,我构思了一个调度类SYLBulletDispatcher 来组织显示.

第一步,根据view的尺寸来生成弹道SYLBulletTrajectory ,我生成两种弹道(从右往左和下方固定位)

第二步,将接收到的弹幕放入弹幕池,等待有空闲的弹道来接收他.SYLBulletDispatcher会不停循环检查

第三步,弹幕移动时,发现其完全显示后就将其所属弹道设置为空闲

这样弹幕就能不停地出现移动了.

实现:
类

1 弹幕类:决定弹幕的显示样式与内容

2 弹道类:决定弹幕的显示轨道(从右向左或者在底部显示)

3 显示视图: 弹幕显示视图.

4 调度类:生成弹道,并且在弹幕来时将弹幕有序地放入弹道.

使用:
引入  
 SYLBulletView.h
 初始化
 SYLBulletView*bulletView = [[SYLBulletView alloc]initWithFrame:self.view.bounds];
 [self.viewaddSubview:bulletView];
 使用此方法放入弹幕数据即可
 - (void)receiveBullet:(NSAttributedString*)string andWithPositon:(BulletPosition)position 
