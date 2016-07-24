//
//  RJScanResult.h
//  RJScanner
//
//  Created by renjie on 16/7/24.
//  Copyright © 2016年 CapricornRJ. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RJScanResult : NSObject

- (instancetype)initWithScanString:(NSString*)str imgScan:(UIImage*)img barCodeType:(NSString*)type;

/**
 *  扫码字符串
 */
@property (nonatomic, copy) NSString* strScanned;
/**
 *  扫码图像
 */
@property (nonatomic, strong) UIImage* imgScanned;
/**
 *  扫码码的类型
 */
@property (nonatomic, copy) NSString* strBarCodeType;

@end
