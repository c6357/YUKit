//
//  YU_APP.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/7.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AudioToolbox/AudioToolbox.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

typedef void (^NillBlock_Asset)(ALAsset* obj);

/**
 *系统震动
 */
UIKIT_EXTERN  void yu_system_vibrate();


/**
 *系统声音
 */
UIKIT_EXTERN  void yu_system_sound();


/**
 *系统拨号

 @param phoneNo 电话号码
 */
UIKIT_EXTERN  void yu_system_call(NSString *phoneNo);


/**
 *系统safari打开一个网址

 @param url 网址
 */
UIKIT_EXTERN  void yu_system_openURL(NSString *url);


/**
 *程序中播放一段简短的音乐

 @param  fName  @"MusicName"
 @param  ext  @"wav"@"mp3"..
 */
UIKIT_EXTERN  void yu_system_playSound(NSString *fName,NSString *ext);



/**
 *创建一个SystemSoundID
 @param soundName soundName
 @Returns a SystemSoundID.
 */
UIKIT_EXTERN  SystemSoundID yu_system_creatSoundIDWithSoundName(NSString *soundName);


/**
 *播放音效
 @param soundID soundID
 */
UIKIT_EXTERN  void yu_system_playSoundWithSoundID(SystemSoundID soundID);


/**
 *停止播放音效
 @param soundID soundID
 */
UIKIT_EXTERN  void yu_system_stopSoundWithSoundID(SystemSoundID soundID);


/**
 *获取运营商信息
 *其中isoCountryCode使用ISO 3166-1标准，参考：3166
 *mobileCountryCode(MCC)和mobileNetworkCode(MNC)可以参考：3166-1
 @return CTCarrier
 */
UIKIT_EXTERN  CTCarrier* yu_system_carrier(void);


/**
 *获取运营商名字

 @return 运营商名字
 */
UIKIT_EXTERN  NSString* yu_system_carrierName(void);




//+(void)getPhotoAlbum :(NillBlock_Asset)Asset;

