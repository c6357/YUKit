//
//  YUKit
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//
//1
#ifndef YUKit_YUKit_h
#define YUKit_YUKit_h

#import <stdio.h>
#import <UIKit/UIKit.h>
#import "YUMacro.h"

//! Project version number for YUKit.
FOUNDATION_EXPORT double YUKitVersionNumber;

//! Project version string for YUKit.
FOUNDATION_EXPORT const unsigned char YUKitVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <YUKit/PublicHeader.h>

#ifdef __cplusplus
#define YUKIT_EXTERN		extern "C" __attribute__((visibility ("default")))
#else
#define YUKIT_EXTERN	    extern __attribute__((visibility ("default")))
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
YUKIT_STATIC_INLINE CGFloat const YU_AppScreenScale(){return [UIScreen mainScreen].scale;}
YUKIT_STATIC_INLINE CGFloat const YU_AppOnePhysicalPx(){return (CGFloat)1.f/YU_AppScreenScale();}
YUKIT_STATIC_INLINE CGSize  const YU_AppScreenSize(){return [UIScreen mainScreen].currentMode.size;}
YUKIT_STATIC_INLINE CGFloat const YU_AppScreenWidth(){return YU_AppScreenSize().width;}
YUKIT_STATIC_INLINE CGFloat const YU_AppScreenHeight(){return YU_AppScreenSize().height;}

#pragma mark -
#pragma mark - 应用尺寸
YUKIT_STATIC_INLINE CGFloat const YU_AppWidth(){return [[UIScreen mainScreen]applicationFrame].size.width;}
YUKIT_STATIC_INLINE CGFloat const YU_AppHeight(){return [[UIScreen mainScreen]applicationFrame].size.height;}

