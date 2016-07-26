Pod::Spec.new do |s|
  s.name         = "RJScanner"
  s.version      = "0.0.1"
  s.summary      = "二维码扫描"
  s.description  = <<-DESC
		    用系统自带的方法实现二维码扫描功能
                   DESC
  s.homepage     = "https://github.com/CapricornRJ/RJScanner"
  s.license      = "MIT"
  s.author       = {"CapricornRJ" => "714280578@qq.com"}
  s.platform     = :ios, "7.0"
  s.source       = {:git => "https://github.com/CapricornRJ/RJScanner.git", :tag => s.version}
  s.source_files = "RJScanner/RJScanViewController.{h,m}", "RJScanner/RJScanNative.{h,m}", "RJScanner/RJScanResult.{h,m}", "RJScanner/RJScanWrapper.{h,m}"
  s.resource     = 'MJRefresh/MJRefresh.bundle'
  s.requires_arc = true
end