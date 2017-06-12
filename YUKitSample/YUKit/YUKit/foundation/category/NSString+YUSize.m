//
//  NSString+YUSize.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/10/13.
//  Copyright © 2015年 BruceYu. All rights reserved.
//


#import "NSString+YUSize.h"
#import "YUKit.h"

@implementation NSString (YUSize)

- (CGSize)getStringSizeWithfont:(UIFont *)font{
    
    return [self getStringSizeWithfont:font width:AppWidth()];
}

- (CGSize)getStringSizeWithfont:(UIFont *)font width:(CGFloat)width
{
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, 0)  options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    
    return CGSizeMake(ceilf(size.width), ceilf(size.height));
}

- (CGSize)getStringSizeWithfont:(UIFont *)font height:(CGFloat)height
{
    CGSize size = [self boundingRectWithSize:CGSizeMake(0, height)  options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    
    return CGSizeMake(ceilf(size.width), ceilf(size.height));
}


- (CGSize)getStringSizeWithWidth:(CGFloat)width attributes:(NSDictionary *)attributes
{
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, 0)  options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    return CGSizeMake(ceilf(size.width), ceilf(size.height));
}


- (CGSize)getAttributesStringSizeWithFont:(UIFont*)font lineSpeace:(CGFloat)lineSpeace withWidth:(CGFloat)width{
    
    NSString *str = self?self:@"";
    
    //    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:str];
    //
    //    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    //
    //    style.lineSpacing = lineSpeace;
    //
    //    [style setAlignment:NSTextAlignmentLeft];
    //
    //    [attributeString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, str.length)];
    //
    //    [attributeString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, str.length)];
    //
    //    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    //
    //    CGRect rect = [attributeString boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:options context:nil];
    //
    //    NSLog(@"size:%@", NSStringFromCGSize(rect.size));
    
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    //    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    /** 行高 */
    paraStyle.lineSpacing = lineSpeace;
    
    [paraStyle setAlignment:NSTextAlignmentLeft];
    
    // NSKernAttributeName字体间距
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle
                          };
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:   NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    
    return size;
}

@end
