![image](https://github.com/c6357/YUKit/blob/master/sample.gif)
</br>
#![image](https://github.com/c6357/YUKit/blob/master/sample2.gif)
YUKit
================= 
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
* base
* services
* framework

YUKit.h
=================
* 设备信息
* APP信息
* 通用模板

foundation
=================
* category (Objective-C 之 Foundation框架的类别)

* lib (Objective-C 之 Foundation框架的扩展)
   * AddressBook       简单获取手机通讯录
   * map                 地图常用转换
   * runtime             runtime常用方法

uikit
=================
* category (Objective-C 之 UIKit框架的类别)

* lib (Objective-C 之 UIKit框架的扩展)
   * YUSettingCell            自定义cell (仿系统设置)
   * YUTextView               支持placeholder 自适应高度
   * YUAmountTextField        金额输入TextField
   * YUTableViewCell          支持编辑模式



base
=================
* NavigationController
* TableView
* View
* ViewController
* ViewModel


services
=================
*  YUService (AFNetworking 使用示例)
*  NSJson
*  Reachability


framework
=================
* YUDBMOdel.Framework
https://github.com/c6357/YUDBModel

 

 
 
安装使用
=================

* 手动复制文件YUKit到指定目录

* 使用Cocoapods管理

    pod search YUKit  
  
![image](https://github.com/c6357/YUKit/blob/master/install.png)

###Podfile
    pod 'YUKit', '~> 1.2.2'

    pod 'YUKit', '~> 1.2.2', :inhibit_warnings => true

###dependency
    pod 'MJRefresh', '~> 3.1.0'

    pod 'Masonry', '~> 1.0.0'

    pod 'AFNetworking' , '~>3.1.0'

    #pod 'BlocksKit', '~> 2.2.5'


系统要求
=================
####最低支持 iOS 7.0
 
 
关于
=================
####YUkit扫描通过已上传CocoaPods


许可证
=================
####YUKit 使用 MIT 许可证，详情见 LICENSE 文件
 
 
