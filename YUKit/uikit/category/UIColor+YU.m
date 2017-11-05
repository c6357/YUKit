//
//  UIColor+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/1.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "UIColor+YU.h"

UIColor* YU_RGB(CGFloat red, CGFloat green, CGFloat blue){
    return YU_UIColorWithRGBA(red, green, blue, 1.f);
}

UIColor* YU_RGBA(CGFloat red, CGFloat green, CGFloat blue ,CGFloat alpha){
    return YU_UIColorWithRGBA(red, green, blue, alpha);
}

UIColor* YU_UIColorWithRGB(CGFloat red, CGFloat green, CGFloat blue){
    return YU_UIColorWithRGBA(red, green, blue, 1.f);
}

UIColor* YU_UIColorWithRGBA(CGFloat red, CGFloat green, CGFloat blue ,CGFloat alpha){
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
}

UIColor* YU_UIColorWithHex(unsigned int hex){
    return [UIColor yu_colorWithHex:hex];
}

UIColor* YU_UIColorWithHexString(NSString* hexString){
    return [UIColor yu_colorWithHexString:hexString];
}


@implementation UIColor (YU)
- (CGFloat)yu_red {
    CGColorRef color          = self.CGColor;
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color)) != kCGColorSpaceModelRGB) {
        return -1.0f;
    }
    CGFloat const *components = CGColorGetComponents(color);
    return components[0];
}

- (CGFloat)yu_green {
    CGColorRef color          = self.CGColor;
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color)) != kCGColorSpaceModelRGB) {
        return -1.0f;
    }
    CGFloat const *components = CGColorGetComponents(color);
    return components[1];
}

- (CGFloat)yu_blue {
    CGColorRef color          = self.CGColor;
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color)) != kCGColorSpaceModelRGB) {
        return -1.0f;
    }
    CGFloat const *components = CGColorGetComponents(color);
    return components[2];
}

- (CGFloat)yu_alpha {
    return CGColorGetAlpha(self.CGColor);
}


+ (UIColor*)yu_whiteColorWithAlpha:(CGFloat)alphaValue
{
    return [UIColor yu_colorWithHex:0xffffff alpha:alphaValue];
}

+ (UIColor*)yu_blackColorWithAlpha:(CGFloat)alphaValue
{
    return [UIColor yu_colorWithHex:0x000000 alpha:alphaValue];
}

+ (UIColor*) yu_colorWithHex:(unsigned int)hex{
    return [UIColor yu_colorWithHex:hex alpha:1];
}

+ (UIColor*) yu_colorWithHex:(unsigned int)hex alpha:(CGFloat)alpha{
    
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0
                           green:((float)((hex & 0xFF00) >> 8)) / 255.0
                            blue:((float)(hex & 0xFF)) / 255.0
                           alpha:alpha];
}

+(UIColor*)yu_colorWithHexString:(NSString *)colorString
{
    NSString *cString = [[colorString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (UIColor*) yu_randomColor{

    int r                     = arc4random() % 255;
    int g                     = arc4random() % 255;
    int b                     = arc4random() % 255;
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];

}
@end
