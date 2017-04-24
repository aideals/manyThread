//
//  GCDViewController.m
//  manyThread
//
//  Created by 鹏 刘 on 2017/4/22.
//  Copyright © 2017年 鹏 刘. All rights reserved.
//

#import "GCDViewController.h"

@interface GCDViewController ()

@end

@implementation GCDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //往全局并发队列中添加异步任务
    //会同时开启三个子线程
   /* dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        NSLog(@"下载图片1---%@",[NSThread currentThread]);
    });

    dispatch_async(queue, ^{
        NSLog(@"下载图片2---%@",[NSThread currentThread]);
    });

    dispatch_async(queue, ^{
        NSLog(@"下载图片3---%@",[NSThread currentThread]);
    });
 
    NSLog(@"current thread:%@",[NSThread mainThread]);
    */
    
    
    //往全局串行队列中添加异步任务
    //会开启线程，但是只开启一个线程
    
    /* dispatch_queue_t queue = dispatch_queue_create("liu song song", NULL);
    
    dispatch_async(queue, ^{
        NSLog(@"下载图片1---%@",[NSThread currentThread]);
    });

    dispatch_async(queue, ^{
        NSLog(@"下载图片2---%@",[NSThread currentThread]);
    });

    dispatch_async(queue, ^{
        NSLog(@"下载图片3---%@",[NSThread currentThread]);
    });

    NSLog(@"main thread:%@",[NSThread mainThread]);
    */
     
    
    //往全局并发队列中添加同步任务
    //不会开启线程，并发队列失去了并发的功能
    
   /* dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_sync(queue, ^{
        NSLog(@"下载图片1---%@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"下载图片2---%@",[NSThread currentThread]);
    });

    dispatch_sync(queue, ^{
        NSLog(@"下载图片3---%@",[NSThread currentThread]);
    });

    NSLog(@"main thread:%@",[NSThread mainThread]);
    */
    
    
    //往全局串行队列中添加同步函数
    //不会开启新线程
    
    dispatch_queue_t queue = dispatch_queue_create("liu song song", NULL);
    
    dispatch_sync(queue, ^{
        NSLog(@"下载图片1---%@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"下载图片2---%@",[NSThread currentThread]);
    });

    dispatch_sync(queue, ^{
        NSLog(@"下载图片---%@",[NSThread currentThread]);
    });

    NSLog(@"main thread:%@",[NSThread mainThread]);
}




@end
