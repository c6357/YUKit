//
//  YU_WGS84TOGCJ02.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/10/14.
//  Copyright © 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface YU_WGS84TOGCJ02 : NSObject

//判断是否已经超出中国范围
+(BOOL)yu_isLocationOutOfChina:(CLLocationCoordinate2D)location;


//转GCJ-02
+(CLLocationCoordinate2D)yu_transformFromWGSToGCJ:(CLLocationCoordinate2D)wgsLoc;

@end
