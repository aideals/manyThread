//
//  ViewController.m
//  manyThread
//
//  Created by 鹏 刘 on 2017/4/22.
//  Copyright © 2017年 鹏 刘. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,assign) int leftTicketsCount;
@property (nonatomic,strong) NSThread *thread1;
@property (nonatomic,strong) NSThread *thread2;
@property (nonatomic,strong) NSThread *thread3;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.leftTicketsCount = 10;
    
    self.thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(sellTickets) object:nil];
    self.thread1.name = @"售票员A";
    
    self.thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(sellTickets) object:nil];
    self.thread2.name = @"售票员B";
    
    self.thread3 = [[NSThread alloc] initWithTarget:self selector:@selector(sellTickets) object:nil];
    self.thread3.name = @"售票员C";

    [self threadBegin];
}

- (void)sellTickets
{
    while (1) {
        @synchronized (self) {
            int count = self.leftTicketsCount;
            
            if (count > 0) {
                [NSThread sleepForTimeInterval:0.002];
                
                self.leftTicketsCount = count - 1;
                
                NSThread *current = [NSThread currentThread];
                NSLog(@"\n %@--卖了一张票，还剩余%d张票--",current,self.leftTicketsCount);
            } else {
                [NSThread exit];
            }
            
        }

    }
}

- (void)threadBegin
{
    [self.thread1 start];
    [self.thread2 start];
    [self.thread3 start];
}

@end