#pragma mark -
#pragma mark - sysInfo
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
YUKIT_STATIC_INLINE NSString *const YU_AppVersion(){
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
YUKIT_STATIC_INLINE NSString *const YU_AppBuildVersion(){
     return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}
YUKIT_STATIC_INLINE NSString *const YU_AppBundleName(){
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
}
YUKIT_STATIC_INLINE NSString *const YU_AppIdentifier(){
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}
YUKIT_STATIC_INLINE NSURL    *const YU_AppDocumentsURL(){
    return [[[NSFileManager defaultManager]
             URLsForDirectory:NSDocumentDirectory
             inDomains:NSUserDomainMask] lastObject];
}
YUKIT_STATIC_INLINE NSString *const YU_AppDocumentsPath(){
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}
YUKIT_STATIC_INLINE NSURL    *const YU_AppCachesURL(){
    return [[[NSFileManager defaultManager]
             URLsForDirectory:NSCachesDirectory
             inDomains:NSUserDomainMask] lastObject];
}
YUKIT_STATIC_INLINE NSString *const YU_AppCachesPath(){
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}
YUKIT_STATIC_INLINE NSURL    *const YU_AppLibraryURL(){
    return [[[NSFileManager defaultManager]
             URLsForDirectory:NSLibraryDirectory
             inDomains:NSUserDomainMask] lastObject];
}
YUKIT_STATIC_INLINE NSString *const YU_AppLibraryPath(){
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
}

YUKIT_STATIC_INLINE NSString *const YU_AppBundlePath(){
    return [[NSBundle mainBundle] bundlePath];
}

YUKIT_EXTERN NSString   *YU_AppBundleSeedID(void);

YUKIT_EXTERN NSString   *YU_AppSchema(void);
YUKIT_EXTERN NSString   *YU_AppSchemaWithName(NSString *name);

YUKIT_EXTERN int64_t    YU_AppMemoryUsage(void);
YUKIT_EXTERN CGFloat    YU_AppCpuUsage(void);

#endif
#endif

#pragma mark -
#pragma mark - Device Information
YUKIT_EXTERN NSString   *YU_DeviceCurrentLanguage(void);
YUKIT_EXTERN NSString   *YU_DeviceModel(void);
YUKIT_EXTERN NSString   *YU_DeviceUuid(void);
YUKIT_EXTERN NSString   *YU_DeviceLocalhost(void);

YUKIT_EXTERN NSString   *YU_DeviceMachineModel(void);
YUKIT_EXTERN NSString   *YU_DeviceMachineModelName(void);
YUKIT_EXTERN NSString   *YU_DeviceSystemUptime(void);

#pragma mark -
#pragma mark - Network Information
//Get the MAC Address of the iPhone
//@return NSString represents the MAC address
YUKIT_EXTERN NSString   *YU_DeviceMacAddress(void);

YUKIT_EXTERN NSString   *YU_DeviceIpAddressWifi(void);
YUKIT_EXTERN NSString   *YU_DeviceIpAddressCell(void);

YUKIT_EXTERN BOOL       yu_isConnectedViaWiFi (void);
YUKIT_EXTERN BOOL       yu_isConnectedVia3G (void);

#pragma mark -
#pragma mark - Disk Space
//(-1 when error occurs)
YUKIT_EXTERN int64_t    YU_DeviceDiskSpace(void);
YUKIT_EXTERN int64_t    YU_DeviceDiskSpaceFree(void);
YUKIT_EXTERN int64_t    YU_DeviceDiskSpaceUsed(void);

#pragma mark -
#pragma mark - Memory Information
//(-1 when error occurs)
YUKIT_EXTERN int64_t    YU_DeviceMemoryTotal(void);
YUKIT_EXTERN int64_t    YU_DeviceMemoryUsed(void);
YUKIT_EXTERN int64_t    YU_DeviceMemoryFree(void);
YUKIT_EXTERN int64_t    YU_DeviceMemoryActive(void);
YUKIT_EXTERN int64_t    YU_DeviceMemoryInactive(void);
YUKIT_EXTERN int64_t    YU_DeviceMemoryWired(void);
YUKIT_EXTERN int64_t    YU_DeviceMemoryPurgable(void);


#pragma mark - CPU Information
YUKIT_EXTERN NSInteger  YU_DeviceCpuCount(void);
YUKIT_EXTERN CGFloat    YU_DeviceCpuUsage(void);
/// Current CPU usage per processor (array of NSNumber), 1.0 means 100%. (nil when error occurs)
YUKIT_EXTERN NSArray    *YU_DeviceCpuUsagePerProcessor(void);
YUKIT_EXTERN NSString   *YU_DeviceSystemVersion(void);
YUKIT_EXTERN NSString   *YU_JailbreakerString(void)NS_AVAILABLE_IOS(4_0);


#pragma mark -
#pragma mark - check sysInfo

YUKIT_EXTERN BOOL yu_isJailbrokenUser(void)NS_AVAILABLE_IOS(4_0);// 是否越狱用户
YUKIT_EXTERN BOOL yu_isPiratedUser(void);
YUKIT_EXTERN BOOL yu_isBeingDebugged(void);
YUKIT_EXTERN BOOL yu_isSimulator(void);
YUKIT_EXTERN BOOL yu_iscanMakePhoneCalls(void);


YUKIT_STATIC_INLINE BOOL yu_isiTV()NS_ENUM_AVAILABLE_IOS(9_0)
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomTV);
}
YUKIT_STATIC_INLINE BOOL yu_isiPad()NS_ENUM_AVAILABLE_IOS(3_2)
{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
}
YUKIT_STATIC_INLINE BOOL yu_isiPhone()NS_ENUM_AVAILABLE_IOS(3_2)
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
}
YUKIT_STATIC_INLINE BOOL yu_isRtina()NS_AVAILABLE_IOS(4_0){
    return ([[UIScreen mainScreen] scale] >= 2.0);
}

