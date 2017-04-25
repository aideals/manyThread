//
//  AppData.h
//  manyThread
//
//  Created by 鹏 刘 on 2017/4/24.
//  Copyright © 2017年 鹏 刘. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppData : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *downLoad;

+ (instancetype)appModelWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
