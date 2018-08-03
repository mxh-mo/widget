//
//  MMDataShareManager.h
//  widgetDemo
//
//  Created by 莫晓卉 on 2018/8/2.
//  Copyright © 2018年 莫晓卉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMDataShareManager : NSObject

+ (MMDataShareManager *)shareInstance;

- (void)saveString:(NSString *)string;
- (NSString *)string;

- (void)saveStringToFileStr:(NSString *)string;
- (NSString *)getStringFromFile;

@end
