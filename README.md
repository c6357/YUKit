YUKit
=========
iOS轻量级快速开发基础框架

[![Travis branch](https://img.shields.io/travis/rust-lang/rust/master.svg)](https://github.com/c6357/YUKit)
[![CocoaPods](https://img.shields.io/cocoapods/v/YUKit.svg)](https://github.com/c6357/YUKit)


![image](https://github.com/c6357/YUKit/blob/master/sample.gif)
</br>
#![image](https://github.com/c6357/YUKit/blob/master/sample2.gif)

##### YUKit.h (c++封装的常用基础工具)
----

* YUKit for iOS
* 针对常用开发框架的一些类别和扩展，方便快速开发
* 本库采用ARC


目录介绍
=================

* header
* foundation
* uikit
* framework

YUKit.h
=================
* 设备信息
* APP信息
* 通用模板

foundation
=================
* category (Objective-C 之 Foundation框架的扩展类别)

* lib (Objective-C 之 Foundation框架的封装库)
	 * map					地图坐标转换
	 * YUGCDObj			GCD的一个封装

uikit
=================
* category (Objective-C 之 UIKit框架的扩展类别)

* lib (Objective-C 之 UIKit框架的封装库)
   * YUSettingCell            自定义cell (仿系统设置)
   * YUTextView               支持placeholder 自适应高度
   * YUAmountTextField        金额输入TextField
   * YUTableViewCell          支持编辑模式







framework
=================
* YUDBMOdel.Framework


 

 
 
安装使用
=================

* 手动复制文件YUKit到指定目录

* 使用Cocoapods管理

    pod search YUKit  
  
![image](https://github.com/c6357/YUKit/blob/master/install.png)

###Podfile
    pod 'YUKit', '~> 2.0.3'


系统要求
=================
####最低支持 iOS 7.0 或更高版本
 
 
关于
=================
####YUkit扫描通过已上传CocoaPods


许可证
=================
####YUKit 使用 MIT 许可证，详情见 LICENSE 文件
 
 
