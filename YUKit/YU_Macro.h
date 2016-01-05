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
 
 这个文件待废弃
 
 */















#define PRODUCER_IOS__CAPTURE (__IPHONE_OS_VERSION_MIN_REQUIRED > __IPHONE_6_1 )

#define IsSafeStringPlus(a)             ((a)\
&&(![(a) isEqual:[NSNull null]]) &&((a).length>0)\
&&!([[NSString stringWithFormat:@"%@",(a)] isEqualToString:@"<null>"])\
&&!([[NSString stringWithFormat:@"%@",(a)] isEqualToString:@"(null)"]))

#define TrToString(args)[NSString stringWithFormat:@"%@",args]





//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)




//设置需要粘贴的文字或图片
#define PasteString(string)   [[UIPasteboard generalPasteboard] setString:string];
#define PasteImage(image)     [[UIPasteboard generalPasteboard] setImage:image];


//---------------------打印日志--------------------------
//Debug模式下打印日志,当前行,函数名
#if DEBUG
#define DBUGLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif


//Debug模式下打印日志,当前行,函数名 并弹出一个警告
#ifdef DEBUG
#   define  WDLog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else
#   define NSLog(...)
#endif

//---------------------打印日志--------------------------




#pragma mark - Sample Macro Define -

#define SAFE_BLOCK_CALL(b,p)        (b==nil?:b(p))
#define SAFE_BLOCK_CALL_VOID(b)     (b==nil?:b())


#define IsSafeArray(a)              ((a)&&(![(a) isEqual:[NSNull null]]) &&((a).count>0))
#define IsSafeString(a)             ((a)&& (![(a) isEqual:[NSNull null]]) &&((a).length>0))
#define SafeString(a)               ((((a)==nil)||([(a) isEqual:[NSNull null]])||((a).length==0))?@"":(a))

#define LongConvertToString(x) ((x)==-1?@"":[NSString stringWithFormat:@"%ld",((long)x)])
#define IntToString(x) ((x)==NOT_DEFINED?@"":[NSString stringWithFormat:@"%d",((int)x)])
#define L2S(x) LongConvertToString(x)
#define I2S(x) IntToString(x)


#define UpdateStatus(name,value)    (name=(name)|(1<<(value)))
#define RestoreStatus(name,value)   (name=(name)&~(1<<(value)))
#define IsInStatus(name,value)      ((name)&(1<<(value)))


#define AddNotification(notifiName,notifiSelector) \
[[NSNotificationCenter defaultCenter] addObserver:self selector:(notifiSelector) name:(notifiName) object:nil]
#define PostNotification(notifiName,obj) \
[[NSNotificationCenter defaultCenter] postNotificationName:notifiName object:obj]

#define RemoveNotification(notifiName)     \
[[NSNotificationCenter defaultCenter] removeObserver:self \
name:notifiName \
object:nil]
#define RemoveAllNotification()     \
[[NSNotificationCenter defaultCenter] removeObserver:self]


#define WarnIgnore_Deprecate(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)




#endif
