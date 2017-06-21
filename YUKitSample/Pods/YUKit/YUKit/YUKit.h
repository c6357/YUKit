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
YUKIT_STATIC_INLINE CGFloat const AppScreenScale(){return [UIScreen mainScreen].scale;}
YUKIT_STATIC_INLINE CGFloat const AppOnePhysicalPx(){return (CGFloat)1.f/AppScreenScale();}
YUKIT_STATIC_INLINE CGSize  const AppScreenSize(){return [UIScreen mainScreen].currentMode.size;}
YUKIT_STATIC_INLINE CGFloat const AppScreenWidth(){return AppScreenSize().width;}
YUKIT_STATIC_INLINE CGFloat const AppScreenHeight(){return AppScreenSize().height;}

#pragma mark -
#pragma mark - 应用尺寸
YUKIT_STATIC_INLINE CGFloat const AppWidth(){return [[UIScreen mainScreen]applicationFrame].size.width;}
YUKIT_STATIC_INLINE CGFloat const AppHeight(){return [[UIScreen mainScreen]applicationFrame].size.height;}

#pragma mark -
#pragma mark - sysInfo
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
YUKIT_STATIC_INLINE NSString *const AppVersion(){
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
YUKIT_STATIC_INLINE NSString *const AppBuildVersion(){
     return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}
YUKIT_STATIC_INLINE NSString *const AppBundleName(){
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
}
YUKIT_STATIC_INLINE NSString *const AppIdentifier(){
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}
YUKIT_STATIC_INLINE NSURL    *const AppDocumentsURL(){
    return [[[NSFileManager defaultManager]
             URLsForDirectory:NSDocumentDirectory
             inDomains:NSUserDomainMask] lastObject];
}
YUKIT_STATIC_INLINE NSString *const AppDocumentsPath(){
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}
YUKIT_STATIC_INLINE NSURL    *const AppCachesURL(){
    return [[[NSFileManager defaultManager]
             URLsForDirectory:NSCachesDirectory
             inDomains:NSUserDomainMask] lastObject];
}
YUKIT_STATIC_INLINE NSString *const AppCachesPath(){
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}
YUKIT_STATIC_INLINE NSURL    *const AppLibraryURL(){
    return [[[NSFileManager defaultManager]
             URLsForDirectory:NSLibraryDirectory
             inDomains:NSUserDomainMask] lastObject];
}
YUKIT_STATIC_INLINE NSString *const AppLibraryPath(){
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
}

YUKIT_STATIC_INLINE NSString *const AppBundlePath(){
    return [[NSBundle mainBundle] bundlePath];
}

YUKIT_EXTERN NSString   *AppBundleSeedID();

YUKIT_EXTERN NSString   *AppSchema();
YUKIT_EXTERN NSString   *AppSchemaWithName(NSString *name);

YUKIT_EXTERN int64_t    AppMemoryUsage();
YUKIT_EXTERN CGFloat    AppCpuUsage();

#endif
#endif

#pragma mark -
#pragma mark - Device Information
YUKIT_EXTERN NSString   *DeviceCurrentLanguage();
YUKIT_EXTERN NSString   *DeviceModel();
YUKIT_EXTERN NSString   *DeviceUuid();
YUKIT_EXTERN NSString   *DeviceLocalhost();

YUKIT_EXTERN NSString   *DeviceMachineModel();
YUKIT_EXTERN NSString   *DeviceMachineModelName();
YUKIT_EXTERN NSString   *DeviceSystemUptime();

#pragma mark -
#pragma mark - Network Information
//Get the MAC Address of the iPhone
//@return NSString represents the MAC address
YUKIT_EXTERN NSString   *DeviceMacAddress();

YUKIT_EXTERN NSString   *DeviceIpAddressWifi();
YUKIT_EXTERN NSString   *DeviceIpAddressCell();

YUKIT_EXTERN BOOL       isConnectedViaWiFi ();
YUKIT_EXTERN BOOL       isConnectedVia3G ();

#pragma mark -
#pragma mark - Disk Space
//(-1 when error occurs)
YUKIT_EXTERN int64_t    DeviceDiskSpace();
YUKIT_EXTERN int64_t    DeviceDiskSpaceFree();
YUKIT_EXTERN int64_t    DeviceDiskSpaceUsed();

#pragma mark -
#pragma mark - Memory Information
//(-1 when error occurs)
YUKIT_EXTERN int64_t    DeviceMemoryTotal();
YUKIT_EXTERN int64_t    DeviceMemoryUsed();
YUKIT_EXTERN int64_t    DeviceMemoryFree();
YUKIT_EXTERN int64_t    DeviceMemoryActive();
YUKIT_EXTERN int64_t    DeviceMemoryInactive();
YUKIT_EXTERN int64_t    DeviceMemoryWired();
YUKIT_EXTERN int64_t    DeviceMemoryPurgable();


#pragma mark - CPU Information
YUKIT_EXTERN NSInteger  DeviceCpuCount();
YUKIT_EXTERN CGFloat    DeviceCpuUsage();
/// Current CPU usage per processor (array of NSNumber), 1.0 means 100%. (nil when error occurs)
YUKIT_EXTERN NSArray    *DeviceCpuUsagePerProcessor();
YUKIT_EXTERN NSString   *DeviceSystemVersion();
YUKIT_EXTERN NSString   *JailbreakerString()NS_AVAILABLE_IOS(4_0);


#pragma mark -
#pragma mark - check sysInfo

YUKIT_EXTERN BOOL isJailbrokenUser()NS_AVAILABLE_IOS(4_0);// 是否越狱用户
YUKIT_EXTERN BOOL isPiratedUser();
YUKIT_EXTERN BOOL isBeingDebugged();
YUKIT_EXTERN BOOL isSimulator();
YUKIT_EXTERN BOOL iscanMakePhoneCalls();


YUKIT_STATIC_INLINE BOOL isiTV()NS_ENUM_AVAILABLE_IOS(9_0)
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomTV);
}
YUKIT_STATIC_INLINE BOOL isiPad()NS_ENUM_AVAILABLE_IOS(3_2)
{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
}
YUKIT_STATIC_INLINE BOOL isiPhone()NS_ENUM_AVAILABLE_IOS(3_2)
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
}
YUKIT_STATIC_INLINE BOOL isRtina()NS_AVAILABLE_IOS(4_0){
    return ([[UIScreen mainScreen] scale] >= 2.0);
}

