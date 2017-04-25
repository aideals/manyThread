//
//  DownLoadOperation.m
//  manyThread
//
//  Created by 鹏 刘 on 2017/4/24.
//  Copyright © 2017年 鹏 刘. All rights reserved.
//

#import "DownLoadOperation.h"

@implementation DownLoadOperation

- (void)main
{
    NSURL *url = [NSURL URLWithString:self.url];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];

    NSLog(@"当前线程007:%@",[NSThread currentThread]);
   
    if ([self.delegate respondsToSelector:@selector(downLoadOperation:didFinishedDownload:)]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate downLoadOperation:self didFinishedDownload:image];
        });
    }
}


@end
