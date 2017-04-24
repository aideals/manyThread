//
//  onceViewController.m
//  manyThread
//
//  Created by 鹏 刘 on 2017/4/23.
//  Copyright © 2017年 鹏 刘. All rights reserved.
//

#import "onceViewController.h"

@interface onceViewController ()
@property (nonatomic,assign) BOOL log;
@end

@implementation onceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //if (self.log == NO) {
      //  NSLog(@"该代码只执行一次");
        //self.log == YES;
    //}

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"该代码只执行一次");
    });

}
@end
