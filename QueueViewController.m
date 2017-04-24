//
//  QueueViewController.m
//  manyThread
//
//  Created by 鹏 刘 on 2017/4/23.
//  Copyright © 2017年 鹏 刘. All rights reserved.
//

#import "QueueViewController.h"

@interface QueueViewController ()
@property (nonatomic,strong) UIImageView *iv1;
@property (nonatomic,strong) UIImageView *iv2;
@property (nonatomic,strong) UIImageView *iv3;
@end

@implementation QueueViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
}

#define global_queue  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0)
#define main_queue    dispatch_get_main_queue()

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   /* dispatch_async(global_queue, ^{
        UIImage *image1 = [self imageWithUrl:@"http://d.hiphotos.baidu.com/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26/sign=2b9a12172df5e0fefa1581533d095fcd/cefc1e178a82b9019115de3d738da9773912ef00.jpg"];
        NSLog(@"图片1下载完成:%@",[NSThread currentThread]);
        
        UIImage *image2 = [self imageWithUrl:@"http://h.hiphotos.baidu.com/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26/sign=f47fd63ca41ea8d39e2f7c56f6635b2b/1e30e924b899a9018b8d3ab11f950a7b0308f5f9.jpg"];
        NSLog(@"图片2下载完成:%@",[NSThread currentThread]);
        
        dispatch_async(main_queue, ^{
            NSLog(@"显示图片---%@",[NSThread currentThread]);
            self.iv1.image = image1;
            self.iv2.image = image2;
            
            UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 100), NO, 0.0);
            [image1 drawInRect:CGRectMake(0, 0, 100, 100)];
            [image2 drawInRect:CGRectMake(100, 0, 100, 100)];
            self.iv3.image = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
            NSLog(@"图片合并完成---%@",[NSThread currentThread]);
            
        });
    });
    */

    dispatch_group_t group = dispatch_group_create();
    
    __block UIImage *image1 = nil;
    dispatch_group_async(group, global_queue, ^{
        image1 = [self imageWithUrl:@"http://d.hiphotos.baidu.com/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26/sign=2b9a12172df5e0fefa1581533d095fcd/cefc1e178a82b9019115de3d738da9773912ef00.jpg"];
        NSLog(@"图片1下载完成---%@",[NSThread currentThread]);
    });

    __block UIImage *image2 = nil;
    dispatch_group_async(group, global_queue, ^{
        image2 = [self imageWithUrl:@"http://h.hiphotos.baidu.com/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26/sign=f47fd63ca41ea8d39e2f7c56f6635b2b/1e30e924b899a9018b8d3ab11f950a7b0308f5f9.jpg"];
        NSLog(@"图片2下载完成---%@",[NSThread currentThread]);
    });
    //同时下载图片1和图片2;

    //等group中的人物都执行完毕，再回到主线程执行其它操作
    dispatch_group_notify(group, main_queue, ^{
        NSLog(@"显示图片---%@",[NSThread currentThread]);
        self.iv1.image = image1;
        self.iv2.image = image2;
    
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 100), NO, 0.0);
        [image1 drawInRect:CGRectMake(0, 0, 100, 100)];
        [image2 drawInRect:CGRectMake(100, 0, 100, 100)];
        self.iv3.image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        NSLog(@"图片合并完成---%@",[NSThread currentThread]);
    
    });

}


- (UIImage *)imageWithUrl:(NSString *)urlStr
{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:imageData];
 
    return image;
}
@end
