//
//  YUKit
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#ifndef YUKit_YUKit_h
#define YUKit_YUKit_h

#import <stdio.h>
#import <UIKit/UIKit.h>
#import "YUMacro.h"

#ifdef __cplusplus
#define YUKIT_EXTERN		extern "C" __attribute__((visibility ("default")))
#else
#define YUKIT_EXTERN	        extern __attribute__((visibility ("default")))
#endif
#ifndef YUKIT_STATIC_INLINE
#define YUKIT_STATIC_INLINE	static inline
#endif

#if 0
#ifndef private_dictCustomerProperty
#define private_dictCustomerProperty
#endif
#endif



/**
 *  sysInfo
 */
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR || TARGET_OS_MAC)
#pragma mark -
#pragma mark - 设备屏幕尺寸
YUKIT_EXTERN CGSize  APP_ScreenSize();
YUKIT_EXTERN CGFloat APP_Screen_Width();
YUKIT_EXTERN CGFloat APP_Screen_Height();

#pragma mark -
#pragma mark - 应用尺寸
YUKIT_EXTERN CGFloat APP_WIDTH();
YUKIT_EXTERN CGFloat APP_HEIGHT();

#pragma mark -
#pragma mark - sysInfo
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
YUKIT_EXTERN NSString *APP_Version();
YUKIT_EXTERN NSString *APP_BuildVersion();
YUKIT_EXTERN NSString *APP_BundleName();
YUKIT_EXTERN NSString *APP_Identifier();
YUKIT_EXTERN NSString *APP_BundleSeedID();

YUKIT_EXTERN NSString *APP_Schema();
YUKIT_EXTERN NSString *APP_SchemaWithName(NSString *name);

YUKIT_EXTERN NSURL *APP_DocumentsURL();
YUKIT_EXTERN NSString *APP_DocumentsPath();

YUKIT_EXTERN NSURL *APP_CachesURL();
YUKIT_EXTERN NSString *APP_CachesPath();

YUKIT_EXTERN NSURL *APP_LibraryURL();
YUKIT_EXTERN NSString *APP_LibraryPath();

YUKIT_EXTERN int64_t APP_MemoryUsage();
YUKIT_EXTERN float APP_CpuUsage();

#endif
#endif

#pragma mark -
#pragma mark - Device Information
YUKIT_EXTERN NSString *Device_CurrentLanguage();
YUKIT_EXTERN NSString *Device_Model();
YUKIT_EXTERN NSString *Device_UUID();
YUKIT_EXTERN NSString *Device_LocalHost();

YUKIT_EXTERN NSString *Device_MachineModel();
YUKIT_EXTERN NSString *Device_MachineModelName();
YUKIT_EXTERN NSString *Device_SystemUptime();

#pragma mark -
#pragma mark - Network Information
//Get the MAC Address of the iPhone
//@return NSString represents the MAC address
YUKIT_EXTERN NSString *Device_MacAddress();

YUKIT_EXTERN NSString *Device_IpAddressWIFI();
YUKIT_EXTERN NSString *Device_IpAddressCell();

YUKIT_EXTERN BOOL isConnectedViaWiFi ();
YUKIT_EXTERN BOOL isConnectedVia3G ();

#pragma mark -
#pragma mark - Disk Space
//(-1 when error occurs)
YUKIT_EXTERN int64_t Device_DiskSpace();
YUKIT_EXTERN int64_t Device_DiskSpaceFree();
YUKIT_EXTERN int64_t Device_DiskSpaceUsed();

#pragma mark -
#pragma mark - Memory Information
//(-1 when error occurs)
YUKIT_EXTERN int64_t Device_MemoryTotal();
YUKIT_EXTERN int64_t Device_MemoryUsed();
YUKIT_EXTERN int64_t Device_MemoryFree();
YUKIT_EXTERN int64_t Device_MemoryActive();
YUKIT_EXTERN int64_t Device_MemoryInactive();
YUKIT_EXTERN int64_t Device_MemoryWired();
YUKIT_EXTERN int64_t Device_MemoryPurgable();


#pragma mark - CPU Information
YUKIT_EXTERN NSInteger Device_CpuCount();
YUKIT_EXTERN float Device_CpuUsage();
/// Current CPU usage per processor (array of NSNumber), 1.0 means 100%. (nil when error occurs)
YUKIT_EXTERN NSArray *Device_CpuUsagePerProcessor();


