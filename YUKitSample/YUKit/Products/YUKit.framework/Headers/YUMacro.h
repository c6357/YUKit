//
//  YUMacro.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/1.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#ifndef YUKit_YUMacro_h
#define YUKit_YUMacro_h

/*
 
 待废弃
 
 */




///////////////////////////////////////////
// TODO
///////////////////////////////////////////

#define STRINGIFY(S) #S
#define PRAGMA_MESSAGE(MSG) _Pragma(STRINGIFY(message(MSG)))
//延时展开一次
#define DEFER_STRINGIFY(S) STRINGIFY(S)

#define FORMATTED_MESSAGE(MSG) "[TODO-" DEFER_STRINGIFY(__COUNTER__) "]" MSG "\n" \
DEFER_STRINGIFY(__FILE__) "\n" \
" line " DEFER_STRINGIFY(__LINE__)
#define KEYWORDIFY try{} @catch (...) {}

#define TODO(MSG) KEYWORDIFY PRAGMA_MESSAGE(FORMATTED_MESSAGE(MSG))



//---------------------打印日志--------------------------
//Debug模式下打印日志,当前行,函数名
#if DEBUG
#define DBUGLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif



#endif
