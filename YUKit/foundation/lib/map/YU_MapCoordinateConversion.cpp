//
//  YU_MapCoordinateConversion.cpp
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/10/14.
//  Copyright © 2015年 BruceYu. All rights reserved.
//

#include <stdio.h>
#include <math.h>
#include "YU_MapCoordinateConversion.h"


/*
 1.国内各地图API坐标系统比较
 参考http://rovertang.com/labs/map-compare/
 结论是：
 API
 坐标系
 百度地图API
 百度坐标
 腾讯搜搜地图API
 火星坐标
 搜狐搜狗地图API
 搜狗坐标*
 阿里云地图API
 火星坐标
 图吧MapBar地图API
 图吧坐标
 高德MapABC地图API
 火星坐标
 灵图51ditu地图API
 火星坐标
 */

/*
 国际经纬度坐标标准为WGS-84,国内必须至少使用国测局制定的GCJ-02,对地理位置进行首次加密。百度坐标在此基础上，进行了BD-09二次加密措施,更加保护了个人隐私。百度对外接口的坐标系并不是GPS采集的真实经纬度，需要通过坐标转换接口进行转换。
 3.火星坐标系 (GCJ-02) 与百度坐标系 (BD-09) 的转换算法
 GCJ-02(火星坐标) 和 BD-09 （百度坐标）
 算法代码如下，其中 bd_encrypt 将 GCJ-02 坐标转换成 BD-09 坐标， bd_decrypt 反之。
 */


//地图经纬度及坐标系统转换的那点事
//http://www.biaodianfu.com/coordinate-system.html


const double x_pi = 3.14159265358979324 * 3000.0 / 180.0;
//火星转百度
void bd_encrypt(double gg_lat, double gg_lon, double &bd_lat, double &bd_lon)
{
    double x = gg_lon, y = gg_lat;
    double z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
    bd_lon = z * cos(theta) + 0.0065;
    bd_lat = z * sin(theta) + 0.006;
}


//百度转火星
void bd_decrypt(double bd_lat, double bd_lon, double &gg_lat, double &gg_lon)
{
    double x = bd_lon - 0.0065, y = bd_lat - 0.006;
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) - 0.000003 * cos(x * x_pi);
    gg_lon = z * cos(theta);
    gg_lat = z * sin(theta);
}