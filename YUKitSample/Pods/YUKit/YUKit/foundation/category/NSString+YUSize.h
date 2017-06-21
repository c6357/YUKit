//
//  NSString+YUSize.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/10/13.
//  Copyright © 2015年 BruceYu. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface NSString (YUSize)

- (CGSize)getStringSizeWithfont:(UIFont *)font;


- (CGSize)getStringSizeWithfont:(UIFont *)font width:(CGFloat)width;


- (CGSize)getStringSizeWithWidth:(CGFloat)width attributes:(NSDictionary *)attributes;


- (CGSize)getStringSizeWithfont:(UIFont *)font height:(CGFloat)height;


/**
 *  计算富文本字体高度
 *
 *  @param lineSpeace 行高
 *  @param font       字体
 *  @param width      字体所占宽度
 *
 *  @return 富文本高度
 */
- (CGSize)getAttributesStringSizeWithFont:(UIFont*)font lineSpeace:(CGFloat)lineSpeace withWidth:(CGFloat)width;

@end
