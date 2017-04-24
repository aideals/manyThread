//
//  ViewController.m
//  manyThread
//
//  Created by 鹏 刘 on 2017/4/22.
//  Copyright © 2017年 鹏 刘. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) UIButton *test;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self button];
    //[self creatThread];
   //[self creatThread2];
    [self creatThread3];
}

- (void)button
{
    self.test = [[UIButton alloc] initWithFrame:CGRectMake(55, 250, 120, 90)];
    self.test.backgroundColor = [UIColor blueColor];
    [self.test setTitle:@"Press" forState:UIControlStateNormal];
    [self.test setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.test addTarget:self action:@selector(press:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.test];
}

- (IBAction)press:(UIButton *)sender
{
   // NSThread *current = [NSThread currentThread];
    
   // for (int i = 0; i <= 100; i ++) {
      //  NSLog(@"btnClick---%d---%@",i,current);
   // }
   // -----堵塞线程-----
    
    NSThread *current = [NSThread currentThread];
    NSLog(@"btnClick ---%@",current);

    NSThread *main = [NSThread mainThread];
    NSLog(@"主线程 ---%@",main);
    
    [self creatThread];
}

/**
 NSThread创建线程方式1
 1。先创建初始化线程
 2.start开启线程
*/

- (void)creatThread
{
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run:) object:@"线程A"];
    thread.name = @"线程A";
    [thread start];
    
    NSThread *thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(run:) object:@"线程B"];
    thread.name = @"线程B";
    [thread2 start];
    
}

/*
 NSThread创建线程方式2
 创建完线程自动启动
*/

- (void)creatThread2
{
    [NSThread detachNewThreadSelector:@selector(run:) toTarget:self withObject:@"创建完线程自动启动"];
}

/*
 NSThread创建线程方式3
 隐式创建线程并自动启动
*/

- (void)creatThread3
{
    [self performSelector:@selector (run:) withObject:@"隐式创建"];
    
}

- (void)run:(NSString *)str
{
    NSThread *current = [NSThread currentThread];
    
    for (int i = 0; i <= 10; i++) {
        NSLog(@"run---%@---%@",current,str);
    }
}
@end