#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
// NSOrderedSame = 0 完全一样
// NSOrderedAscending = -1 <
// NSOrderedDescending = +1 >
//==版本v
YUKIT_STATIC_INLINE BOOL YU_SYSTEM_VERSION_EQUAL_TO(NSString *v) {
    return ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame);
}
//>版本v
YUKIT_STATIC_INLINE BOOL YU_SYSTEM_VERSION_GREATER_THAN(NSString *v) {
    return ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending);
}
//>=版本v
YUKIT_STATIC_INLINE BOOL YU_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(NSString *v) {
    return ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending);
}
///<
YUKIT_STATIC_INLINE BOOL YU_SYSTEM_VERSION_LESS_THAN(NSString *v) {
    return ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending);
}
///<=版本v
YUKIT_STATIC_INLINE BOOL YU_SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(NSString *v) {
    return ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending);
}
YUKIT_STATIC_INLINE BOOL yu_isiOS7(){return YU_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0");}

YUKIT_STATIC_INLINE BOOL yu_isiOS8(){return YU_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0");}

YUKIT_STATIC_INLINE BOOL yu_isiOS9(){return YU_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0");}

YUKIT_STATIC_INLINE BOOL yu_isiOS10(){return YU_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0");}

YUKIT_STATIC_INLINE BOOL yu_isiOS11(){return YU_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.0");}

YUKIT_STATIC_INLINE BOOL yu_isScreenSizeEqualTo(CGSize size);
YUKIT_EXTERN BOOL yu_isRequiresPhoneOS(void);

YUKIT_EXTERN BOOL yu_isScreen320x480(void);    // ip4
YUKIT_EXTERN BOOL yu_isScreen640x960(void);    // ip4s
YUKIT_EXTERN BOOL yu_isScreen640x1136(void);   // ip5 ip5s ip6Zoom mode
YUKIT_EXTERN BOOL yu_isScreen750x1334(void);   // ip6 ip7
YUKIT_EXTERN BOOL yu_isScreen1242x2208(void);  // ip6p ip7p

YUKIT_EXTERN BOOL yu_isScreen1125x2001(void);  // ip6pZoom mode
YUKIT_EXTERN BOOL yu_isScreen768x1024(void);
YUKIT_EXTERN BOOL yu_isScreen1536x2048(void);


//YUKIT_STATIC_INLINE BOOL iPhone4(){
//    return isScreen640x960();
//}
//YUKIT_STATIC_INLINE BOOL iPhone5(){
//    return isScreen640x1136();
//}
//

YUKIT_STATIC_INLINE BOOL yu_iPhone6bef(){
    return YU_AppScreenWidth() <= 640;
}


#endif


#pragma mark -
#pragma mark - NSLog -
YUKIT_STATIC_INLINE void YU_LogFrame(CGRect frame){
    NSLog(@"frame[X=%.1f,Y=%.1f,W=%.1f,H=%.1f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
}
YUKIT_STATIC_INLINE void YU_LogPoint(CGPoint point){
    NSLog(@"point [X=%.1f,Y=%.1f",point.x,point.y);
}

#pragma mark -
#pragma mark - Block -
typedef void (^YU_VoidBlock)(void);
typedef BOOL (^YU_BoolBlock)(void);
typedef int  (^YU_IntBlock) (void);
typedef id   (^YU_IDBlock)  (void);

typedef void (^YU_VoidBlock_Int)(int);
typedef BOOL (^YU_BoolBlock_Int)(int);
typedef int  (^YU_IntBlock_Int) (int);
typedef id   (^YU_IDBlock_Int)  (int);

typedef void (^YU_VoidBlock_String)(NSString *);
typedef BOOL (^YU_BoolBlock_String)(NSString *);
typedef int  (^YU_IntBlock_String) (NSString *);
typedef id   (^YU_IDBlock_String)  (NSString *);

typedef void (^YU_VoidBlock_Id)(id);
typedef BOOL (^YU_BoolBlock_Id)(id);
typedef int  (^YU_IntBlock_Id) (id);
typedef id   (^YU_IDBlock_Id)  (id);


typedef void (^YU_VoidBlock_BOOL)(BOOL);
typedef void (^YU_VoidBlock_Double)(double process);
typedef void (^YU_VoidBlock_Id_BOOL)(id obj,BOOL result);
typedef void (^YU_VoidBlock_Integer)(NSInteger Count);
typedef void (^YU_VoidBlock_Error)(NSError *err);
typedef void (^YU_VoidBlock_II)(id obj,int state);
typedef void (^YU_VoidBlock_IB)(id obj,BOOL result);


YUKIT_STATIC_INLINE void YU_BACK(dispatch_block_t block){
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}
YUKIT_STATIC_INLINE void YU_MAIN(dispatch_block_t block){
    dispatch_async(dispatch_get_main_queue(),block);
}
YUKIT_STATIC_INLINE void YU_AFTER(int delayInSeconds,dispatch_block_t block){
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}


#pragma mark -
#pragma mark - DateFormat
FOUNDATION_EXPORT NSString * const  yu_dateFormatNill;
FOUNDATION_EXPORT NSString * const  yu_dateDefaultFormat;
FOUNDATION_EXPORT NSString * const  yu_dateDefaultFormat_SSS;


YUKIT_EXTERN id YU_SafeObj(id obj);
YUKIT_EXTERN BOOL yu_isSafeObj(id obj);
    
YUKIT_EXTERN BOOL yu_isSafeString(NSString*);
YUKIT_EXTERN NSString* YU_SafeString(NSString*);
YUKIT_EXTERN NSString* YU_ComboString(NSString*,...);
YUKIT_EXTERN NSString* YU_AppendString(NSString*,NSString*);


YUKIT_EXTERN BOOL yu_isSafeArray(NSArray *);


#endif
