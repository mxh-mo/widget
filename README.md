# widget

>1.打开App
```Objective-C
- (void)openApp {
  [self.extensionContext openURL:[NSURL URLWithString:@"wenwen://"] completionHandler:^(BOOL success) {
    NSLog(@"open url result: %d",success);
  }];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options {
  if ([url.scheme isEqualToString:@"wenwen"]) {
    return YES;
  }
}
```

>2. 展开/折叠
```Objective-C
- (void)viewDidLoad {
  [super viewDidLoad];
  // iOS10 later support
  self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
}

#pragma mark - 点击 展开/折叠
- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize {
  if (activeDisplayMode == NCWidgetDisplayModeCompact) {
    self.preferredContentSize = CGSizeMake(0, 110);
  } else {
    // 最多显示屏高
    self.preferredContentSize = CGSizeMake(0, 1000);
  }
}
```

>3.数据共享
因为`widget app`和`host app`是属于两个不同的app, 所以需要用 `App Groups` 来分享数据

>>(1).NSUserDefault
```Objective-C
NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.momo.widget"];
// 存
[userDefault setValue:@"momo" forKey:@"key"];
// 取
label.text = [NSString stringWithFormat:@"%@", [userDefauct valueForKey:@"key"]];
```

>>(2).NSFileManager
```Objective-C
  NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.momo.widget"];
  containerURL = [containerURL URLByAppendingPathComponent:@"Library/Caches/widget"];
  
  NSError *error = nil;
  // 写入
  BOOL result = [string writeToURL:containerURL atomically:YES encoding:NSUTF8StringEncoding error:&error];
  if (result) {
    NSLog(@"写入成功");
  } else {
    NSLog(@"写入失败 %@", error.description);
  }

    
  // 读取
  NSString *string = [NSString stringWithContentsOfURL:containerURL encoding:NSUTF8StringEncoding error:&error];
  if (error) {
    NSLog(@"读取失败 %@", error.description);
  } else {
    NSLog(@"读取成功");
  }
```
