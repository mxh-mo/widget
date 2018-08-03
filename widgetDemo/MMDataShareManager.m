//
//  MMDataShareManager.m
//  widgetDemo
//
//  Created by 莫晓卉 on 2018/8/2.
//  Copyright © 2018年 莫晓卉. All rights reserved.
//

#import "MMDataShareManager.h"

static NSString *kGroupName = @"group.momo.widget";
static NSString *kStringKey = @"group.momo.widget.string";

@implementation MMDataShareManager {
  NSUserDefaults *_userDefaults;
  NSURL *_containerURL;
}

+ (MMDataShareManager *)shareInstance {
  static MMDataShareManager *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[MMDataShareManager alloc] init];
  });
  return instance;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _userDefaults = [[NSUserDefaults alloc] initWithSuiteName:kGroupName];
    _containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:kGroupName];
    _containerURL = [_containerURL URLByAppendingPathComponent:@"Library/Caches/widget"];
  }
  return self;
}

- (void)saveString:(NSString *)string {
  [_userDefaults setObject:string forKey:kStringKey];
  [_userDefaults synchronize];
}

- (NSString *)string {
  return [_userDefaults objectForKey:kStringKey];
}

- (void)saveStringToFileStr:(NSString *)string {
  NSError *error = nil;
  BOOL result = [string writeToURL:_containerURL atomically:YES encoding:NSUTF8StringEncoding error:&error];
  if (result) {
    NSLog(@"写入成功");
  } else {
    NSLog(@"写入失败 %@", error.description);
  }
}

- (NSString *)getStringFromFile {
  NSError *error = nil;
  NSString *string = [NSString stringWithContentsOfURL:_containerURL encoding:NSUTF8StringEncoding error:&error];
  if (error) {
    NSLog(@"读取失败 %@", error.description);
  } else {
    NSLog(@"读取成功");
  }
  return string;
}

@end
