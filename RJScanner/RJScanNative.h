//
//  RJScanNative.h
//  RJScanner
//
//  Created by renjie on 16/7/24.
//  Copyright © 2016年 CapricornRJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RJScanResult;

/**
 iOS系统的扫码功能
 
 - returns: RJScanNatived的实例
 */
@interface RJScanNative : NSObject

/**
*  初始化扫描仪
*
*  @param preView 视频显示区域
*  @param block   扫描结果
*
*  @return RJScanResult的实例
*/
- (id)initWithPreView:(UIView*)preView success:(void(^)(NSArray<RJScanResult*> *array))block;

/**
 *  开始扫码
 */
- (void)startScan;

/**
 *  停止扫码
 */
- (void)stopScan;

@end
