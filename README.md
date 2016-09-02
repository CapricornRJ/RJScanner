# RJScanner
二维码扫描
==================
使用方法
------------------
###1.三行代码创建扫描控制器
```java
  RJScanViewController *scanViewController = [[RJScanViewController alloc] init];
  scanViewController.alertTitle = @"在电脑浏览器打开\n......\n并扫描页面中的二维码";
  [self.navigationController pushViewController:scanViewController animated:YES];
```
###2.获取扫描结果
扫描结果可以从RJScanViewController中的一下方法中获取
```java
- (void)scanResultWithArray:(NSArray<RJScanResult*>*)array
```