#pragma mark -
#pragma mark - check sysInfo
YUKIT_EXTERN NSString *Device_SystemVersion();
YUKIT_EXTERN NSString *jailBreaker()NS_AVAILABLE_IOS(4_0);
YUKIT_EXTERN BOOL isJailbrokenUser()NS_AVAILABLE_IOS(4_0);// 是否越狱用户
YUKIT_EXTERN BOOL isPiratedUser();
YUKIT_EXTERN BOOL isBeingDebugged();
YUKIT_EXTERN BOOL isSimulator();
YUKIT_EXTERN BOOL iscanMakePhoneCalls();


YUKIT_EXTERN BOOL isiTV()NS_ENUM_AVAILABLE_IOS(9_0);
YUKIT_EXTERN BOOL isiPad()NS_ENUM_AVAILABLE_IOS(3_2);
YUKIT_EXTERN BOOL isiPhone()NS_ENUM_AVAILABLE_IOS(3_2);
YUKIT_EXTERN BOOL isRtina()NS_AVAILABLE_IOS(4_0);



#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
YUKIT_EXTERN BOOL isiOS7();
YUKIT_EXTERN BOOL isiOS8();
YUKIT_EXTERN BOOL isiOS9();

YUKIT_STATIC_INLINE BOOL isScreenSizeEqualTo(CGSize size);
YUKIT_EXTERN BOOL isRequiresPhoneOS();
YUKIT_EXTERN BOOL isScreen320x480();    // ip4
YUKIT_EXTERN BOOL isScreen640x960();    // ip4s
YUKIT_EXTERN BOOL isScreen640x1136();   // ip5 ip5s ip6Zoom mode
YUKIT_EXTERN BOOL isScreen750x1334();   // ip6
YUKIT_EXTERN BOOL isScreen1242x2208();  // ip6p
YUKIT_EXTERN BOOL isScreen1125x2001();  // ip6pZoom mode
YUKIT_EXTERN BOOL isScreen768x1024();
YUKIT_EXTERN BOOL isScreen1536x2048();
#endif


#pragma mark -
#pragma mark - NSLog -
YUKIT_EXTERN void LogFrame(CGRect frame);
YUKIT_EXTERN void LogPoint(CGPoint point);


#pragma mark -
#pragma mark - Block -
typedef void (^NillBlock_Nill)(void);
typedef void (^NillBlock_BOOL)(BOOL);
typedef void (^NillBlock_Double)(double process);
typedef void (^NillBlock_OBJ)(id obj);
typedef void (^NillBlock_Integer)(NSInteger Count);
typedef void (^NillBlock_Error)(NSError *err);
typedef void (^NillBlock_OI)(id obj,int state);
typedef void (^NillBlock_OB)(id obj,BOOL result);


typedef void (^NillBlock_OBB) (NSObject *obj,BOOL nextEnabled,BOOL isOffLine);

typedef void (^Block_JsonParser)(id dataDict);
typedef void (^Block_Next_JsonParser)(BOOL next,id dataDict);
typedef void (^Block_PageJsonParser)(id dataDict,id pageDict);

typedef void (^Block_Next_MaxTime_JsonParser)(BOOL next,id maxTime, id dataDict);
typedef void (^Block_MaxTime_JsonParser)(id maxTime,id dataDict);

typedef NSArray* (^Block_Dealize_Parser)(NSArray *array);
typedef UITableViewCell* (^Block_CreateCell)(NSString *identify);
typedef NSObject* (^ObjBlockNill)(void);

#pragma mark -
#pragma mark - DateFormat
YUKIT_EXTERN NSString * const  YU_DateFormatNill;
YUKIT_EXTERN NSString * const  YU_DefaultDateFormat;
YUKIT_EXTERN NSString * const  YU_DefaultDateFormat_SSS;

YUKIT_EXTERN NSString * const  YU_DateFormat_01;
YUKIT_EXTERN NSString * const  YU_DateFormat_02;
YUKIT_EXTERN NSString * const  YU_DateFormat_03;
YUKIT_EXTERN NSString * const  YU_DateFormat_04;
YUKIT_EXTERN NSString * const  YU_DateFormat_05;
YUKIT_EXTERN NSString * const  YU_DateFormat_06;

YUKIT_EXTERN NSString * const  YU_DateFormat01;
YUKIT_EXTERN NSString * const  YU_DateFormat02;
YUKIT_EXTERN NSString * const  YU_DateFormat03;
YUKIT_EXTERN NSString * const  YU_DateFormat04;
YUKIT_EXTERN NSString * const  YU_DateFormat05;

YUKIT_EXTERN NSString * const  YU_DateFormat一;
YUKIT_EXTERN NSString * const  YU_DateFormat二;

#endif
