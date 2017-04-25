//
//  DownLoadOperation.h
//  manyThread
//
//  Created by 鹏 刘 on 2017/4/24.
//  Copyright © 2017年 鹏 刘. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class DownLoadOperation;
@protocol DownLoadOperationDelegate <NSObject>

- (void)downLoadOperation:(DownLoadOperation *)operation didFinishedDownload:(UIImage *)image;
@end


@interface DownLoadOperation : NSOperation
@property (nonatomic,copy) NSString *url;
@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,weak) id <DownLoadOperationDelegate> delegate;
@end
