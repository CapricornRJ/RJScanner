//
//  RJScanResult.m
//  RJScanner
//
//  Created by renjie on 16/7/24.
//  Copyright © 2016年 CapricornRJ. All rights reserved.
//

#import "RJScanResult.h"

@implementation RJScanResult

- (instancetype)initWithScanString:(NSString*)str imgScan:(UIImage*)img barCodeType:(NSString*)type
{
    if (self = [super init]) {
        
        self.strScanned = str;
        self.imgScanned = img;
        self.strBarCodeType = type;
    }
    
    return self;
}

@end
