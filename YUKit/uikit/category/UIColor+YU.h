//
//  UIColor+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/1.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN UIColor* YU_RGB(CGFloat red, CGFloat green, CGFloat blue);

UIKIT_EXTERN UIColor* YU_RGBA(CGFloat red, CGFloat green, CGFloat blue ,CGFloat alpha);

UIKIT_EXTERN UIColor* YU_UIColorWithRGB(CGFloat red, CGFloat green, CGFloat blue);

UIKIT_EXTERN UIColor* YU_UIColorWithRGBA(CGFloat red, CGFloat green, CGFloat blue ,CGFloat alpha);

UIKIT_EXTERN UIColor* YU_UIColorWithHex(unsigned int hex);
UIKIT_EXTERN UIColor* YU_UIColorWithHexString(NSString* hexString);



@interface UIColor (YU)
/**
 The receiver's red component value. (read-only)
 
 The value of this property is a floating-point number in the range `0.0` to `1.0`. `-1.0` is returned if the color is
 not in the RGB colorspace.
 */
@property (nonatomic, assign, readonly) CGFloat yu_red;

/**
 The receiver's green component value. (read-only)
 
 The value of this property is a floating-point number in the range `0.0` to `1.0`. `-1.0` is returned if the color is
 not in the RGB colorspace.
 */
@property (nonatomic, assign, readonly) CGFloat yu_green;

/**
 The receiver's blue component value. (read-only)
 
 The value of this property is a floating-point number in the range `0.0` to `1.0`. `-1.0` is returned if the color is
 not in the RGB colorspace.
 */
@property (nonatomic, assign, readonly) CGFloat yu_blue;

/**
 The receiver's alpha value. (read-only)
 
 The value of this property is a floating-point number in the range `0.0` to `1.0`, where `0.0` represents totally
 transparent and `1.0` represents totally opaque.
 */
@property (nonatomic, assign, readonly) CGFloat yu_alpha;



/**
 <#Description#>

 @param alphaValue <#alphaValue description#>
 @return <#return value description#>
 */
+ (UIColor*)yu_whiteColorWithAlpha:(CGFloat)alphaValue;


/**
 <#Description#>

 @param alphaValue <#alphaValue description#>
 @return <#return value description#>
 */
+ (UIColor*)yu_blackColorWithAlpha:(CGFloat)alphaValue;


/**
 *十六进制取颜色（0xFF0000）
 @param hex 十六进制
 */
+ (UIColor*) yu_colorWithHex:(unsigned int)hex;

+ (UIColor*) yu_colorWithHex:(unsigned int)hex alpha:(CGFloat)alpha;

/**
 *十六进制字符串取颜色（@"#0xFF0000"）
 @param colorString 十六进制
 */
+ (UIColor*)yu_colorWithHexString:(NSString *)colorString;


/**
 <#Description#>

 @return <#return value description#>
 */
+ (UIColor*) yu_randomColor;

@end
