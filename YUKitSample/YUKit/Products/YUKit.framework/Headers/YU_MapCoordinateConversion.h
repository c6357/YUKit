//
//  YU_MapCoordinateConversion.hpp
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/10/14.
//  Copyright © 2015年 BruceYu. All rights reserved.
//

#ifndef YU_MapCoordinateConversion_hpp
#define YU_MapCoordinateConversion_hpp


void bd_encrypt(double gg_lat, double gg_lon, double &bd_lat, double &bd_lon);


void bd_decrypt(double bd_lat, double bd_lon, double &gg_lat, double &gg_lon);



#endif /* YU_MapCoordinateConversion_hpp */
