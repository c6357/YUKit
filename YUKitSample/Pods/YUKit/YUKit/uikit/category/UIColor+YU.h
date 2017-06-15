//
//  UIColor+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/1.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

UIColor* UIColorMakeRGB(CGFloat red, CGFloat green, CGFloat blue);

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

@interface UIColor (YU)


+ (UIColor*)whiteColorWithAlpha:(CGFloat)alphaValue;


+ (UIColor*)blackColorWithAlpha:(CGFloat)alphaValue;


+(UIColor*)colorWithHexString:(NSString *)colorString;



+ (UIColor *)colorWithHex:(unsigned int)hex;


+ (UIColor *)colorWithHex:(unsigned int)hex alpha:(CGFloat)alpha;


+ (UIColor *)randomColor;


//颜色代码转RGB(如:ff9ab00)
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;


/**
 * 16进制颜色(html颜色值)字符串转为UIColor
 **/
+(UIColor *)hexStringToColor: (NSString *) stringToConvert;


/**
 The receiver's red component value. (read-only)
 
 The value of this property is a floating-point number in the range `0.0` to `1.0`. `-1.0` is returned if the color is
 not in the RGB colorspace.
 */
@property (nonatomic, assign, readonly) CGFloat red;

/**
 The receiver's green component value. (read-only)
 
 The value of this property is a floating-point number in the range `0.0` to `1.0`. `-1.0` is returned if the color is
 not in the RGB colorspace.
 */
@property (nonatomic, assign, readonly) CGFloat green;

/**
 The receiver's blue component value. (read-only)
 
 The value of this property is a floating-point number in the range `0.0` to `1.0`. `-1.0` is returned if the color is
 not in the RGB colorspace.
 */
@property (nonatomic, assign, readonly) CGFloat blue;

/**
 The receiver's alpha value. (read-only)
 
 The value of this property is a floating-point number in the range `0.0` to `1.0`, where `0.0` represents totally
 transparent and `1.0` represents totally opaque.
 */
@property (nonatomic, assign, readonly) CGFloat alpha;

@end
