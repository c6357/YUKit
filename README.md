
YUKit
=================
* IOS快速开发框架
* 针对常用开发框架的一些类别和扩展，方便快速开发
* 本库采用ARC

header
=================
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
   * AddressBook       简单获取手机通讯录
   * map                 地图常用转换
   * runtime             runtime常用方法


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
*YUDBFramework

   DBOBject 使用runtime + fmdb 封装
 
    1.自动建表
 
    2.自动检查增删表字段
 
    3.自定义数据库名，文件路径
 
    4.支持一对一对象数据库存储，清缓存简单方便
 
    5.支持多路径，多数据库关联查询
 
    6.一键保存、修改、删除、查找、多级关联查询解析、反序列化
 
    7.支持数据解析序列化、反序列化、json -> model  and  model ->json
 



pod search YUKit


