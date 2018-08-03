//
//  TodayViewController.m
//  MMWidget
//
//  Created by 莫晓卉 on 2018/8/2.
//  Copyright © 2018年 莫晓卉. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "MMDataShareManager.h"
#import "Masonry.h"

@interface TodayViewController () <NCWidgetProviding>
@end

@implementation TodayViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // iOS10 later support
  if ([UIDevice currentDevice].systemVersion.doubleValue >= 10.0) {
    self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
    self.preferredContentSize = CGSizeMake(0, 110);
  }
  
  // sare data
  MMDataShareManager *userDefauct = [MMDataShareManager shareInstance];
  
  UILabel *label = [[UILabel alloc] init];
  label.textColor = [UIColor blackColor];
  label.userInteractionEnabled = YES;
  label.text = [NSString stringWithFormat:@"%@ %@", [userDefauct string], [userDefauct getStringFromFile]];
  [self.view addSubview:label];
  [label mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.top.mas_offset(16);
    make.height.mas_equalTo(44);
    make.width.mas_equalTo(80);
  }];
  
  UIButton *openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  [openBtn setTitle:@"open" forState:UIControlStateNormal];
  [openBtn addTarget:self action:@selector(clickLabel) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:openBtn];
  [openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(label.mas_right).offset(8);
    make.height.mas_equalTo(44);
    make.width.mas_equalTo(80);
  }];

}

- (void)clickLabel {
  [self.extensionContext openURL:[NSURL URLWithString:@"widget://"] completionHandler:^(BOOL success) {
    NSLog(@"open url result: %d",success);
  }];
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

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
  completionHandler(NCUpdateResultNewData);
}

@end
