//
//  AfterDelayViewController.m
//  manyThread
//
//  Created by 鹏 刘 on 2017/4/23.
//  Copyright © 2017年 鹏 刘. All rights reserved.
//

#import "AfterDelayViewController.h"

@interface AfterDelayViewController ()

@end


@implementation AfterDelayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //NSLog(@"打印当前线程:%@",[NSThread currentThread]);
    //[self performSelector:@selector(run) withObject:nil afterDelay:3.0];
    
    NSLog(@"打印当前线程:%@",[NSThread currentThread]);
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), queue, ^{
        NSLog(@"线程延迟执行---%@",[NSThread currentThread]);
    });

    dispatch_queue_t queue1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW,(int64_t)(5.0 * NSEC_PER_SEC));
    
    dispatch_after(when, queue1, ^{
        NSLog(@"并发队列-延迟执行------%@",[NSThread currentThread]);
    });
        
    
}

/*- (void)run
{
    NSLog(@"延迟至行---%@",[NSThread currentThread]);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    dispatch_queue_t queue = dispatch_queue_create("liusongsong", 0);
    
    dispatch_sync(queue, ^{
        [self performSelector:@selector(test) withObject:nil afterDelay:1.0];
    });
}

- (void)test
{
    NSLog(@"异步函数中延迟执行---%@",[NSThread currentThread]);
}
*/


@end
