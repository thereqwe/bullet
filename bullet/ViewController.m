//
//  ViewController.m
//  bullet
//
//  Created by Yue Shen on 16/9/7.
//  Copyright © 2016年 Yue Shen. All rights reserved.
//

#import "ViewController.h"
#import "SYLBulletView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    SYLBulletView *bulletView = [[SYLBulletView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:bulletView];
    NSLog(@"123");
    
//    UILabel *label = [UILabel new];
//    label.attributedText = [[NSAttributedString alloc]initWithString:@"123😁2323" attributes:nil];
//    label.frame = CGRectMake(0, 50, 100, 20);
//    [label sizeToFit];
//    label.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:label];
//    NSLog(@"--->%f",label.frame.size.width);
    
    [UIControl new];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
