//
//  RJScanWrapper.h
//  RJScanner
//
//  Created by renjie on 16/7/24.
//  Copyright © 2016年 CapricornRJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface RJScanWrapper : NSObject

#pragma mark -相机、相册权限

/**
 @brief  获取相机权限
 */
+ (BOOL)isGetCameraPermission;

@end
