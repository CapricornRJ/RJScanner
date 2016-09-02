//
//  ViewController.m
//  RJScanner
//
//  Created by renjie on 16/9/2.
//  Copyright © 2016年 CapricornRJ. All rights reserved.
//

#import "ViewController.h"
#import "RJScanViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"扫码";
    
    UIButton *pushButton = [UIButton buttonWithType:UIButtonTypeCustom];
    pushButton.frame = CGRectMake(20, 20, 100, 50);
    [pushButton setTitle:@"push" forState:UIControlStateNormal];
    [pushButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [pushButton addTarget:self action:@selector(pushAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton];
}

- (void)pushAction:(UIButton *)button {
    RJScanViewController *scanViewController = [[RJScanViewController alloc] init];
    scanViewController.alertTitle = @"在电脑浏览器打开\nwww.baidu.com\n并扫描页面中的二维码";
    [self.navigationController pushViewController:scanViewController animated:YES];
}


@end
