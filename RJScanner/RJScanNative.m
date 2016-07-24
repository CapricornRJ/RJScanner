//
//  RJScanNative.m
//  RJScanner
//
//  Created by renjie on 16/7/24.
//  Copyright © 2016年 CapricornRJ. All rights reserved.
//

#import "RJScanNative.h"
#import "RJScanResult.h"
#import <AVFoundation/AVFoundation.h>


#define  RJScreen_Height [UIScreen mainScreen].bounds.size.height
#define  RJScreen_Width [UIScreen mainScreen].bounds.size.width

@interface RJScanNative () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic) BOOL bNeedScanResult;
@property(nonatomic) BOOL isNeedCaputureImage;

@property (assign,nonatomic) AVCaptureDevice * device;
@property (strong,nonatomic) AVCaptureDeviceInput * input;
@property (strong,nonatomic) AVCaptureMetadataOutput * output;
@property (strong,nonatomic) AVCaptureSession * session;
@property (strong,nonatomic) AVCaptureVideoPreviewLayer * preview;

//扫码结果
@property (nonatomic, strong) NSMutableArray<RJScanResult*> *arrayResult;
//视频预览显示视图
@property (nonatomic,weak) UIView *videoPreView;
//扫码结果返回
@property(nonatomic,copy)void (^blockScanResult)(NSArray<RJScanResult*> *array);

@end

@implementation RJScanNative

- (id)initWithPreView:(UIView*)preView success:(void(^)(NSArray<RJScanResult*> *array))block {
    if (self = [super init]) {
        [self initParaWithPreView:preView success:block];
    }
    
    return self;
}

- (void)initParaWithPreView:(UIView*)videoPreView success:(void(^)(NSArray<RJScanResult*> *array))block {
    self.videoPreView = videoPreView;
    self.blockScanResult = block;
    
    self.bNeedScanResult = YES;
    
    NSError *error;
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:&error];
    
    if (!self.input) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message: [error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
        [alertView show];
        return;
    }
    
    [self.session addInput:self.input];
    [self.session addOutput:self.output];
    // 扫码类型
    self.output.metadataObjectTypes = [self defaultMetaDataObjectTypes];
    
    [videoPreView.layer insertSublayer:self.preview atIndex:0];
    
    //先进行判断是否支持控制对焦,不开启自动对焦功能，很难识别二维码。
    if (self.device.isFocusPointOfInterestSupported &&[_device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
        [self.input.device lockForConfiguration:nil];
        [self.input.device setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
        [self.input.device unlockForConfiguration];
    }
}


#pragma mark - AVCaptureMetadataOutputObjectsDelegate


- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (!self.bNeedScanResult) {
        return;
    }
    
    [self.arrayResult removeAllObjects];
    
    //识别扫码类型
    for(AVMetadataObject *current in metadataObjects)
    {
        if ([current isKindOfClass:[AVMetadataMachineReadableCodeObject class]] )
        {
            self.bNeedScanResult = NO;
            
            NSString *scannedResult = [(AVMetadataMachineReadableCodeObject *) current stringValue];
            
            RJScanResult *result = [RJScanResult new];
            result.strScanned = scannedResult;
            result.strBarCodeType = current.type;
            
            [self.arrayResult addObject:result];
        }
    }
    
    [self stopScan];
    
    if (_blockScanResult) {
        _blockScanResult(_arrayResult);
    }
}


#pragma mark - private methods


- (void)startScan
{
    if ( self.input && !self.session.isRunning )
    {
        [self.session startRunning];
        self.bNeedScanResult = YES;
        
        [self.videoPreView.layer insertSublayer:self.preview atIndex:0];
    }
}

- (void)stopScan
{
    if ( self.input && self.session.isRunning )
    {
        self.bNeedScanResult = NO;
        [self.session stopRunning];
    }
}


- (NSArray *)defaultMetaDataObjectTypes
{
    NSMutableArray *types = [@[AVMetadataObjectTypeQRCode,
                               AVMetadataObjectTypeEAN13Code,
                               AVMetadataObjectTypeEAN8Code,
                               AVMetadataObjectTypeCode93Code,
                               AVMetadataObjectTypeCode128Code,
                               ] mutableCopy];
    
    return types;
}


#pragma mark - getters


- (AVCaptureDevice *)device {
    if (!_device) {
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    
    return _device;
}

- (AVCaptureMetadataOutput *)output {
    if (!_output) {
        _output = [[AVCaptureMetadataOutput alloc]init];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        //设置扫描范围
        [_output setRectOfInterest:CGRectMake((RJScreen_Height - RJScreen_Width) / 2. /RJScreen_Height, 20 / RJScreen_Width, RJScreen_Width - 40 / RJScreen_Height, RJScreen_Width - 40 / RJScreen_Width)];
    }
    
    return _output;
}

- (AVCaptureSession *)session {
    if (!_session) {
        _session = [[AVCaptureSession alloc]init];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
    }
    
    return _session;
}

- (AVCaptureVideoPreviewLayer *)preview {
    if (!_preview) {
        _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
        _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _preview.frame = self.videoPreView.frame;
    }
    
    return _preview;
}

- (NSMutableArray *)arrayResult {
    if (!_arrayResult) {
        _arrayResult = [NSMutableArray arrayWithCapacity:1];
    }
    
    return _arrayResult;
}

@end