#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
// NSOrderedSame = 0 完全一样
// NSOrderedAscending = -1 <
// NSOrderedDescending = +1 >
//==版本v
YUKIT_STATIC_INLINE BOOL SYSTEM_VERSION_EQUAL_TO(NSString *v) {
    return ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame);
}
//>版本v
YUKIT_STATIC_INLINE BOOL SYSTEM_VERSION_GREATER_THAN(NSString *v) {
    return ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending);
}
//>=版本v
YUKIT_STATIC_INLINE BOOL SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(NSString *v) {
    return ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending);
}
///<
YUKIT_STATIC_INLINE BOOL SYSTEM_VERSION_LESS_THAN(NSString *v) {
    return ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending);
}
///<=版本v
YUKIT_STATIC_INLINE BOOL SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(NSString *v) {
    return ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending);
}
YUKIT_STATIC_INLINE BOOL isiOS7(){return SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0");}

YUKIT_STATIC_INLINE BOOL isiOS8(){return SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0");}

YUKIT_STATIC_INLINE BOOL isiOS9(){return SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0");}

YUKIT_STATIC_INLINE BOOL isiOS10(){return SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0");}


YUKIT_STATIC_INLINE BOOL isScreenSizeEqualTo(CGSize size);
YUKIT_EXTERN BOOL isRequiresPhoneOS();

YUKIT_EXTERN BOOL isScreen320x480();    // ip4
YUKIT_EXTERN BOOL isScreen640x960();    // ip4s
YUKIT_EXTERN BOOL isScreen640x1136();   // ip5 ip5s ip6Zoom mode
YUKIT_EXTERN BOOL isScreen750x1334();   // ip6 ip7
YUKIT_EXTERN BOOL isScreen1242x2208();  // ip6p ip7p

YUKIT_EXTERN BOOL isScreen1125x2001();  // ip6pZoom mode
YUKIT_EXTERN BOOL isScreen768x1024();
YUKIT_EXTERN BOOL isScreen1536x2048();


//YUKIT_STATIC_INLINE BOOL iPhone4(){
//    return isScreen640x960();
//}
//YUKIT_STATIC_INLINE BOOL iPhone5(){
//    return isScreen640x1136();
//}
//

YUKIT_STATIC_INLINE BOOL iPhone6bef(){
    return AppScreenWidth() <= 640;
}


#endif


#pragma mark -
#pragma mark - NSLog -
YUKIT_STATIC_INLINE void LogFrame(CGRect frame){
    NSLog(@"frame[X=%.1f,Y=%.1f,W=%.1f,H=%.1f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
}
YUKIT_STATIC_INLINE void LogPoint(CGPoint point){
    NSLog(@"point [X=%.1f,Y=%.1f",point.x,point.y);
}

#pragma mark -
#pragma mark - Block -
typedef void (^NillBlock_Nill)(void);
typedef void (^NillBlock_BOOL)(BOOL);
typedef void (^NillBlock_Double)(double process);
typedef void (^NillBlock_OBJ)(id obj);
typedef void (^NillBlock_OBJ_BOOL)(id obj,BOOL result);
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


YUKIT_STATIC_INLINE void BACK(dispatch_block_t block){
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}
YUKIT_STATIC_INLINE void MAIN(dispatch_block_t block){
    dispatch_async(dispatch_get_main_queue(),block);
}
YUKIT_STATIC_INLINE void AFTER(int delayInSeconds,dispatch_block_t block){
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}


#pragma mark -
#pragma mark - DateFormat
FOUNDATION_EXPORT NSString * const  dateFormatNill;
FOUNDATION_EXPORT NSString * const  dateDefaultFormat;
FOUNDATION_EXPORT NSString * const  dateDefaultFormat_SSS;


YUKIT_EXTERN id SafeObj(id obj);
YUKIT_EXTERN BOOL isSafeObj(id obj);
    
YUKIT_EXTERN BOOL isSafeString(NSString*);
YUKIT_EXTERN NSString* SafeString(NSString*);
YUKIT_EXTERN NSString* ComboString(NSString*,...);
YUKIT_EXTERN NSString* AppendString(NSString*,NSString*);


YUKIT_EXTERN BOOL isSafeArray(NSArray *);


#endif
