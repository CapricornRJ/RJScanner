# RJScanner
二维码扫描
==================
使用方法
------------------
###1.手动导入一下文件到项目中
```objc
RJScanViewController.h     RJScanViewController.m
RJScanNative.h             RJScanNative.m
RJScanResult.h             RJScanResult.m
RJScanWrapper.h            RJScanWrapper.m
RJScanner.bundle
```
###2.三行代码创建扫描控制器
```objc
  RJScanViewController *scanViewController = [[RJScanViewController alloc] init];
  scanViewController.alertTitle = @"在电脑浏览器打开\n......\n并扫描页面中的二维码";
  [self.navigationController pushViewController:scanViewController animated:YES];
```
###3.获取扫描结果
扫描结果可以从RJScanViewController中的一下方法中获取
```objc
- (void)scanResultWithArray:(NSArray<RJScanResult*>*)array
```
