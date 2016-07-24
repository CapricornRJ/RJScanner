//
//  RJScanViewController.m
//  RJScanner
//
//  Created by renjie on 16/7/24.
//  Copyright © 2016年 CapricornRJ. All rights reserved.
//

#import "RJScanViewController.h"
#import "RJScanWrapper.h"
#import "RJScanNative.h"
#import "RJScanResult.h"

#define  RJScreen_Height [UIScreen mainScreen].bounds.size.height
#define  RJScreen_Width [UIScreen mainScreen].bounds.size.width

@interface RJScanViewController () <UIAlertViewDelegate>

/**
 *  扫码功能封装对象
 */
@property (nonatomic,strong) RJScanNative* scanObj;

@property (nonatomic, strong) UIImageView *topGlassImageView;
@property (nonatomic, strong) UIImageView *middleGlassImageView;
@property (nonatomic, strong) UIImageView *bottomGlassImageView;
@property (nonatomic, strong) UILabel     *alertLabel;

@end

@implementation RJScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSubviews];
    [self addUIConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self startScan];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    [self.scanObj stopScan];
}

- (void)setSubviews {
    [self.view addSubview:self.topGlassImageView];
    [self.view addSubview:self.middleGlassImageView];
    [self.view addSubview:self.bottomGlassImageView];
    [self.view addSubview:self.alertLabel];
}

- (void)addUIConstraints {
    self.topGlassImageView.frame = CGRectMake(0, 0, RJScreen_Width, (RJScreen_Height - RJScreen_Width + 40) / 2.0);
    self.middleGlassImageView.frame = CGRectMake(0, CGRectGetMaxY(self.topGlassImageView.frame), RJScreen_Width, RJScreen_Width - 40);
    self.bottomGlassImageView.frame = CGRectMake(0, CGRectGetMaxY(self.middleGlassImageView.frame), RJScreen_Width, (RJScreen_Height - RJScreen_Width + 40) / 2.0);
    self.alertLabel.frame = CGRectMake(20, 0, RJScreen_Width - 40, CGRectGetHeight(self.topGlassImageView.frame) - 30);
}

//启动设备
- (void)startScan {
    if (![RJScanWrapper isGetCameraPermission]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请到设置隐私中开启本程序相机权限" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
        [alertView show];
        return;
    }
    
    if (!_scanObj) {
        __weak typeof(self) weakSelf = self;
        _scanObj = [[RJScanNative alloc] initWithPreView:self.view success:^(NSArray<RJScanResult *> *array) {
            [weakSelf scanResultWithArray:array];
        }];
    }
    
    [self.scanObj startScan];
}

- (void)scanResultWithArray:(NSArray<RJScanResult*>*)array {
    if (array.count > 0) {
        RJScanResult *result = [array firstObject];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:result.strScanned delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
    }
}


#pragma mark - UIAlertViewDelegate


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self startScan];
    }
}


#pragma mark - getters


- (UIImageView *)topGlassImageView {
    if (!_topGlassImageView) {
        _topGlassImageView = [UIImageView new];
        UIImage *oldImage = [UIImage imageNamed:@"RJScan_glassView_top"];
        UIImage *newImageView = [oldImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 100, 44, 100)];
        _topGlassImageView.image = newImageView;
        _topGlassImageView.alpha = 0.5;
    }
    
    return _topGlassImageView;
}

- (UIImageView *)middleGlassImageView {
    if (!_middleGlassImageView) {
        _middleGlassImageView = [UIImageView new];
        UIImage *oldImage = [UIImage imageNamed:@"RJScan_glassView_middle"];
        UIImage *newImageView = [oldImage resizableImageWithCapInsets:UIEdgeInsetsMake(1, 100, 1, 100)];
        _middleGlassImageView.image = newImageView;
        _middleGlassImageView.alpha = 0.5;
    }
    
    return _middleGlassImageView;
}

- (UIImageView *)bottomGlassImageView {
    if (!_bottomGlassImageView) {
        _bottomGlassImageView = [UIImageView new];
        UIImage *oldImage = [UIImage imageNamed:@"RJScan_glassView_bottom"];
        UIImage *newImageView = [oldImage resizableImageWithCapInsets:UIEdgeInsetsMake(44, 100, 0, 100)];
        _bottomGlassImageView.image = newImageView;
        _bottomGlassImageView.alpha = 0.5;
    }
    
    return _bottomGlassImageView;
}

- (UILabel *)alertLabel {
    if (!_alertLabel) {
        _alertLabel = [UILabel new];
        _alertLabel.textColor = [UIColor blackColor];
        _alertLabel.numberOfLines = 0;
        _alertLabel.text = self.alertTitle;
        _alertLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _alertLabel;
}

@end
