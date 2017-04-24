//
//  OperatoinViewController.m
//  manyThread
//
//  Created by 鹏 刘 on 2017/4/23.
//  Copyright © 2017年 鹏 刘. All rights reserved.
//

#import "OperationViewController.h"

@interface OperationViewController ()

@end

@implementation OperationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   // NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(test) object:nil];
    
   // [operation start];

   //NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
     //  NSLog(@"当前线程---%@",[NSThread currentThread]);
   //}];

   //[operation addExecutionBlock:^{
     //  NSLog(@"NSBlockOperation1---%@",[NSThread currentThread]);
   //}];
    
   //[operation addExecutionBlock:^{
     //  NSLog(@"NSBlockOperation2---%@",[NSThread currentThread]);
   //}];
    
    //[operation start];

   // NSInvocationOperation *operation1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(test1) object:nil];
   // NSInvocationOperation *operation2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(test2) object:nil];
    
   // NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
     //   NSLog(@"当前线程1:%@",[NSThread currentThread]);
   // }];

  // [operation3 addExecutionBlock:^{
    //   NSLog(@"当前线程2:%@",[NSThread currentThread]);
   //}];

   // [operation3 addDependency:operation1];
   // [operation1 addDependency:operation2];
    
    
   // NSOperationQueue *queue = [[NSOperationQueue alloc] init];
   // [queue addOperation:operation1];
   // [queue addOperation:operation2];
   // [queue addOperation:operation3];

   NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
       NSLog(@"下载图片---%@",[NSThread currentThread]);
   }];

   operation.completionBlock = ^{
       NSLog(@"下载第二张图片---%@",[NSThread currentThread]);
   };

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];

}

/*- (void)test
{
    NSLog(@"当前线程---%@",[NSThread currentThread]);
}
*/

/*- (void)test1
{
    NSLog(@"当前线程3:%@",[NSThread currentThread]);
}

- (void)test2
{
    NSLog(@"当前线程4:%@",[NSThread currentThread]);
}
*/
@end
