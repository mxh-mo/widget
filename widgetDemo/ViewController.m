//
//  ViewController.m
//  widgetDemo
//
//  Created by 莫晓卉 on 2018/8/2.
//  Copyright © 2018年 莫晓卉. All rights reserved.
//

#import "ViewController.h"
#import "MMDataShareManager.h"
#import "Masonry.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [[MMDataShareManager shareInstance] saveString:@"momo"];
  [[MMDataShareManager shareInstance] saveStringToFileStr:@"😄"];
}


@end
