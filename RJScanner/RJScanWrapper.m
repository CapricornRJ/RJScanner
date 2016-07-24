//
//  RJScanWrapper.m
//  RJScanner
//
//  Created by renjie on 16/7/24.
//  Copyright © 2016年 CapricornRJ. All rights reserved.
//

#import "RJScanWrapper.h"
#import <UIKit/UIKit.h>

@implementation RJScanWrapper

#pragma mark -相机、相册权限
+ (BOOL)isGetCameraPermission
{
    BOOL isCameraValid = YES;
    //ios7之前系统默认拥有权限
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        if (authStatus == AVAuthorizationStatusDenied)
        {
            isCameraValid = NO;
        }
    }
    return isCameraValid;
}

@end
