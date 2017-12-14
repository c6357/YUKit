//
//  NSAttributedString+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//


#import "NSAttributedString+YU.h"


@implementation NSAttributedString (YU)

+(CTParagraphStyleRef)yu_paragraphStyleRef{
    
    CTParagraphStyleSetting lineBreakMode;
    CTLineBreakMode lineBreak = kCTLineBreakByCharWrapping;
    lineBreakMode.spec = kCTParagraphStyleSpecifierLineBreakMode;
    lineBreakMode.value = &lineBreak;
    lineBreakMode.valueSize = sizeof(CTLineBreakMode);
    
    //段缩进
    CGFloat headindent = 0.0f;
    CTParagraphStyleSetting head;
    head.spec = kCTParagraphStyleSpecifierHeadIndent;
    head.value = &headindent;
    head.valueSize = sizeof(float);
    
    CGFloat fristlineindent = 0.0f;
    CTParagraphStyleSetting fristline;
    fristline.spec = kCTParagraphStyleSpecifierFirstLineHeadIndent;
    fristline.value = &fristlineindent;
    fristline.valueSize = sizeof(float);
    
    //对齐方式
    CTTextAlignment alignment = kCTJustifiedTextAlignment;
    CTParagraphStyleSetting alignmentStyle;
    alignmentStyle.spec=kCTParagraphStyleSpecifierAlignment;//指定为对齐属性
    alignmentStyle.valueSize=sizeof(alignment);
    alignmentStyle.value=&alignment;
    
    //行距
    CGFloat _linespace = 0.0f;
    CTParagraphStyleSetting lineSpaceSetting;
//    lineSpaceSetting.spec = kCTParagraphStyleSpecifierLineSpacing;
    lineSpaceSetting.value = &_linespace;
    lineSpaceSetting.valueSize = sizeof(float);
    
    CTParagraphStyleSetting settings[] = {
        lineBreakMode,fristline,head,alignmentStyle
    };
    CTParagraphStyleRef style = CTParagraphStyleCreate(settings, 4);
    
    return style;
}



@end
